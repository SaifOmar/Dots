"""
Core payment service implementation.
"""
from decimal import Decimal
import stripe
from django.conf import settings
from django.db import transaction
from django.utils import timezone

from .constants import (
    MIN_PAYMENT_AMOUNT,
    CREDITS_TO_USD_RATE,
    DEFAULT_CURRENCY,
    PAYMENT_STATUS,
)
from .exceptions import (
    PaymentError,
    InsufficientCreditsError,
    PaymentValidationError,
    PaymentProcessingError,
)

class PaymentService:
    """
    Centralized service for handling all payment-related operations.
    """
    
    @classmethod
    def create_payment_intent(cls, user, credits_amount: Decimal) -> dict:
        """
        Creates a new payment intent for purchasing credits.
        
        Args:
            user: The user making the purchase
            credits_amount: Amount of credits to purchase
            
        Returns:
            dict: Payment intent details including client_secret
            
        Raises:
            PaymentValidationError: If the amount is invalid
            PaymentProcessingError: If Stripe operation fails
        """
        from clients.models import PaymentIntent, Credits
        
        try:
            credits_amount = Decimal(str(credits_amount))
            if credits_amount <= 0:
                raise PaymentValidationError("Credits amount must be positive")
                
            payment_amount = credits_amount * CREDITS_TO_USD_RATE
            stripe_amount = int(payment_amount * 100)  # Convert to cents
            
            if stripe_amount < int(MIN_PAYMENT_AMOUNT * 100):
                raise PaymentValidationError(
                    f"Minimum purchase amount is ${MIN_PAYMENT_AMOUNT} ({MIN_PAYMENT_AMOUNT} credit)"
                )
                
            with transaction.atomic():
                intent = stripe.PaymentIntent.create(
                    amount=stripe_amount,
                    currency=DEFAULT_CURRENCY,
                    metadata={
                        "user_id": user.id,
                        "credits_amount": str(credits_amount),
                        "type": "credit_purchase"
                    },
                    description=f"Credits purchase for {user.email}"
                )
                
                PaymentIntent.objects.create(
                    client=user,
                    stripe_payment_intent_id=intent.id,
                    amount=payment_amount,
                    credits_amount=credits_amount,
                    status=PAYMENT_STATUS['PENDING']
                )
                
                return {
                    "client_secret": intent.client_secret,
                    "payment_intent_id": intent.id,
                    "amount": payment_amount,
                    "credits_amount": credits_amount
                }
                
        except ValueError:
            raise PaymentValidationError("Invalid credits amount")
        except stripe.error.StripeError as e:
            raise PaymentProcessingError(f"Stripe error: {str(e)}")
        except Exception as e:
            raise PaymentError(f"Unexpected error: {str(e)}")
            
    @classmethod
    def confirm_payment(cls, user, payment_intent_id: str) -> dict:
        """
        Confirms a payment and credits the user's account.
        
        Args:
            user: The user who made the payment
            payment_intent_id: Stripe payment intent ID
            
        Returns:
            dict: Updated credit balance and status
            
        Raises:
            PaymentValidationError: If payment intent is invalid
            PaymentProcessingError: If payment confirmation fails
        """
        from clients.models import PaymentIntent, Credits
        
        try:
            with transaction.atomic():
                payment_record = PaymentIntent.objects.select_for_update().get(
                    stripe_payment_intent_id=payment_intent_id,
                    client=user
                )
                
                # Verify with Stripe
                stripe_intent = stripe.PaymentIntent.retrieve(payment_intent_id)
                
                if (stripe_intent.status == "succeeded" and 
                    payment_record.status != PAYMENT_STATUS['COMPLETED']):
                    
                    credits, _ = Credits.objects.get_or_create(
                        owner=user,
                        defaults={"amount": 0}
                    )
                    credits.amount += payment_record.credits_amount
                    credits.save()
                    
                    payment_record.status = PAYMENT_STATUS['COMPLETED']
                    payment_record.completed_at = timezone.now()
                    payment_record.save()
                    
                    return {
                        "message": "Credits added successfully",
                        "credits_balance": credits.amount,
                        "added_credits": payment_record.credits_amount
                    }
                    
                elif (stripe_intent.status == "succeeded" and 
                      payment_record.status == PAYMENT_STATUS['COMPLETED']):
                    return {
                        "message": "Payment already processed",
                        "credits_balance": Credits.objects.get(owner=user).amount
                    }
                else:
                    raise PaymentValidationError("Payment not completed")
                    
        except PaymentIntent.DoesNotExist:
            raise PaymentValidationError("Payment intent not found")
        except stripe.error.StripeError as e:
            raise PaymentProcessingError(f"Stripe error: {str(e)}")
        except Exception as e:
            raise PaymentError(f"Unexpected error: {str(e)}")
            
    @classmethod
    def process_withdrawal(cls, user, amount: Decimal) -> dict:
        """
        Processes a withdrawal request to user's connected Stripe account.
        
        Args:
            user: The user requesting withdrawal
            amount: Amount to withdraw
            
        Returns:
            dict: Withdrawal status and details
            
        Raises:
            PaymentValidationError: If withdrawal request is invalid
            PaymentProcessingError: If withdrawal fails
        """
        try:
            amount = Decimal(str(amount))
            if amount <= 0:
                raise PaymentValidationError("Withdrawal amount must be positive")
                
            if not user.stripe_account_id:
                raise PaymentValidationError("No Stripe account connected")
                
            # Convert to cents for Stripe
            stripe_amount = int(amount * 100)
            
            account = stripe.Account.retrieve(user.stripe_account_id)
            if not account.payouts_enabled:
                raise PaymentValidationError("Payouts are not enabled for this account")
                
            with transaction.atomic():
                transfer = stripe.Transfer.create(
                    amount=stripe_amount,
                    currency=DEFAULT_CURRENCY,
                    destination=user.stripe_account_id,
                    description=f"Withdrawal for {user.email}"
                )
                
                return {
                    "status": "completed",
                    "transfer_id": transfer.id,
                    "amount": amount
                }
                
        except stripe.error.StripeError as e:
            raise PaymentProcessingError(f"Stripe error: {str(e)}")
        except Exception as e:
            raise PaymentError(f"Unexpected error: {str(e)}")
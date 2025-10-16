"""
Additional payment service methods for delivery-related payments.
"""
from decimal import Decimal
from django.db import transaction
from .service import PaymentService
from .exceptions import PaymentValidationError, PaymentProcessingError
from .constants import DEFAULT_CURRENCY, PAYMENT_STATUS

class DeliveryPaymentService(PaymentService):
    @classmethod
    def create_order_payment_intent(cls, user, order_cost: Decimal, order_id: int) -> dict:
        """
        Creates a payment intent for an order.
        
        Args:
            user: The user making the payment
            order_cost: Cost of the order
            order_id: ID of the order being paid for
            
        Returns:
            dict: Payment intent details
        """
        try:
            stripe_amount = int(order_cost * 100)
            
            intent = cls._create_stripe_payment_intent(
                amount=stripe_amount,
                user=user,
                metadata={
                    'user_id': user.id,
                    'order_id': order_id,
                    'purpose': 'order_purchase'
                }
            )
            
            return {
                'status': 'payment_required',
                'message': 'Please complete payment to take this order.',
                'payment_intent_id': intent.id,
                'client_secret': intent.client_secret,
                'amount_due': order_cost
            }
            
        except Exception as e:
            raise PaymentProcessingError(f"Failed to create order payment: {str(e)}")
            
    @classmethod
    def process_order_payment(cls, user, payment_intent_id: str, order_id: int):
        """
        Processes and verifies an order payment.
        
        Args:
            user: The user making the payment
            payment_intent_id: Stripe payment intent ID
            order_id: ID of the order being paid for
            
        Returns:
            bool: True if payment was successful
            
        Raises:
            PaymentValidationError: If payment validation fails
        """
        try:
            stripe_intent = cls._verify_stripe_payment(payment_intent_id)
            
            if stripe_intent.status != 'succeeded':
                raise PaymentValidationError('Payment has not succeeded.')
                
            # Verify metadata
            metadata = stripe_intent.metadata
            if int(metadata.get('order_id', -1)) != order_id:
                raise PaymentValidationError('Payment intent does not match this order.')
                
            return True
            
        except Exception as e:
            raise PaymentProcessingError(f"Failed to process order payment: {str(e)}")
    
    @classmethod
    def _create_stripe_payment_intent(cls, amount: int, user, metadata: dict = None):
        """Creates a Stripe PaymentIntent with standard parameters."""
        return stripe.PaymentIntent.create(
            amount=amount,
            currency=DEFAULT_CURRENCY,
            metadata=metadata or {},
            description=f"Order payment for {user.email}"
        )
        
    @classmethod
    def _verify_stripe_payment(cls, payment_intent_id: str):
        """Verifies a Stripe payment intent."""
        return stripe.PaymentIntent.retrieve(payment_intent_id)
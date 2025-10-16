"""
Tests for payment service functionality.
"""
from decimal import Decimal
import pytest
from django.test import TestCase
from django.contrib.auth import get_user_model
from unittest.mock import patch, MagicMock

from payment_service import PaymentService
from payment_service.exceptions import PaymentValidationError, PaymentProcessingError
from clients.models import Credits, PaymentIntent

User = get_user_model()

class TestPaymentService(TestCase):
    def setUp(self):
        self.user = User.objects.create_user(
            username='testuser',
            email='test@example.com',
            password='testpass123'
        )
        
    @patch('stripe.PaymentIntent.create')
    def test_create_payment_intent(self, mock_create):
        # Setup mock
        mock_create.return_value = MagicMock(
            id='pi_test123',
            client_secret='secret_test123',
            status='requires_payment_method'
        )
        
        # Test successful creation
        result = PaymentService.create_payment_intent(self.user, Decimal('10.00'))
        
        assert result['payment_intent_id'] == 'pi_test123'
        assert result['client_secret'] == 'secret_test123'
        assert result['credits_amount'] == Decimal('10.00')
        
        # Verify PaymentIntent was created in DB
        payment_intent = PaymentIntent.objects.get(
            stripe_payment_intent_id='pi_test123'
        )
        assert payment_intent.client == self.user
        assert payment_intent.credits_amount == Decimal('10.00')
        
    def test_create_payment_intent_validation(self):
        # Test invalid amount
        with pytest.raises(PaymentValidationError):
            PaymentService.create_payment_intent(self.user, Decimal('-10.00'))
            
        with pytest.raises(PaymentValidationError):
            PaymentService.create_payment_intent(self.user, Decimal('0.00'))
            
    @patch('stripe.PaymentIntent.retrieve')
    def test_confirm_payment(self, mock_retrieve):
        # Setup
        payment_intent = PaymentIntent.objects.create(
            client=self.user,
            stripe_payment_intent_id='pi_test123',
            amount=Decimal('10.00'),
            credits_amount=Decimal('10.00'),
            status='pending'
        )
        
        # Setup mock
        mock_retrieve.return_value = MagicMock(
            id='pi_test123',
            status='succeeded'
        )
        
        # Test successful confirmation
        result = PaymentService.confirm_payment(
            self.user,
            'pi_test123'
        )
        
        # Verify credits were added
        credits = Credits.objects.get(owner=self.user)
        assert credits.amount == Decimal('10.00')
        
        # Verify payment intent was marked completed
        payment_intent.refresh_from_db()
        assert payment_intent.status == 'completed'
        
    @patch('stripe.PaymentIntent.retrieve')
    def test_confirm_payment_already_processed(self, mock_retrieve):
        # Setup already completed payment
        payment_intent = PaymentIntent.objects.create(
            client=self.user,
            stripe_payment_intent_id='pi_test123',
            amount=Decimal('10.00'),
            credits_amount=Decimal('10.00'),
            status='completed'
        )
        
        Credits.objects.create(
            owner=self.user,
            amount=Decimal('10.00')
        )
        
        # Setup mock
        mock_retrieve.return_value = MagicMock(
            id='pi_test123',
            status='succeeded'
        )
        
        # Test duplicate confirmation
        result = PaymentService.confirm_payment(
            self.user,
            'pi_test123'
        )
        
        # Verify credits weren't added again
        credits = Credits.objects.get(owner=self.user)
        assert credits.amount == Decimal('10.00')
        
    def test_confirm_payment_invalid_intent(self):
        with pytest.raises(PaymentValidationError):
            PaymentService.confirm_payment(
                self.user,
                'pi_nonexistent'
            )
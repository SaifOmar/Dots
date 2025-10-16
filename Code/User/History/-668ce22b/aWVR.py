"""
Constants and configuration for payment processing.
"""
from decimal import Decimal

# Payment Configuration
MIN_PAYMENT_AMOUNT = Decimal('1.00')  # Minimum payment amount in USD
CREDITS_TO_USD_RATE = Decimal('1.00')  # 1 credit = $1.00

# Stripe Configuration
STRIPE_PAYMENT_MODES = {
    'STANDARD': 'standard',
    'CONNECT': 'connect'
}

# Payment Status
PAYMENT_STATUS = {
    'PENDING': 'pending',
    'SUCCEEDED': 'succeeded',
    'FAILED': 'failed',
    'CANCELED': 'canceled',
    'COMPLETED': 'completed'
}

# Currency
DEFAULT_CURRENCY = 'usd'

# Transaction Types
TRANSACTION_TYPES = {
    'CREDIT_PURCHASE': 'credit_purchase',
    'DELIVERY_PAYMENT': 'delivery_payment',
    'WITHDRAWAL': 'withdrawal'
}
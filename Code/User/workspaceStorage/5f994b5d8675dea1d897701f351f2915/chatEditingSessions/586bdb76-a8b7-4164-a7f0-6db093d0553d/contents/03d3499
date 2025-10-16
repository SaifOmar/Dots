"""
Custom exceptions for payment processing.
"""

class PaymentError(Exception):
    """Base exception for payment-related errors."""
    pass

class InsufficientCreditsError(PaymentError):
    """Raised when a user has insufficient credits for an operation."""
    pass

class PaymentValidationError(PaymentError):
    """Raised when payment validation fails."""
    pass

class PaymentProcessingError(PaymentError):
    """Raised when there's an error processing a payment with Stripe."""
    pass

class InvalidPaymentStateError(PaymentError):
    """Raised when attempting an operation on a payment in an invalid state."""
    pass
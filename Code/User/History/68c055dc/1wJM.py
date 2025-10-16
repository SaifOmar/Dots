"""
Decorators and context managers for ensuring safe payment transactions.
"""
from functools import wraps
from contextlib import contextmanager
from django.db import transaction
from .exceptions import PaymentError

def payment_atomic_operation(func):
    """
    Decorator that wraps a function in a database transaction
    and handles payment-related errors appropriately.
    """
    @wraps(func)
    def wrapper(*args, **kwargs):
        try:
            with transaction.atomic():
                return func(*args, **kwargs)
        except Exception as e:
            transaction.set_rollback(True)
            if not isinstance(e, PaymentError):
                e = PaymentError(str(e))
            raise e
    return wrapper

@contextmanager
def payment_transaction_guard():
    """
    Context manager for payment operations that need
    transaction safety.
    """
    try:
        with transaction.atomic():
            yield
    except Exception as e:
        transaction.set_rollback(True)
        if not isinstance(e, PaymentError):
            e = PaymentError(str(e))
        raise e
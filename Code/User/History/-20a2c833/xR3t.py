"""
Views for handling credit and payment operations.
"""
from rest_framework import viewsets, status
from rest_framework.decorators import action
from rest_framework.response import Response
from django.utils.translation import gettext_lazy as _

from .models import Credits, PaymentIntent
from .serializers import CreditsSerializer, PaymentIntentSerializer
from payment_service import PaymentService
from payment_service.exceptions import PaymentError, PaymentValidationError, PaymentProcessingError

class CreditsViewSet(viewsets.ReadOnlyModelViewSet):
    serializer_class = CreditsSerializer
    
    def get_queryset(self):
        return Credits.objects.filter(owner=self.request.user)
        
    @action(detail=False, methods=['POST'], url_path='create_payment_intent')
    def create_payment_intent(self, request):
        """Creates a Stripe PaymentIntent for buying credits."""
        try:
            credits_amount = request.data.get('credits_amount')
            if not credits_amount:
                return Response(
                    {'error': _('Please provide the credits_amount to buy.')},
                    status=status.HTTP_400_BAD_REQUEST
                )
                
            result = PaymentService.create_payment_intent(
                request.user,
                credits_amount
            )
            return Response(result, status=status.HTTP_200_OK)
            
        except PaymentValidationError as e:
            return Response(
                {'error': str(e)},
                status=status.HTTP_400_BAD_REQUEST
            )
        except PaymentProcessingError as e:
            return Response(
                {'error': str(e)},
                status=status.HTTP_500_INTERNAL_SERVER_ERROR
            )
        except PaymentError as e:
            return Response(
                {'error': str(e)},
                status=status.HTTP_500_INTERNAL_SERVER_ERROR
            )
            
    @action(detail=False, methods=['POST'], url_path='confirm_payment')
    def confirm_payment(self, request):
        """Confirms payment and adds credits to user account."""
        try:
            payment_intent_id = request.data.get('payment_intent_id')
            if not payment_intent_id:
                return Response(
                    {'error': _('Payment intent ID is required')},
                    status=status.HTTP_400_BAD_REQUEST
                )
                
            result = PaymentService.confirm_payment(
                request.user,
                payment_intent_id
            )
            return Response(result, status=status.HTTP_200_OK)
            
        except PaymentValidationError as e:
            return Response(
                {'error': str(e)},
                status=status.HTTP_400_BAD_REQUEST
            )
        except PaymentProcessingError as e:
            return Response(
                {'error': str(e)},
                status=status.HTTP_500_INTERNAL_SERVER_ERROR
            )
        except PaymentError as e:
            return Response(
                {'error': str(e)},
                status=status.HTTP_500_INTERNAL_SERVER_ERROR
            )
            
    @action(detail=False, methods=['GET'], url_path='payment_intent_status')
    def payment_intent_status(self, request):
        """Returns the status of a specific payment intent."""
        payment_intent_id = request.query_params.get('payment_intent_id')
        if not payment_intent_id:
            return Response(
                {'error': _('Payment intent ID is required')},
                status=status.HTTP_400_BAD_REQUEST
            )
            
        try:
            payment_intent = PaymentIntent.objects.get(
                stripe_payment_intent_id=payment_intent_id,
                client=request.user
            )
            serializer = PaymentIntentSerializer(payment_intent)
            return Response(serializer.data, status=status.HTTP_200_OK)
            
        except PaymentIntent.DoesNotExist:
            return Response(
                {'error': _('Payment intent not found')},
                status=status.HTTP_404_NOT_FOUND
            )
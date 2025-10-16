"""
Views for handling delivery operations.
"""
from rest_framework import viewsets, status
from rest_framework.decorators import action
from rest_framework.response import Response
from django.utils.translation import gettext_lazy as _
from django.db import transaction

from .models import Order, Delivery
from .serializers import DeliverySerializer
from .permissions import IsApprovedDeliveryMan
from payment_service.delivery import DeliveryPaymentService
from payment_service.exceptions import PaymentError, PaymentValidationError
from clients.models import Credits

class DeliveryViewSet(viewsets.ReadOnlyModelViewSet):
    serializer_class = DeliverySerializer
    permission_classes = [IsApprovedDeliveryMan]
    
    def get_queryset(self):
        return Delivery.objects.filter(delivery_man=self.request.user)
    
    @action(detail=False, methods=['POST'])
    def take_order(self, request):
        """Allows a delivery man to take an order."""
        order_id = request.data.get('order_id')
        if not order_id:
            return Response(
                {'error': _('Order ID is required.')},
                status=status.HTTP_400_BAD_REQUEST
            )
            
        try:
            with transaction.atomic():
                order = Order.objects.select_for_update().get(pk=order_id)
                
                if order.status != 'pending':
                    return Response(
                        {'error': _('This order is no longer available.')},
                        status=status.HTTP_400_BAD_REQUEST
                    )
                
                # Check if user has enough credits
                credits = Credits.objects.filter(owner=request.user).first()
                order_cost = order.calculate_delivery_cost()
                
                if credits and credits.amount >= order_cost:
                    # Process using credits
                    credits.amount -= order_cost
                    credits.save()
                    
                    delivery = self._finalize_order_assignment(order, request.user, request.data)
                    serializer = self.get_serializer(delivery)
                    
                    return Response({
                        'message': _('Order taken successfully using credits.'),
                        'delivery': serializer.data,
                        'current_credit_balance': credits.amount
                    }, status=status.HTTP_201_CREATED)
                else:
                    # Create payment intent
                    try:
                        payment_response = DeliveryPaymentService.create_order_payment_intent(
                            request.user,
                            order_cost,
                            order_id
                        )
                        return Response(payment_response, status=status.HTTP_402_PAYMENT_REQUIRED)
                    except PaymentError as e:
                        return Response(
                            {'error': str(e)},
                            status=status.HTTP_400_BAD_REQUEST
                        )
                        
        except Order.DoesNotExist:
            return Response(
                {'error': _('Order not found.')},
                status=status.HTTP_404_NOT_FOUND
            )
        except Exception as e:
            return Response(
                {'error': str(e)},
                status=status.HTTP_500_INTERNAL_SERVER_ERROR
            )
            
    @action(detail=False, methods=['POST'], url_path='finalize_order_payment')
    def finalize_order_payment(self, request):
        """Finalizes order assignment after payment."""
        payment_intent_id = request.data.get('payment_intent_id')
        order_id = request.data.get('order_id')
        
        if not payment_intent_id or not order_id:
            return Response(
                {'error': _('Payment Intent ID and Order ID are required.')},
                status=status.HTTP_400_BAD_REQUEST
            )
            
        try:
            with transaction.atomic():
                # Verify payment first
                payment_success = DeliveryPaymentService.process_order_payment(
                    request.user,
                    payment_intent_id,
                    order_id
                )
                
                if not payment_success:
                    return Response(
                        {'error': _('Payment verification failed.')},
                        status=status.HTTP_400_BAD_REQUEST
                    )
                    
                # Get and lock the order
                order = Order.objects.select_for_update().get(pk=order_id)
                
                # Check if order is still available
                if order.status != 'pending':
                    # Initiate refund since order is no longer available
                    DeliveryPaymentService.refund_payment(payment_intent_id)
                    return Response(
                        {'error': _('Order is no longer available. Your payment has been refunded.')},
                        status=status.HTTP_409_CONFLICT
                    )
                    
                # Finalize the assignment
                delivery = self._finalize_order_assignment(order, request.user, request.data)
                serializer = self.get_serializer(delivery)
                
                return Response({
                    'message': _('Order assigned successfully.'),
                    'delivery': serializer.data
                }, status=status.HTTP_201_CREATED)
                
        except PaymentValidationError as e:
            return Response(
                {'error': str(e)},
                status=status.HTTP_400_BAD_REQUEST
            )
        except PaymentError as e:
            return Response(
                {'error': str(e)},
                status=status.HTTP_500_INTERNAL_SERVER_ERROR
            )
        except Order.DoesNotExist:
            return Response(
                {'error': _('Order not found.')},
                status=status.HTTP_404_NOT_FOUND
            )
        except Exception as e:
            return Response(
                {'error': str(e)},
                status=status.HTTP_500_INTERNAL_SERVER_ERROR
            )
            
    def _finalize_order_assignment(self, order, user, data):
        """Helper method to finalize order assignment."""
        order.status = 'assigned'
        order.save()
        
        delivery = Delivery.objects.create(
            order=order,
            delivery_man=user,
            status='assigned',
            tracking_id=f"DEL-{order.id}-{user.id}"
        )
        
        return delivery
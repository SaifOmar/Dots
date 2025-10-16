from decimal import Decimal
from types import NoneType

import delivery
from django.utils import timezone
from authentication.client_perms import IsClientAuthenticated
from authentication.client_auth import ClientJWTAuthentication
from django.db import transaction
from delivery.models import Delivery
from rest_framework import status, permissions
from rest_framework import viewsets
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework.viewsets import ModelViewSet
from rest_framework.decorators import action
from rest_framework_simplejwt.tokens import AccessToken
from django.db.models import Q, F
import stripe

from restaurants.models import Order

from .serializers import *
from .models import *
import os


class ClientViewSet(ModelViewSet):
    queryset = Client.objects.all()

    def get_serializer_class(self):
        if self.action in ["create", "update", "partial_update"]:
            return ClientWriteSerializer
        return ClientReadSerializer

    def get_queryset(self):
        queryset = super().get_queryset()
        search = self.request.query_params.get("search", None)
        client = self.request.query_params.get("client", None)

        if client is not None:
            if client.isdigit():
                queryset = queryset.filter(id=client)
                if queryset.exists():
                    return queryset
                else:
                    return queryset.none()
            else:
                search = client

        if search:
            queryset = queryset.filter(
                Q(id__icontains=search)
                | Q(first_name__icontains=search)
                | Q(last_name__icontains=search)
                | Q(national_id__icontains=search)
                | Q(phone__icontains=search)
                | Q(phone2__icontains=search)
            )
        return queryset

    @action(
        detail=False,
        methods=["get"],
        url_path="available-for-chat",
        authentication_classes=[ClientJWTAuthentication],
    )
    def get_available_participants_for_chat(self, request):
        """
        Returns a list of users available for chat.
        - If the user is a delivery man, it returns clients they have active orders with.
        - If the user is a client, it returns delivery men assigned to their active orders.
        """

        user = request.user
        participant_ids = []

        if user.is_deliveryman:
            participant_ids = (
                Delivery.objects.filter(
                    delivery_man=user,
                    order__isnull=False,
                )
                .exclude(order__status__in=["completed", "pending"])
                .values_list("order__client_id", flat=True)
                .distinct()
            )
        else:
            participant_ids = (
                Delivery.objects.filter(order__client=user, delivery_man__isnull=False)
                .exclude(order__status__in=["completed", "pending", "preparing"])
                .values_list("delivery_man_id", flat=True)
                .distinct()
            )

        participants = self.get_queryset().filter(id__in=participant_ids)

        serializer = self.get_serializer(participants, many=True)
        return Response(serializer.data)

    @action(
        detail=False,
        methods=["post"],
        url_path="rate",
        authentication_classes=[ClientJWTAuthentication],
    )
    def rate_type(self, request):
        """
        Allows a client to rate a type.
        Expects ('delivery_id' or 'restaurant_id'), 'rating', and optionally 'comment' in the post body.
        """
        delivery_id = request.data.get("delivery_id")
        restaurant_id = request.data.get("restaurant_id", None)
        rating = request.data.get("rating")
        comment = request.data.get("comment", "")

        if (not delivery_id and not restaurant_id) or not rating:
            return Response(
                {
                    "error": "Both ('delivery_id' or 'restaurant_id') and 'rating' are required."
                },
                status=status.HTTP_400_BAD_REQUEST,
            )

        if not (1 <= rating <= 5):
            return Response(
                {"error": "Rating must be between 1 and 5."},
                status=status.HTTP_400_BAD_REQUEST,
            )

        rating_type = "delivery"
        if restaurant_id:
            rating_type = "restaurant"

        serializer = RatingSerializer(
            data={
                "rating": rating,
                "comment": comment,
                "type": rating_type,
                "rated_by": request.user.id,
                "delivery_man": delivery_id,
                "restaurant": restaurant_id,
            },
            context={"request": request},
        )
        serializer.is_valid(raise_exception=True)
        serializer.save()
        return Response(
            {"message": "Delivery rated successfully."},
            status=status.HTTP_201_CREATED,
        )

    @action(
        detail=False,
        methods=["post"],
        url_path="report",
        authentication_classes=[ClientJWTAuthentication],
    )
    def report_type(self, request):
        """
        Allows a client to report a type.
        Expects ('delivery_id' or 'restaurant_id') and 'description' in the post body.
        """
        delivery_id = request.data.get("delivery_id")
        restaurant_id = request.data.get("restaurant_id", None)
        description = request.data.get("description")

        if (not delivery_id and not restaurant_id) or not description:
            return Response(
                {
                    "error": "Both ('delivery_id' or 'restaurant_id') and 'description' are required."
                },
                status=status.HTTP_400_BAD_REQUEST,
            )

        serializer = ReportSerializer(
            data={
                "description": description,
                "delivery_man": delivery_id,
                "restaurant": restaurant_id,
                "reported_by": request.user.id,
            }
        )
        serializer.is_valid(raise_exception=True)
        serializer.save()

        return Response(
            {"message": "Delivery reported successfully."},
            status=status.HTTP_201_CREATED,
        )

    @action(
        detail=False,
        methods=["post"],
        url_path="save_fb_token",
        authentication_classes=[ClientJWTAuthentication],
    )
    def save_fb_token(self, request):
        """
        Save Firebase token for the authenticated client.
        Expects 'fb_token' in the query parameters.
        """
        fb_token = request.data.get("fb_token")
        if not fb_token:
            return Response(
                {"error": "FireBase token is required."},
                status=status.HTTP_400_BAD_REQUEST,
            )

        client = request.user
        client.fb_token = fb_token
        client.save()

        return Response(
            {"message": "Facebook token saved successfully."},
            status=status.HTTP_200_OK,
        )

    # @action(detail=True, methods=['PATCH'])
    def change_id(self, request, pk=None):
        client = self.get_object()
        new_id = request.data.get("new_id")
        try:
            c = Client.objects.get(id=new_id)
            if c:
                return Response(
                    {"new_id": "كود غير متاح"}, status=status.HTTP_400_BAD_REQUEST
                )
        except Client.DoesNotExist:
            client.id = new_id
            if client.qr_code:
                if os.path.isfile(client.qr_code.path):
                    os.remove(client.qr_code.path)
            if client.barcode:
                if os.path.isfile(client.barcode.path):
                    os.remove(client.barcode.path)
            client.save()
        return Response(status=status.HTTP_204_NO_CONTENT)

    # @action(detail=True, methods=['POST'])
    def requested_photo(self, request, pk=None):
        client = self.get_object()
        action_ = request.data.get("action")
        if action_ == "accept":
            client.accept_requested_photo()
        else:
            client.delete_requested_photo()
        return Response(status=status.HTTP_204_NO_CONTENT)

    def create(self, request, *args, **kwargs):
        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)

        # Save the order and assign the current user as client
        self.perform_create(serializer)

        # Re-serialize using read serializer to return detailed info
        read_serializer = ClientReadSerializer(
            serializer.instance, context={"request": request}
        )

        headers = self.get_success_headers(serializer.data)

        token = AccessToken.for_user(serializer.instance)
        token["client_id"] = str(serializer.instance.id)

        return Response(
            {"client": read_serializer.data, "access": str(token)},
            status=status.HTTP_201_CREATED,
            headers=headers,
        )


class ClientLogin(APIView):
    def post(self, request):
        identifier = request.data.get("identifier")
        password = request.data.get("password")

        if not identifier or not password:
            return Response(
                {
                    "message": "Identifier and password are required.",
                    "data": [],
                },
                status=status.HTTP_400_BAD_REQUEST,
            )

        try:
            client = Client.objects.get(Q(email=identifier) | Q(phone=identifier))

            if not check_password(password, client.password):
                return Response(
                    {
                        "message": "Incorrect password.",
                        "data": [],
                    },
                    status=status.HTTP_401_UNAUTHORIZED,
                )

            token = AccessToken.for_user(client)
            token["client_id"] = str(client.id)

            return Response(
                {
                    "message": "Login successful.",
                    "data": {
                        "access": str(token),
                        "client": ClientReadSerializer(
                            client, context={"request": request}
                        ).data,
                    },
                },
                status=status.HTTP_200_OK,
            )

        except Client.DoesNotExist:
            return Response(
                {
                    "message": "Client not found.",
                    "data": [],
                },
                status=status.HTTP_404_NOT_FOUND,
            )


class GetClientData(APIView):
    authentication_classes = [ClientJWTAuthentication]
    permission_classes = [IsClientAuthenticated]

    def post(self, request):
        client = request.user
        return Response(
            ClientReadSerializer(client, context={"request": request}).data,
            status=status.HTTP_200_OK,
        )


class ChangeClientPassword(APIView):
    def post(self, request):
        id = request.data.get("id")
        try:
            client = Client.objects.get(id=id)
            serializer = ClientPasswordSerializer(
                data=request.data, context={"request": request, "id": id}
            )

            if serializer.is_valid(raise_exception=True):
                client.set_password(serializer.validated_data["new_password"])
                client.save()
                return Response({}, status.HTTP_200_OK)
        except Client.DoesNotExist:
            return Response(
                {"error": "ID is not found!"}, status=status.HTTP_404_NOT_FOUND
            )


class CreditsViewSet(viewsets.ReadOnlyModelViewSet):
    queryset = Credits.objects.all()
    serializer_class = CreditsSerializer
    authentication_classes = [ClientJWTAuthentication]

    def get_queryset(self):
        return Credits.objects.filter(owner=self.request.user)

    @action(detail=False, methods=["get"], url_path="remaining_credits")
    def remaining_credits(self, request):
        """
        Returns the remaining credits of the authenticated user.
        """
        user = request.user
        try:
            credits = Credits.objects.get(owner=user)
            return Response({"remaining_credits": credits.amount})
        except Credits.DoesNotExist:
            return Response({"remaining_credits": 0.0})

    @action(detail=False, methods=["post"], url_path="create_payment_intent")
    def create_payment_intent(self, request):
        """
        Creates a Stripe PaymentIntent for buying credits.
        Expects 'credits_amount' in the request data.
        """

        amount = request.data.get("amount")
        use_credits = request.data.get("use_credits", False)
        order_id = request.data.get("order_id")

        if not order_id:
            return Response(
                {"error": "Please provide the 'order_id' to buy."},
                status=status.HTTP_400_BAD_REQUEST,
            )

        if not Order.objects.get(id=order_id):
            return Response(
                {"error": "Order does not exist."},
                status=status.HTTP_400_BAD_REQUEST,
            )
        if not amount:
            return Response(
                {"error": "Please provide the 'amount' to buy."},
                status=status.HTTP_400_BAD_REQUEST,
            )
        try:
            amount = Decimal(str(amount))
            if amount <= 0:
                return Response(
                    {"error": "Amount or credits amount must be positive"},
                    status=status.HTTP_400_BAD_REQUEST,
                )
        except ValueError:
            return Response(
                {"error": "Invalid amount."}, status=status.HTTP_400_BAD_REQUEST
            )
        CREDITS_TO_DOLLAR_RATE = Decimal("1.00")
        payment_amount = amount * CREDITS_TO_DOLLAR_RATE

        # Convert to cents for Stripe (Stripe expects amounts in smallest currency unit)
        stripe_amount = int(payment_amount * 100)

        if stripe_amount < 1:  # Stripe minimum is $0.50
            return Response(
                {"error": "Minimum purchase amount is $1 (1 credit)"},
                status=status.HTTP_400_BAD_REQUEST,
            )

        try:
            intent = stripe.PaymentIntent.create(
                amount=stripe_amount,
                currency="usd",
                metadata={
                    "client_id": request.user.id,
                    "order_id": order_id,
                    "amount": str(amount),
                },
                description=f"A Purchase for {request.user.email} on order {order_id}",
            )

            payment_intent = PaymentIntent.objects.create(
                client=request.user,
                stripe_payment_intent_id=intent.id,
                amount=payment_amount,
                credits_amount=amount,
                order_id=order_id,
                status="pending",
            )
            print(payment_intent)

            return Response(
                {
                    "client_secret": intent.client_secret,
                    "payment_intent_id": intent.id,
                    "credits_amount": amount if use_credits else None,
                    "amount": payment_amount,
                    "order_id": order_id,
                    "use_credits": use_credits,
                },
                status=status.HTTP_200_OK,
            )

        except stripe.error.StripeError:
            return Response(
                {"error": "Payment processing error. Please try again."},
                status=status.HTTP_500_INTERNAL_SERVER_ERROR,
            )
        except Exception:
            return Response(
                {"error": "An unexpected error occurred."},
                status=status.HTTP_400_BAD_REQUEST,
            )

    @action(detail=False, methods=["post"], url_path="confirm_payment")
    def confirm_payment(self, request):
        """
        Confirms payment and adds credits to user account.
        Called after successful payment on the client side.
        """
        payment_intent_id = request.data.get("payment_intent_id")
        use_credits = request.data.get("use_credits", False)
        credits = None
        serializer = None
        if not payment_intent_id:
            return Response(
                {"error": "Payment intent ID is required"},
                status=status.HTTP_400_BAD_REQUEST,
            )

        try:
            payment_intent_record = PaymentIntent.objects.get(
                stripe_payment_intent_id=payment_intent_id, client=request.user
            )

            # Verify with Stripe
            stripe_intent = stripe.PaymentIntent.retrieve(payment_intent_id)

            if (
                stripe_intent.status == "succeeded"
                and payment_intent_record.status != "completed"
            ):
                with transaction.atomic():
                    if use_credits:
                        credits, created = Credits.objects.get_or_create(
                            owner=request.user, defaults={"amount": 0}
                        )
                        credits.amount += payment_intent_record.credits_amount
                        credits.save()

                    payment_intent_record.status = "completed"
                    payment_intent_record.completed_at = timezone.now()
                    payment_intent_record.save()

                    if use_credits:
                        serializer = CreditsSerializer(credits)
                    return Response(
                        {
                            "message": "Credits added successfully"
                            if use_credits
                            else "Payment completed successfully",
                            "credits": serializer.data if use_credits else None,
                            "added_credits": payment_intent_record.credits_amount
                            if use_credits
                            else payment_intent_record.amount,
                        },
                        status=status.HTTP_200_OK,
                    )

            elif (
                stripe_intent.status == "succeeded"
                and payment_intent_record.status == "completed"
            ):
                if use_credits:
                    credits = Credits.objects.get(owner=request.user)
                    serializer = CreditsSerializer(credits)
                return Response(
                    {
                        "message": "Payment already processed",
                        "amount": serializer.data
                        if use_credits
                        else payment_intent_record.amount,
                    },
                    status=status.HTTP_200_OK,
                )
            else:
                return Response(
                    {"error": "Payment not completed"},
                    status=status.HTTP_400_BAD_REQUEST,
                )

        except PaymentIntent.DoesNotExist:
            return Response(
                {"error": "Payment intent not found"},
                status=status.HTTP_404_NOT_FOUND,
            )
        except stripe.error.StripeError:
            return Response(
                {"error": "Payment verification failed"},
                status=status.HTTP_500_INTERNAL_SERVER_ERROR,
            )
        except Exception:
            return Response(
                {"error": "An unexpected error occurred"},
                status=status.HTTP_500_INTERNAL_SERVER_ERROR,
            )

    @action(detail=False, methods=["get"], url_path="payment_history")
    def payment_history(self, request):
        """
        Returns the payment history of the authenticated user.
        """
        user = request.user
        payments = PaymentIntent.objects.filter(client=user).order_by("-created_at")
        serializer = PaymentIntentSerializer(payments, many=True)
        return Response(serializer.data, status=status.HTTP_200_OK)

    @action(detail=False, methods=["get"], url_path="payment_intent_status")
    def payment_intent_status(self, request):
        """
        Returns the status of a specific payment intent.
        Expects 'payment_intent_id' in the query parameters.
        """
        payment_intent_id = request.query_params.get("payment_intent_id")
        if not payment_intent_id:
            return Response(
                {"error": "Payment intent ID is required"},
                status=status.HTTP_400_BAD_REQUEST,
            )

        try:
            payment_intent = PaymentIntent.objects.get(
                stripe_payment_intent_id=payment_intent_id, client=request.user
            )
            serializer = PaymentIntentSerializer(payment_intent)
            return Response(serializer.data, status=status.HTTP_200_OK)
        except PaymentIntent.DoesNotExist:
            return Response(
                {"error": "Payment intent not found"},
                status=status.HTTP_404_NOT_FOUND,
            )

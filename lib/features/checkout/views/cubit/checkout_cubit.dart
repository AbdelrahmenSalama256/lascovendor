import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../profile/data/models/order_details_model.dart';
import '../../../profile/views/order_details_screen.dart';
import '../widgets/address_bottom_sheet.dart';
import 'checkout_state.dart';

class CheckoutCubit extends Cubit<CheckoutState> {
  CheckoutCubit() : super(CheckoutInitial());

  final TextEditingController promoController = TextEditingController();
  String selectedPaymentMethod = 'full';
  double subtotal = 1000.0;
  double shipping = 50.0;
  double discount = 0.0;
  AddressModel? currentAddress;
  String phoneNumber = "+201111111111";
  List<Map<String, dynamic>> orderItems = [
    {
      'name': 'Bubblzz Body Lotion',
      'category': 'Skin Care',
      'price': 500.0,
      'quantity': 2,
      'deliveryDate': 'Deliver between 10 Aug, 12 Aug',
      'imageUrl': 'assets/images/png/test-product.png',
    },
    {
      'name': 'Bubblzz Body Lotion',
      'category': 'Skin Care',
      'price': 500.0,
      'quantity': 2,
      'deliveryDate': 'Deliver between 10 Aug, 12 Aug',
      'imageUrl': 'assets/images/png/test-product.png',
    },
    {
      'name': 'Bubblzz Body Lotion',
      'category': 'Skin Care',
      'price': 500.0,
      'quantity': 2,
      'deliveryDate': 'Deliver between 10 Aug, 12 Aug',
      'imageUrl': 'assets/images/png/test-product.png',
    },
  ];
  String? orderId;
  String? orderDate;
  bool isAccepted = false;

  double get total => subtotal + shipping - discount;

  void updatePaymentMethod(String method) {
    selectedPaymentMethod = method;
    emit(CheckoutUpdated());
  }

  void applyPromoCode(String code) {
    if (code.toLowerCase() == 'save10') {
      discount = 100.0;
    } else {
      discount = 0.0;
    }
    emit(CheckoutUpdated());
  }

  void handleConfirmOrder(BuildContext context) {
    // Generate order ID and date
    orderId = "123456";
    orderDate = "Mon 4 August, 2025";
    emit(CheckoutUpdated());
  }

  // Handle Accept button click
  void handleAcceptOrder() {
    isAccepted = true;
    emit(CheckoutUpdated());
  }

  // Handle Reject button click
  void handleRejectOrder() {
    if (orderDetail != null) {
      orderDetail = orderDetail!.copyWith(status: OrderDetailStatus.cancelled);
      emit(CheckoutUpdated());
    }
  }

  // Move to next order status
  void moveToNextStatus() {
    if (orderDetail != null) {
      OrderDetailStatus nextStatus;
      switch (orderDetail!.status) {
        case OrderDetailStatus.processing:
          nextStatus = OrderDetailStatus.onWay;
          break;
        case OrderDetailStatus.onWay:
          nextStatus = OrderDetailStatus.delivered;
          break;
        case OrderDetailStatus.delivered:
          return;
        case OrderDetailStatus.cancelled:
          return;
      }

      orderDetail = orderDetail!.copyWith(status: nextStatus);
      emit(CheckoutUpdated());
    }
  }

  // Get next status button text
  String getNextStatusButtonText() {
    if (orderDetail == null) return "prepared";

    switch (orderDetail!.status) {
      case OrderDetailStatus.processing:
        return "processing";
      case OrderDetailStatus.onWay:
        return "on_way";
      case OrderDetailStatus.delivered:
        return "delivered";
      case OrderDetailStatus.cancelled:
        return "";
    }
  }

  // Check if buttons should be shown
  bool shouldShowButtons() {
    if (orderDetail == null) return true;
    return orderDetail!.status != OrderDetailStatus.delivered &&
        orderDetail!.status != OrderDetailStatus.cancelled;
  }

  void showAddressBottomSheet(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => AddressBottomSheet(
        onAddressSaved: (address) {
          currentAddress = address;
          emit(CheckoutUpdated());
        },
      ),
    );
  }

  void showPhoneBottomSheet(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit Phone Number'),
        content: TextField(
          decoration: InputDecoration(
            hintText: 'Enter phone number',
            border: OutlineInputBorder(),
          ),
          keyboardType: TextInputType.phone,
          onChanged: (value) {
            phoneNumber = value;
            emit(CheckoutUpdated());
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              emit(CheckoutUpdated());
              Navigator.pop(context);
            },
            child: Text('Save'),
          ),
        ],
      ),
    );
  }

  OrderDetailModel? orderDetail;

  void setOrderDetails(OrderDetailModel orderDetail) {
    this.orderDetail = orderDetail;
    emit(CheckoutUpdated());
  }

  @override
  Future<void> close() {
    promoController.dispose();
    return super.close();
  }
}

// Extension to add copyWith method to OrderDetailModel
extension OrderDetailModelExtension on OrderDetailModel {
  OrderDetailModel copyWith({
    OrderDetailStatus? status,
    String? orderId,
    String? orderDate,
    String? deliveryAddress,
    String? mobileNumber,
    String? subtotal,
    String? shipping,
    String? total,
    List<PaymentMethodModel>? paymentMethods,
  }) {
    return OrderDetailModel(
      orderItems: orderItems,
      status: status ?? this.status,
      orderId: orderId ?? this.orderId,
      orderDate: orderDate ?? this.orderDate,
      deliveryAddress: deliveryAddress ?? this.deliveryAddress,
      mobileNumber: mobileNumber ?? this.mobileNumber,
      subtotal: subtotal ?? this.subtotal,
      shipping: shipping ?? this.shipping,
      total: total ?? this.total,
      paymentMethods: paymentMethods ?? this.paymentMethods,
    );
  }
}

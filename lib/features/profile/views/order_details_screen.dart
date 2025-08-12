import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lasco/core/component/widgets/app_button.dart';
import 'package:lasco/core/constants/app_colors.dart';
import 'package:lasco/core/locale/app_loacl.dart';
import 'package:lasco/features/offers/views/widgets/custom_app_bar.dart';
import 'package:lasco/features/profile/views/rejection_reason.dart';

import '../../checkout/views/cubit/checkout_cubit.dart';
import '../../checkout/views/cubit/checkout_state.dart';
import '../../checkout/views/widgets/order_details_section.dart';
import '../../checkout/views/widgets/order_info.dart';
import '../../checkout/views/widgets/order_items.dart';
import '../../checkout/views/widgets/order_progress.dart';
import '../data/models/order_details_model.dart';

class OrderDetailsScreen extends StatefulWidget {
  final OrderDetailModel orderDetail;

  const OrderDetailsScreen({
    super.key,
    required this.orderDetail,
  });

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _slideAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: "order_details".tr(context),
      ),
      body: BlocProvider(
        create: (context) =>
            CheckoutCubit()..setOrderDetails(widget.orderDetail),
        child: BlocBuilder<CheckoutCubit, CheckoutState>(
          builder: (context, state) {
            final cubit = context.read<CheckoutCubit>();
            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 0.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 16.h),

                          //! Order Status Progress
                          if (cubit.orderDetail?.status !=
                              OrderDetailStatus.cancelled)
                            OrderProgress(cubit: cubit),

                          SizedBox(height: 24.h),

                          // Order Status Banner (for cancelled orders)
                          if (cubit.orderDetail?.status ==
                              OrderDetailStatus.cancelled)
                            _buildCancelledBanner(context),

                          // Delivered Banner (for delivered orders)
                          if (cubit.orderDetail?.status ==
                              OrderDetailStatus.delivered)
                            _buildDeliveredBanner(context),

                          // Order Info
                          OrderInfo(cubit: cubit),

                          SizedBox(height: 20.h),

                          // Delivery Information
                          _buildDeliverySection(context, cubit),

                          SizedBox(height: 20.h),

                          // Payment Methods
                          _buildPaymentSection(context, cubit),

                          SizedBox(height: 24.h),

                          // Order Items
                          OrderItems(cubit: cubit),

                          SizedBox(height: 20.h),

                          // Order Details Summary
                          OrderDetailsSection(
                            subtotal: double.parse(cubit.orderDetail?.subtotal
                                    .replaceAll(' LE', '') ??
                                '1000'),
                            shipping: double.parse(cubit.orderDetail?.shipping
                                    .replaceAll(' LE', '') ??
                                '50'),
                            discount: 0,
                            total: double.parse(cubit.orderDetail?.total
                                    .replaceAll(' LE', '') ??
                                '1050'),
                            paid: 600,
                            remaining: 450,
                          ),

                          SizedBox(height: 20.h),
                        ],
                      ),
                    ),
                  ),
                ),

                // Bottom Action Buttons
                if (cubit.shouldShowButtons())
                  _buildBottomButtons(context, cubit),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildBottomButtons(BuildContext context, CheckoutCubit cubit) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: cubit.isAccepted
          ? _buildSingleStatusButton(context, cubit)
          : _buildAcceptRejectButtons(context, cubit),
    );
  }

  Widget _buildAcceptRejectButtons(BuildContext context, CheckoutCubit cubit) {
    return Row(
      children: [
        Expanded(
          child: AppButton(
            text: "reject".tr(context),
            backgroundColor: const Color(0xffFEEBE3),
            borderRadius: BorderRadius.circular(12.r),
            textStyle: TextStyle(
              color: AppColors.orange,
              fontSize: 13.sp,
              fontWeight: FontWeight.w400,
            ),
            onPressed: () async {
              await showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                showDragHandle: false,
                useSafeArea: true,
                backgroundColor: AppColors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusDirectional.only(
                    topEnd: Radius.circular(50.r),
                    topStart: Radius.circular(50.r),
                  ),
                ),
                builder: (context) {
                  return RejectionReason();
                },
              );
            },
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: AppButton(
            text: "accept".tr(context),
            backgroundColor: AppColors.orange,
            onPressed: () {
              cubit.handleAcceptOrder();
              _animationController.forward();
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSingleStatusButton(BuildContext context, CheckoutCubit cubit) {
    return SlideTransition(
      position: _slideAnimation.drive(
        Tween<Offset>(
          begin: const Offset(0, 1),
          end: Offset.zero,
        ),
      ),
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: AppButton(
          text: cubit.getNextStatusButtonText().tr(context),
          backgroundColor: AppColors.orange,
          onPressed: () {
            cubit.moveToNextStatus();
            if (cubit.orderDetail?.status != OrderDetailStatus.delivered) {
              _animationController.reset();
              _animationController.forward();
            }
          },
        ),
      ),
    );
  }

  Widget _buildDeliveredBanner(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
      margin: EdgeInsets.only(bottom: 20.h, left: 16.w, right: 16.w),
      decoration: BoxDecoration(
        color: Colors.green[50],
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: Colors.green[200]!),
      ),
      child: Row(
        children: [
          Icon(
            Icons.check_circle,
            color: Colors.green,
            size: 20.w,
          ),
          SizedBox(width: 8.w),
          Text(
            "Delivered on Mon 11 Aug, 11:35 AM",
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: Colors.green[700],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCancelledBanner(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
      margin: EdgeInsets.only(bottom: 20.h, left: 16.w, right: 16.w),
      decoration: BoxDecoration(
        color: Colors.red[50],
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: Colors.red[200]!),
      ),
      child: Row(
        children: [
          Icon(
            Icons.cancel,
            color: Colors.red,
            size: 20.w,
          ),
          SizedBox(width: 8.w),
          Text(
            "order_cancelled".tr(context),
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDeliverySection(BuildContext context, CheckoutCubit cubit) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0XFFF7F7F7),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.location_on_outlined,
                color: AppColors.orange,
                size: 20.w,
              ),
              SizedBox(width: 12.w),
              Text(
                "deliver_to".tr(context),
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.black,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Padding(
            padding: EdgeInsets.only(left: 32.w),
            child: Text(
              cubit.orderDetail?.deliveryAddress ??
                  "Building 35, Street 206, Degla square, maadi, cairo governorate",
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.grey,
                height: 1.4,
              ),
            ),
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              Icon(
                Icons.phone_outlined,
                color: AppColors.orange,
                size: 20.w,
              ),
              SizedBox(width: 12.w),
              Text(
                "mobile_number".tr(context),
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.black,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Padding(
            padding: EdgeInsets.only(left: 32.w),
            child: Text(
              cubit.orderDetail?.mobileNumber ?? "+201111111111",
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.grey,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentSection(BuildContext context, CheckoutCubit cubit) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xffF7F7F7),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "payment_methods".tr(context),
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              Icon(
                Icons.radio_button_checked,
                color: AppColors.secoundry,
                size: 18.w,
              ),
              SizedBox(width: 8.w),
              Text(
                "Partial Payment",
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              SvgPicture.asset(
                "assets/images/svg/cash-on-delivery.svg",
                width: 16.w,
                height: 16.h,
              ),
              SizedBox(width: 8.w),
              Text(
                "remaining_balance_due_on_delivery".tr(context),
                style: TextStyle(
                  fontSize: 12.sp,
                  color: AppColors.orange,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Models (unchanged)
enum OrderDetailStatus {
  processing,
  onWay,
  delivered,
  cancelled,
}

extension OrderDetailStatusValue on OrderDetailStatus {
  int get value {
    switch (this) {
      case OrderDetailStatus.processing:
        return 0;
      case OrderDetailStatus.onWay:
        return 1;
      case OrderDetailStatus.delivered:
        return 2;
      case OrderDetailStatus.cancelled:
        return -1;
    }
  }
}

enum OrderStepStatus {
  completed,
  current,
  inactive,
}

class OrderStep {
  final String title;
  final OrderStepStatus status;

  OrderStep({
    required this.title,
    required this.status,
  });
}

class PaymentMethodModel {
  final String title;
  final bool isCompleted;

  PaymentMethodModel({
    required this.title,
    required this.isCompleted,
  });
}

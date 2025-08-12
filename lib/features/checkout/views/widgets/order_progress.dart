import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../profile/views/order_details_screen.dart';
import '../cubit/checkout_cubit.dart';
import '../cubit/checkout_state.dart';

class OrderProgress extends StatelessWidget {
  final CheckoutCubit cubit;

  const OrderProgress({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckoutCubit, CheckoutState>(
      builder: (context, state) {
        final status =
            cubit.orderDetail?.status ?? OrderDetailStatus.processing;

        return AnimatedContainer(
          duration: const Duration(milliseconds: 800),
          margin: EdgeInsets.symmetric(horizontal: 16.w),
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Progress Bar with Animation
              Container(
                width: double.infinity,
                height: 4.h,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(2.r),
                ),
                child: AnimatedFractionallySizedBox(
                  duration: const Duration(milliseconds: 800),
                  curve: Curves.easeInOut,
                  alignment: Alignment.centerLeft,
                  widthFactor: _getProgressFactor(status),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF8B5CF6), // Purple color
                      borderRadius: BorderRadius.circular(2.r),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 16.h),

              // Delivery Date Text - Dynamic based on status
              Text(
                _getDeliveryText(status),
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: status == OrderDetailStatus.delivered
                      ? Colors.green[700]
                      : Colors.green[600],
                ),
              ),

              SizedBox(height: 12.h),

              // Order Info Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Order Id: ${cubit.orderId ?? '123456'}",
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                  Text(
                    cubit.orderDate ?? "Mon 4 August, 2025",
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  double _getProgressFactor(OrderDetailStatus status) {
    switch (status) {
      case OrderDetailStatus.processing:
        return 0.25; // 25% progress
      case OrderDetailStatus.onWay:
        return 0.75; // 75% progress
      case OrderDetailStatus.delivered:
        return 1.0; // 100% progress
      case OrderDetailStatus.cancelled:
        return 0.0; // No progress
    }
  }

  String _getDeliveryText(OrderDetailStatus status) {
    switch (status) {
      case OrderDetailStatus.processing:
        return "Deliver between 10 Aug, 13 Aug";
      case OrderDetailStatus.onWay:
        return "On the way - Expected 11 Aug";
      case OrderDetailStatus.delivered:
        return "Delivered on Mon 11 Aug, 11:35 AM";
      case OrderDetailStatus.cancelled:
        return "Delivery cancelled";
    }
  }
}

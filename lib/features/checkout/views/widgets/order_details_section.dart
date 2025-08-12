import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lasco/core/constants/app_colors.dart';
import 'package:lasco/core/locale/app_loacl.dart';

class OrderDetailsSection extends StatelessWidget {
  final double subtotal;
  final double shipping;
  final double discount;
  final double total;
  final double paid;
  final double remaining;

  const OrderDetailsSection({
    super.key,
    required this.subtotal,
    required this.shipping,
    required this.discount,
    required this.total,
    required this.paid,
    required this.remaining,
  });

  @override
  Widget build(BuildContext context) {
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
            "order_details".tr(context),
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.black,
            ),
          ),
          SizedBox(height: 16.h),
          _buildOrderDetailRow(
              "subtotal".tr(context), "${subtotal.toInt()} LE"),
          SizedBox(height: 8.h),
          _buildOrderDetailRow(
              "shipping".tr(context), "${shipping.toInt()} LE"),
          if (discount > 0) ...[
            SizedBox(height: 8.h),
            _buildOrderDetailRow(
                "discount".tr(context), "-${discount.toInt()} LE",
                isDiscount: true),
          ],
          SizedBox(height: 16.h),
          Divider(color: Colors.grey[300]),
          SizedBox(height: 16.h),
          _buildOrderDetailRow("Paid", "${paid.toInt()} LE", isPaid: true),
          SizedBox(height: 8.h),
          _buildOrderDetailRow("Remaining", "${remaining.toInt()} LE",
              isRemaining: true),
        ],
      ),
    );
  }

  Widget _buildOrderDetailRow(String label, String value,
      {bool isDiscount = false,
      bool isPaid = false,
      bool isRemaining = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14.sp,
            color: isRemaining ? AppColors.orange : AppColors.black,
            fontWeight:
                isPaid || isRemaining ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14.sp,
            color: isDiscount
                ? Colors.green
                : isRemaining
                    ? AppColors.orange
                    : isPaid
                        ? AppColors.black
                        : Colors.grey[600],
            fontWeight: isDiscount || isPaid || isRemaining
                ? FontWeight.w600
                : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}

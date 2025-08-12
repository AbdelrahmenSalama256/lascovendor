import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lasco/core/constants/app_colors.dart';
import 'package:lasco/core/locale/app_loacl.dart';

import '../../../profile/views/widgets/my_orders_card.dart';

class NewOrdersSection extends StatelessWidget {
  const NewOrdersSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "new_orders".tr(context),
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.black,
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Text(
                "view_all".tr(context),
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.orange,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 16.h),
        OrderCard(
          image: "assets/images/png/test-product.png",
          orderId: "12345",
          date: "2025-08-11",
          productName: "Oatmeal Smoothie",
          description: "meal_and_snack".tr(context),
          total: "3840 LE",
          quantity: 2,
          onTap: () {},
        ),
        SizedBox(height: 12.h),
        OrderCard(
          image: "assets/images/png/test-product.png",
          orderId: "12346",
          date: "2025-08-11",
          productName: "Oatmeal Smoothie",
          description: "meal_and_snack".tr(context),
          total: "3840 LE",
          quantity: 1,
          onTap: () {},
        ),
        SizedBox(height: 20.h),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lasco/core/constants/app_colors.dart';

class MetricsGrid extends StatelessWidget {
  const MetricsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 16.w,
      mainAxisSpacing: 16.h,
      // childAspectRatio: 1.2,
      children: [
        _buildMetricCard(
          title: "New Orders",
          value: "340",
          icon: SvgPicture.asset(
            "assets/images/svg/new-orders.svg",
            width: 44.w,
          ),
          color: Colors.blue,
        ),
        _buildMetricCard(
          title: "Total Orders",
          value: "250",
          icon: SvgPicture.asset(
            "assets/images/svg/total-orders.svg",
            width: 44.w,
          ),
          color: Colors.green,
        ),
        _buildMetricCard(
          title: "Total Income",
          value: "250",
          icon: SvgPicture.asset(
            "assets/images/svg/total-incom.svg",
            width: 44.w,
          ),
          color: AppColors.orange,
        ),
        _buildMetricCard(
          title: "Average Rating",
          value: "4.5",
          icon: SvgPicture.asset(
            "assets/images/svg/av-rating.svg",
            width: 44.w,
          ),
          color: Colors.amber,
        ),
      ],
    );
  }

  Widget _buildMetricCard({
    required String title,
    required String value,
    required Widget icon,
    required Color color,
  }) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Color(0xffF7F7F7),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Padding(
              padding: EdgeInsets.all(10.w),
              child: icon,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // SizedBox(height: 10.h),
              Text(
                title,
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.grey,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                value,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.black,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

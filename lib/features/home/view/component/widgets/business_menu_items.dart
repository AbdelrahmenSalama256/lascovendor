import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lasco/core/constants/app_colors.dart';
import 'package:lasco/core/cubit/global_cubit.dart';
import 'package:lasco/core/locale/app_loacl.dart';

class BusinessMenuItems extends StatelessWidget {
  final bool notificationsEnabled;
  final ValueChanged<bool> onNotificationChanged;
  final VoidCallback onEditPressed;
  final VoidCallback onAddProductPressed;
  final VoidCallback onAddOfferPressed;
  final VoidCallback onProductsOffersPressed;
  final VoidCallback onOrdersPressed;

  const BusinessMenuItems({
    super.key,
    required this.notificationsEnabled,
    required this.onNotificationChanged,
    required this.onEditPressed,
    required this.onAddProductPressed,
    required this.onAddOfferPressed,
    required this.onProductsOffersPressed,
    required this.onOrdersPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 0.w),
      child: Column(
        children: [
          _buildMenuItem(
            icon: SvgPicture.asset(
              "assets/images/svg/edit.svg",
              width: 16.w,
              height: 16.h,
            ),
            title: "edit".tr(context),
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: 16.w,
              color: const Color(0XffB2B2B2),
            ),
            onTap: onEditPressed,
          ),
          _buildMenuItem(
            icon: SvgPicture.asset(
              "assets/images/svg/add_product.svg",
              width: 16.w,
              height: 16.h,
            ),
            title: "add_product".tr(context),
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: 16.w,
              color: const Color(0XffB2B2B2),
            ),
            onTap: onAddProductPressed,
          ),
          _buildMenuItem(
            icon: SvgPicture.asset(
              "assets/images/svg/add_offer.svg",
              width: 16.w,
              height: 16.h,
            ),
            title: "add_offer".tr(context),
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: 16.w,
              color: const Color(0XffB2B2B2),
            ),
            onTap: onAddOfferPressed,
          ),
          _buildMenuItem(
            icon: SvgPicture.asset(
              "assets/images/svg/products-offers.svg",
              width: 16.w,
              height: 16.h,
            ),
            title: "products_offers".tr(context),
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: 16.w,
              color: const Color(0XffB2B2B2),
            ),
            onTap: onProductsOffersPressed,
          ),
          _buildMenuItem(
            icon: SvgPicture.asset(
              "assets/images/svg/orders.svg",
              width: 16.w,
              height: 16.h,
            ),
            title: "orders".tr(context),
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: 16.w,
              color: const Color(0XffB2B2B2),
            ),
            onTap: onOrdersPressed,
          ),
          _buildMenuItem(
            icon: SvgPicture.asset(
              "assets/images/svg/notification.svg",
              width: 16.w,
              height: 16.h,
            ),
            title: "notification".tr(context),
            trailing: SizedBox(
              width: 40.w,
              child: FittedBox(
                child: CupertinoSwitch(
                  value: notificationsEnabled,
                  onChanged: onNotificationChanged,
                  activeTrackColor: AppColors.orange,
                ),
              ),
            ),
            onTap: () => onNotificationChanged(!notificationsEnabled),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required Widget icon,
    required String title,
    required Widget trailing,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xffF7F7F7),
        borderRadius: BorderRadius.circular(12.r),
      ),
      margin: EdgeInsets.only(bottom: 16.h),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.r),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: Row(
            children: [
              Container(
                width: 38.w,
                height: 38.w,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Padding(
                  padding: EdgeInsets.all(8.w),
                  child: icon,
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
              ),
              trailing,
            ],
          ),
        ),
      ),
    );
  }
}

class BusinessLogoutButton extends StatelessWidget {
  final VoidCallback onPressed;

  const BusinessLogoutButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(12.r),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          decoration: BoxDecoration(
            color: const Color(0xffFFD4D4),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Row(
            children: [
              Container(
                width: 38.w,
                height: 38.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Padding(
                  padding: EdgeInsets.all(8.w),
                  child: Transform.flip(
                    flipX: context.read<GlobalCubit>().language == "ar"
                        ? true
                        : false,
                    child: SvgPicture.asset(
                      "assets/images/svg/logout.svg",
                      width: 22.w,
                      height: 22.h,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 16.w),
              Text(
                "logout".tr(context),
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

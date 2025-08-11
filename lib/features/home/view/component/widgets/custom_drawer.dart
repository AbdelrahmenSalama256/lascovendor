import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lasco/core/component/widgets/app_custom_dialog.dart';
import 'package:lasco/core/constants/app_colors.dart';
import 'package:lasco/core/constants/navigation.dart';
import 'package:lasco/core/constants/widgets/print_util.dart';
import 'package:lasco/core/cubit/global_cubit.dart';
import 'package:lasco/core/locale/app_loacl.dart';
import 'package:lasco/features/auth/view/sign_up_screen.dart';
import 'package:lasco/features/brand/views/brand_details.dart';
import 'package:lasco/features/product/views/add_product_screen.dart';
import 'package:lasco/features/profile/views/edit_profile_screen.dart';

import 'business_menu_items.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  bool notificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: SafeArea(
        child: Column(
          children: [
            // Profile Header Section
            BusinessProfileHeader(),

            // Menu Items
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  children: [
                    SizedBox(height: 20.h),
                    BusinessMenuItems(
                      notificationsEnabled: notificationsEnabled,
                      onNotificationChanged: (value) {
                        setState(() => notificationsEnabled = value);
                      },
                      onEditPressed: () {
                        navigateTo(context, EditProfileScreen());
                      },
                      onAddProductPressed: () {
                        navigateTo(context, AddProductScreen());
                      },
                      onAddOfferPressed: _navigateToAddOffer,
                      onProductsOffersPressed: _navigateToProductsOffers,
                      onOrdersPressed: _navigateToOrders,
                    ),
                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            ),

            // Logout Button at Bottom
            BusinessLogoutButton(
              onPressed: () {
                Navigator.pop(context);
                _showLogoutDialog();
              },
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }

  void _navigateToAddProduct() {
    Navigator.pop(context);
    // Add navigation logic
    PrintUtil.debug("Navigate to Add Product");
  }

  void _navigateToAddOffer() {
    Navigator.pop(context);
    // Add navigation logic
    PrintUtil.debug("Navigate to Add Offer");
  }

  void _navigateToProductsOffers() {
    Navigator.pop(context);
    // Add navigation logic
    PrintUtil.debug("Navigate to Products & Offers");
  }

  void _navigateToOrders() {
    Navigator.pop(context);
    // Add navigation logic
    PrintUtil.debug("Navigate to Orders");
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (context) => CustomDialog(
        imagePath: context.read<GlobalCubit>().language == "ar"
            ? "assets/images/svg/exit-ar.svg"
            : "assets/images/svg/exit.svg",
        title: "are_you_sure_logout",
        subtitle: "",
        buttons: [
          DialogButton(
            text: "logout",
            backgroundColor: const Color(0xffFEEBE3),
            textStyle: TextStyle(
              color: AppColors.orange,
              fontSize: 13.sp,
              fontWeight: FontWeight.w400,
            ),
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context); // Close drawer
              navigateAndFinish(context, SignUpScreen());
            },
          ),
          DialogButton(
            text: "keep_me_in",
            backgroundColor: AppColors.orange,
            textStyle: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
            height: 56.h,
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}

class BusinessProfileHeader extends StatelessWidget {
  const BusinessProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 112.w,
          height: 112.w,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Image.asset(
            "assets/images/png/maz.png",
            width: 84.w,
            height: 84.h,
          ),
        ),
        SizedBox(height: 16.h),
        Text(
          "Mazaya",
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w400,
            color: AppColors.black,
          ),
        ),
        SizedBox(height: 5.h),
        InkWell(
          onTap: () {
            navigateTo(
                context,
                BrandDetailsScreen(
                  brand: BrandDetailsModel(
                      id: '0',
                      name: 'Mazaya',
                      logoText: 'Mazaya',
                      categories: 'Mazaya',
                      address: 'Mazaya'),
                ));
          },
          child: Text(
            "preview".tr(context),
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: Colors.grey[600],
            ),
          ),
        ),
      ],
    );
  }
}

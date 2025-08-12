import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lasco/core/component/widgets/app_custom_dialog.dart';
import 'package:lasco/core/constants/app_colors.dart';
import 'package:lasco/core/constants/navigation.dart';
import 'package:lasco/core/cubit/global_cubit.dart';
import 'package:lasco/core/locale/app_loacl.dart';
import 'package:lasco/features/auth/view/sign_up_screen.dart';
import 'package:lasco/features/brand/views/brand_details.dart';
import 'package:lasco/features/brand/views/offers_product_screen.dart';
import 'package:lasco/features/product/views/add_product_screen.dart';
import 'package:lasco/features/profile/views/edit_profile_screen.dart';
import 'package:lasco/features/profile/views/my_orders_screen.dart';

import '../../../../offers/views/add_offers_screen.dart';
import 'business_menu_items.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  bool notificationsEnabled = true;
  String selectedLanguage = "العربية";

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
                      selectedLanguage: selectedLanguage,
                      onNotificationChanged: (value) {
                        setState(() => notificationsEnabled = value);
                      },
                      onLanguageChanged: (language) {
                        setState(() => selectedLanguage = language);
                        context.read<GlobalCubit>().changeLanguage();
                      },
                      onEditPressed: () {
                        navigateTo(context, EditProfileScreen());
                      },
                      onAddProductPressed: () {
                        navigateTo(context, AddProductScreen());
                      },
                      onAddOfferPressed: () {
                        navigateTo(context, AddOffersScreen());
                      },
                      onProductsOffersPressed: () {
                        navigateTo(
                            context,
                            OffersProductScreen(
                              brand: BrandDetailsModel(
                                  id: '0',
                                  name: 'Mazaya',
                                  logoText: 'Mazaya',
                                  categories: 'Mazaya',
                                  address: 'Mazaya'),
                            ));
                      },
                      onOrdersPressed: () {
                        navigateTo(context, MyOrdersScreen());
                      },
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

  void _showLogoutDialog() async {
    await showDialog(
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
        SizedBox(
          height: 10.h,
        ),
        Container(
          width: 84.w,
          height: 84.h,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Image.asset(
            "assets/images/png/maz.png",
            fit: BoxFit.contain,
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

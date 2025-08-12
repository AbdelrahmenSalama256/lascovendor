import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lasco/core/component/custom_toast.dart';
import 'package:lasco/core/component/widgets/app_button.dart';
import 'package:lasco/core/component/widgets/app_text_field.dart';
import 'package:lasco/core/constants/app_colors.dart';
import 'package:lasco/core/locale/app_loacl.dart';
import 'package:lasco/features/auth/view/login_screen.dart';
import 'package:lasco/features/auth/view/otp_verification_screen.dart';

import '../../../core/constants/navigation.dart';
import '../../../core/utils/validator.dart';
import 'cubit/sign_up_cubit.dart';
import 'cubit/sign_up_state.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpCubit(),
      child: BlocBuilder<SignUpCubit, SignUpState>(
        builder: (context, state) {
          final cubit = context.read<SignUpCubit>();
          return BlocListener<SignUpCubit, SignUpState>(
            listener: (context, state) {
              if (state is SignUpSuccess) {
                navigateTo(
                    context,
                    OtpVerificationScreen(
                        isResetPassword: true,
                        phoneNumber: cubit.phoneController.text));
              } else if (state is SignUpError) {
                showToast(context,
                    message: state.errorMessage, state: ToastStates.error);
              }
            },
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: Color(0xfffeac85),
              body: Stack(
                children: [
                  Positioned.fill(
                    bottom: 0,
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 10.h, horizontal: 16.w),
                      child: Image.asset(
                        "assets/images/png/auth.jpg",
                        width: double.infinity,
                        fit: BoxFit.contain,
                        height: double.infinity,
                        alignment: Alignment.topCenter,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    top: 200.w,
                    child: Container(
                      clipBehavior: Clip.hardEdge,
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadiusDirectional.only(
                          topEnd: Radius.circular(100.r),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 15.r,
                            offset: Offset(0, -2),
                          ),
                        ],
                      ),
                      child: SingleChildScrollView(
                        child: Form(
                          key: cubit.formKey,
                          child: Column(
                            children: [
                              Text(
                                "text_sign_up".tr(context),
                                style: TextStyle(
                                  fontSize: 24.sp,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.orange,
                                ),
                              ),
                              SizedBox(height: 20.h),

                              // Brand Logo Section
                              _buildBrandLogoSection(context, cubit),
                              SizedBox(height: 25.h),

                              // Name Field
                              // Store Name Field
                              AppTextField(
                                radius: BorderRadiusDirectional.circular(12.r),
                                controller: cubit.storeNameController,
                                hintText: "enter_store_name".tr(context),
                                labelText: "store_name".tr(context),
                                validator: (value) =>
                                    Validators.validateRequired(value,
                                        "store_name".tr(context), context),
                              ),
                              SizedBox(height: 25.h),

// Phone Number Field
                              AppTextField(
                                radius: BorderRadiusDirectional.circular(12.r),
                                controller: cubit.phoneController,
                                hintText: "enter_phone_number".tr(context),
                                labelText: "phone_number".tr(context),
                                keyboardType: TextInputType.phone,
                                validator: (value) =>
                                    Validators.validatePhone(value, context),
                              ),
                              SizedBox(height: 25.h),

// Password Field
                              AppTextField(
                                radius: BorderRadiusDirectional.circular(12.r),
                                controller: cubit.passwordController,
                                hintText: "enter_password".tr(context),
                                labelText: "password".tr(context),
                                obscureText: true,
                                validator: (value) =>
                                    Validators.validatePassword(value, context),
                              ),
                              SizedBox(height: 25.h),

// Confirm Password Field
                              AppTextField(
                                radius: BorderRadiusDirectional.circular(12.r),
                                controller: cubit.confirmPasswordController,
                                hintText: "confirm_password".tr(context),
                                labelText: "confirm_password".tr(context),
                                obscureText: true,
                                validator: (value) =>
                                    Validators.validateConfirmPassword(value,
                                        cubit.passwordController.text, context),
                              ),
                              SizedBox(height: 25.h),

// Store Address Field
                              AppTextField(
                                radius: BorderRadiusDirectional.circular(12.r),
                                controller: cubit.storeAddressController,
                                hintText: "enter_store_address".tr(context),
                                labelText: "store_address".tr(context),
                                validator: (value) =>
                                    Validators.validateRequired(value,
                                        "store_address".tr(context), context),
                              ),
                              SizedBox(height: 25.h),

// Store Description Field
                              AppTextField(
                                radius: BorderRadiusDirectional.circular(12.r),
                                controller: cubit.storeDescriptionController,
                                hintText: "store_description".tr(context),
                                labelText: "store_description".tr(context),
                                maxLines: 3,
                                validator: (value) =>
                                    Validators.validateRequired(
                                        value,
                                        "store_description".tr(context),
                                        context),
                              ),
                              SizedBox(height: 25.h),

// Brand Category Dropdown
                              DropdownButtonFormField<String>(
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Color(0xFFF8F8F8),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12.r),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                                hint: Text("brand_category".tr(context)),
                                value: cubit.selectedCategory,
                                onChanged: (value) =>
                                    cubit.setBrandCategory(value),
                                items: cubit.categories
                                    .map((category) => DropdownMenuItem(
                                          value: category,
                                          child: Text(category),
                                        ))
                                    .toList(),
                                validator: (value) => value == null
                                    ? "select_brand_category".tr(context)
                                    : null,
                              ),
                              SizedBox(height: 25.h),

// Sign Up Button
                              AppButton(
                                text: "sign_up".tr(context),
                                backgroundColor: AppColors.orange,
                                onPressed: () => cubit.signUp,
                              ),
                              SizedBox(height: 25.h),

                              // Already have account text
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      navigateTo(context, LoginScreen());
                                    },
                                    child: Text(
                                      "already_have_an_account".tr(context),
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.black,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 8.w),
                                  InkWell(
                                    onTap: () {
                                      navigateTo(context, LoginScreen());
                                    },
                                    child: Text(
                                      "text_login".tr(context),
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.orange,
                                        decoration: TextDecoration.underline,
                                        decorationColor: AppColors.orange,
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              // Space for keyboard
                              SizedBox(
                                height:
                                    MediaQuery.of(context).viewInsets.bottom,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBrandLogoSection(BuildContext context, SignUpCubit cubit) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "brand_logo".tr(context),
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: AppColors.black,
          ),
        ),
        SizedBox(height: 12.h),
        BlocBuilder<SignUpCubit, SignUpState>(
          builder: (context, state) {
            return GestureDetector(
              onTap: () => _showImagePickerBottomSheet(context, cubit),
              child: Container(
                width: double.infinity,
                height: 56.h,
                decoration: BoxDecoration(
                  color: const Color(0xFFF8F8F8),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: CustomPaint(
                  painter: DashedBorderPainter(
                    color: Color(0xffB2B2B2),
                    strokeWidth: 1.5,
                    dashWidth: 8.0,
                    dashSpace: 4.0,
                    borderRadius: 12.r,
                  ),
                  child: Container(
                    alignment: AlignmentDirectional.centerStart,
                    width: double.infinity,
                    height: double.infinity,
                    child: cubit.brandLogo != null
                        ? _buildSelectedImage(cubit.brandLogo!, cubit)
                        : _buildUploadPlaceholder(context),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildUploadPlaceholder(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Text(
        "upload_brand_logo".tr(context),
        style: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
          color: Color(0xffB2B2B2),
        ),
      ),
    );
  }

  void _showImagePickerBottomSheet(
      BuildContext context, SignUpCubit cubit) async {
    await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.all(20.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            SizedBox(height: 20.h),
            Text(
              "select_image_source".tr(context),
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.black,
              ),
            ),
            SizedBox(height: 20.h),
            Row(
              children: [
                Expanded(
                  child: _buildImageSourceOption(
                    context,
                    icon: Icons.photo_library_outlined,
                    title: "gallery".tr(context),
                    onTap: () {
                      Navigator.pop(context);
                      cubit.pickBrandLogo();
                    },
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: _buildImageSourceOption(
                    context,
                    icon: Icons.camera_alt_outlined,
                    title: "camera".tr(context),
                    onTap: () {
                      Navigator.pop(context);
                      cubit.takeBrandLogoPhoto();
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectedImage(File imageFile, SignUpCubit cubit) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.all(4.w),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: Image.file(
              imageFile,
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          top: 8.h,
          right: 8.w,
          child: GestureDetector(
            onTap: cubit.removeBrandLogo,
            child: Container(
              width: 24.w,
              height: 24.h,
              decoration: BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 4.r,
                    offset: Offset(0, 2.h),
                  ),
                ],
              ),
              child: Icon(
                Icons.close,
                color: Colors.white,
                size: 14.sp,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildImageSourceOption(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16.h),
        decoration: BoxDecoration(
          color: AppColors.orange.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: AppColors.orange.withOpacity(0.2),
            width: 1,
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              size: 32.sp,
              color: AppColors.orange,
            ),
            SizedBox(height: 8.h),
            Text(
              title,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DashedBorderPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double dashWidth;
  final double dashSpace;
  final double borderRadius;

  DashedBorderPainter({
    required this.color,
    required this.strokeWidth,
    required this.dashWidth,
    required this.dashSpace,
    required this.borderRadius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final path = Path()
      ..addRRect(RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, size.height),
        Radius.circular(borderRadius),
      ));

    final dashPath = _createDashedPath(path, dashWidth, dashSpace);
    canvas.drawPath(dashPath, paint);
  }

  Path _createDashedPath(Path source, double dashWidth, double dashSpace) {
    final Path dashedPath = Path();
    final PathMetrics pathMetrics = source.computeMetrics();

    for (PathMetric pathMetric in pathMetrics) {
      double distance = 0.0;
      bool draw = true;

      while (distance < pathMetric.length) {
        final double length = draw ? dashWidth : dashSpace;
        if (distance + length > pathMetric.length) {
          if (draw) {
            dashedPath.addPath(
              pathMetric.extractPath(distance, pathMetric.length),
              Offset.zero,
            );
          }
          break;
        } else {
          if (draw) {
            dashedPath.addPath(
              pathMetric.extractPath(distance, distance + length),
              Offset.zero,
            );
          }
          distance += length;
          draw = !draw;
        }
      }
    }

    return dashedPath;
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

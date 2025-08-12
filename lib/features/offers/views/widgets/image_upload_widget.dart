import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lasco/core/locale/app_loacl.dart';

import '../../../auth/view/sign_up_screen.dart';

class ImageUploadWidget extends StatelessWidget {
  final List<File> productImages;
  final VoidCallback onAddImage;
  final Function(int) onRemoveImage;

  const ImageUploadWidget({
    super.key,
    required this.productImages,
    required this.onAddImage,
    required this.onRemoveImage,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: GestureDetector(
            onTap: onAddImage,
            child: CustomPaint(
              painter: DashedBorderPainter(
                color: const Color(0xff2b2b266),
                strokeWidth: 1.5,
                dashWidth: 8.0,
                dashSpace: 4.0,
                borderRadius: 12.r,
              ),
              child: Container(
                width: 112.w,
                height: 112.h,
                decoration: BoxDecoration(
                  color: const Color(0xffF7F7F7),
                  borderRadius: BorderRadiusDirectional.circular(12.r),
                ),
                child: productImages.isEmpty
                    ? Padding(
                        padding: EdgeInsets.all(30.w),
                        child: SvgPicture.asset(
                          "assets/images/svg/camera-shot.svg",
                          width: 40.w,
                          height: 20.h,
                          color: const Color(0xffB2B2B2).withAlpha(40),
                        ),
                      )
                    : _buildImagePreview(),
              ),
            ),
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          'upload_product_images'.tr(context),
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: const Color(0xffB2B2B2),
          ),
        ),
      ],
    );
  }

  Widget _buildImagePreview() {
    return Container(
      padding: EdgeInsets.all(8.w),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          crossAxisSpacing: 8.w,
          mainAxisSpacing: 8.h,
        ),
        itemCount: productImages.length + 1,
        itemBuilder: (context, index) {
          if (index == productImages.length) {
            return GestureDetector(
              onTap: onAddImage,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(
                  Icons.add,
                  color: Colors.grey[600],
                  size: 24.sp,
                ),
              ),
            );
          }
          return Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: Image.file(
                  productImages[index],
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 4.h,
                right: 4.w,
                child: GestureDetector(
                  onTap: () => onRemoveImage(index),
                  child: Container(
                    width: 20.w,
                    height: 20.h,
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 12.sp,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

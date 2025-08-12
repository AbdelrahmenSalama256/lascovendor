import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lasco/core/component/widgets/app_dropdown.dart';
import 'package:lasco/core/constants/app_colors.dart';
import 'package:lasco/core/locale/app_loacl.dart';

class CategoryDropdown extends StatelessWidget {
  final String? value;
  final List<String> items;
  final ValueChanged<String?> onChanged;
  final FormFieldValidator<String>? validator;

  const CategoryDropdown({
    super.key,
    required this.value,
    required this.items,
    required this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return AppDropdownField(
      hint: 'category'.tr(context),
      value: value,
      items: items,
      selectedTextStyle: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
        color: AppColors.black,
      ),
      contentPadding: EdgeInsets.symmetric(
        horizontal: 5.w,
        vertical: 5.h,
      ),
      radius: BorderRadiusDirectional.circular(12.r),
      onChanged: onChanged,
      hintStyle: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
        color: AppColors.black,
      ),
      validator: validator,
    );
  }
}

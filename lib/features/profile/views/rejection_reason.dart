import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lasco/core/component/widgets/app_button.dart';
import 'package:lasco/core/component/widgets/app_text_field.dart';
import 'package:lasco/core/constants/app_colors.dart';
import 'package:lasco/core/locale/app_loacl.dart';

class RejectionReason extends StatefulWidget {
  const RejectionReason({super.key});

  @override
  State<RejectionReason> createState() => _RejectionReasonState();
}

class _RejectionReasonState extends State<RejectionReason> {
  final reasons = [
    "delivery_address_not_serviceable",
    "payment_issue",
    "quality_issue",
    "minimum_order_quantity_not_met",
  ];

  String? selectedReason;
  final otherReasonController = TextEditingController();
  @override
  void dispose() {
    otherReasonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16.w).copyWith(
          bottom: MediaQuery.of(context).viewInsets.bottom + 16.w,
        ),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "order_rejection".tr(context),
                style: TextStyle(
                  fontSize: 22.sp,
                  color: AppColors.orange,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                "order_rejection_message".tr(context),
                style: TextStyle(
                  fontSize: 14.sp,
                  color: AppColors.grey,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16.h),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // spacing: 0,
                children: [
                  ...reasons.map((reason) {
                    return RadioListTile<String>(
                      value: reason,
                      groupValue: selectedReason,
                      activeColor: AppColors.secoundry,
                      onChanged: (value) {
                        setState(() {
                          selectedReason = value;
                        });
                      },
                      title: Text(
                        reason.tr(context),
                        style: TextStyle(
                            fontSize: 14.sp,
                            color: AppColors.black,
                            fontWeight: FontWeight.w400),
                      ),
                      contentPadding: EdgeInsets.zero,
                      dense: true,
                    );
                  }),
                  SizedBox(height: 8.h),
                  Text(
                    "other_reason".tr(context),
                    style:
                        TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 8.h),
                  AppTextField(
                    controller: otherReasonController,
                    maxLines: 4,
                    radius: BorderRadiusDirectional.circular(12.r),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 12.h,
                    ),
                    hintText: "other_reason_hint".tr(context),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              Row(
                children: [
                  Expanded(
                    child: AppButton(
                      text: "cancel".tr(context),
                      backgroundColor: const Color(0xffFEEBE3),
                      borderRadius: BorderRadius.circular(12.r),
                      textStyle: TextStyle(
                        color: AppColors.orange,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w400,
                      ),
                      onPressed: () {},
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: AppButton(
                      text: "confirm".tr(context),
                      backgroundColor: AppColors.orange,
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

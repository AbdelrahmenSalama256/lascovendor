import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lasco/core/constants/app_colors.dart';
import 'package:lasco/core/locale/app_loacl.dart';

class ApplySaleToggle extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const ApplySaleToggle({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 40.w,
          child: FittedBox(
            child: CupertinoSwitch(
              value: value,
              onChanged: onChanged,
              activeTrackColor: AppColors.orange,
            ),
          ),
        ),
        SizedBox(width: 8.w),
        Text(
          'apply_sale'.tr(context),
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.orange,
          ),
        ),
      ],
    );
  }
}

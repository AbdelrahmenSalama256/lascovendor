import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppDropdownField extends StatefulWidget {
  final String hint;
  final String? value;
  final List<String> items;
  final ValueChanged<String?> onChanged;
  final FormFieldValidator<String>? validator;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final EdgeInsetsGeometry? contentPadding;
  final TextStyle? hintStyle;
  final TextStyle? selectedTextStyle;
  final bool enabled;
  final BorderRadiusDirectional? radius;
  final FocusNode? focusNode;
  final TextDirection? textDirection;

  const AppDropdownField({
    super.key,
    required this.hint,
    this.value,
    required this.items,
    required this.onChanged,
    this.validator,
    this.prefixIcon,
    this.suffixIcon,
    this.contentPadding,
    this.hintStyle,
    this.selectedTextStyle,
    this.enabled = true,
    this.radius,
    this.focusNode,
    this.textDirection,
  });

  @override
  State<AppDropdownField> createState() => _AppDropdownFieldState();
}

class _AppDropdownFieldState extends State<AppDropdownField> {
  late FocusNode _focusNode;
  bool _hasFocus = false;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(() {
      setState(() {
        _hasFocus = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    BorderRadius effectiveRadius =
        (widget.radius ?? BorderRadiusDirectional.circular(64.r))
            .resolve(Directionality.of(context));

    return InputDecorator(
      decoration: InputDecoration(
        labelText: widget.hint,
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.suffixIcon ?? const Icon(Icons.keyboard_arrow_down),
        filled: true,
        contentPadding: widget.contentPadding ??
            EdgeInsets.symmetric(
              horizontal: 13.w,
              vertical: 13.h,
            ),
        border: OutlineInputBorder(
          borderRadius: effectiveRadius,
          borderSide: const BorderSide(
            color: Color(0xffF7F7F7),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: effectiveRadius,
          borderSide: const BorderSide(color: Color(0xffF7F7F7)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: effectiveRadius,
          borderSide: const BorderSide(
            color: Colors.transparent,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: effectiveRadius,
          borderSide: const BorderSide(
            color: Color(0xFFE53935),
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: effectiveRadius,
          borderSide: const BorderSide(
            color: Color(0xFFE53935),
            width: 2,
          ),
        ),
        fillColor: const Color(0xffF7F7F7),
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        alignLabelWithHint: true,
        labelStyle: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          color: _hasFocus ? const Color(0xff515151) : const Color(0xff515151),
        ),
        hintStyle: widget.hintStyle ??
            TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              color: const Color(0xffB2B2B2),
            ),
      ),
      isEmpty: widget.value == null || widget.value!.isEmpty,
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: widget.value,
          isExpanded: true,
          hint: Text(
            widget.hint,
            style: widget.hintStyle ??
                TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xffB2B2B2),
                ),
          ),
          icon: const SizedBox.shrink(), // We handle the icon in InputDecorator
          onChanged: widget.enabled ? widget.onChanged : null,
          items: widget.items.map((item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(
                item,
                style: widget.selectedTextStyle ??
                    TextStyle(
                      fontSize: 18.sp,
                      color: const Color(0xff384048),
                    ),
                textDirection: widget.textDirection,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

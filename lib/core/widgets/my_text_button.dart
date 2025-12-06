import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyTextButton extends StatelessWidget {
  const MyTextButton({
    super.key,
    this.borderRadius,
    this.height,
    this.width,
    this.backgroundColor,
    required this.text,
    this.textStyle,
    required this.onPressed,
    this.horizontalPadding,
  });

  final double? borderRadius;
  final double? height;
  final double? width;
  final Color? backgroundColor;
  final String text;
  final TextStyle? textStyle;
  final void Function() onPressed;
  final double? horizontalPadding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding ?? 0),
      child: TextButton(
        style: ButtonStyle(
          padding: WidgetStateProperty.all(EdgeInsets.zero),
          visualDensity: const VisualDensity(horizontal: 0, vertical: 0),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.circular(
                borderRadius ?? 12.dg,
              ),
            ),
          ),
          backgroundColor: WidgetStateProperty.all(backgroundColor),
          fixedSize: WidgetStateProperty.all(
            Size(width ?? double.maxFinite, height ?? 48.h),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style:
              textStyle ??
              Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
        ),
      ),
    );
  }
}

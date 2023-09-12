import 'package:flutter/material.dart';

import '../../../config/app_theme.dart';

class AppDotIconWidget extends StatelessWidget {
  final double? height;
  final double? width;
  final Color? color;
  final double? borderRadius;

  const AppDotIconWidget(
      {super.key, this.height, this.width, this.color, this.borderRadius});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? AppThemeExt.of.majorScale(1),
      width: width ?? AppThemeExt.of.majorScale(1),
      decoration: BoxDecoration(
          color: color ?? AppColors.of.grayColor[10],
          borderRadius: BorderRadius.circular(
              borderRadius ?? AppThemeExt.of.majorScale(60 / 4))),
    );
  }
}

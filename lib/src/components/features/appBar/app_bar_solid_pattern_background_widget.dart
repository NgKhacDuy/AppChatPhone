import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resources/resources.dart';

import '../../../config/app_theme.dart';

class AppBarSolidPatternBackgroundWidget {
  final double? height;
  final bool? canBack;
  final Widget? title;
  final Widget? leading;
  final Widget? trailing;
  final Widget? bottom;

  AppBarSolidPatternBackgroundWidget({
    this.height,
    this.canBack,
    this.title,
    this.leading,
    this.trailing,
    this.bottom,
  });

  PreferredSize build(BuildContext context) {
    Widget leadingWidget = canBack == true
        ? InkWell(
            onTap: () {
              Get.back();
            },
            child: R.svgs.icArrowLeft.svg(
              colorFilter: ColorFilter.mode(
                AppColors.of.whiteColor,
                BlendMode.srcIn,
              ),
            ),
          )
        : (leading ?? const SizedBox());

    return PreferredSize(
      preferredSize: Size.fromHeight(height ?? kToolbarHeight),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.of.primaryColor,
          image: DecorationImage(
            image: R.pngs.topBar.image().image,
            fit: BoxFit.cover,
            alignment: Alignment.topCenter,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppThemeExt.of.majorScale(4),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.only(
                    top: AppThemeExt.of.majorScale(1),
                  ),
                  height: kToolbarHeight,
                  child: NavigationToolbar(
                    leading: leadingWidget,
                    middle: title ?? const SizedBox(),
                    trailing: trailing ?? const SizedBox(),
                    centerMiddle: true,
                  ),
                ),
                if (bottom != null) bottom!,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

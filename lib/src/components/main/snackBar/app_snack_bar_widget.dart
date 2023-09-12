part of 'app_snack_bar_base_builder.dart';

class AppSnackBarWidget extends AppSnackBarBaseBuilder {
  @override
  void showSnackBar(BuildContext context) {
    Get.rawSnackbar(
      margin: _marginSnackBar ??
          EdgeInsets.only(
            bottom: AppThemeExt.of.majorMarginScale(2),
            left: AppThemeExt.of.majorMarginScale(4),
            right: AppThemeExt.of.majorMarginScale(4),
          ),
      padding: EdgeInsets.zero,
      snackPosition: _showOnTop ?? SnackPosition.BOTTOM,
      backgroundColor: Colors.transparent,
      duration: const Duration(seconds: 4),
      messageText: Container(
        decoration: BoxDecoration(
          color: getBackgroundColor,
          border: Border.all(
            color: getBorderColor!, // Set the border color
            width: 1.0, // Set the border width
          ),
          borderRadius: BorderRadius.circular(
              AppThemeExt.of.majorScale(1)), // Set the border radius
        ),
        child: Padding(
          padding: EdgeInsets.all(AppThemeExt.of.majorPaddingScale(3)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  margin: EdgeInsets.only(
                      top: AppThemeExt.of.majorMarginScale(2 / 4)),
                  child: _prefixWidget ?? getPrefixIcon!),
              SizedBox(
                width: AppThemeExt.of.majorPaddingScale(1),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (_appSnackBarType == AppSnackBarType.informMessage)
                      AppTextBody1Widget()
                          .setText(_labelText)
                          .setTextStyle(
                              const TextStyle(fontWeight: FontWeight.bold))
                          .setColor(AppColors.of.grayColor[10])
                          .build(context),
                    _content ?? const SizedBox()
                  ],
                ),
              ),
              _suffixWidget ??
                  (_appSnackBarType == AppSnackBarType.informMessage
                      ? AppOutlinedButtonWidget()
                          .setButtonText(_buttonText ?? R.strings.gotIt)
                          .setAppButtonType(getSuffixButtonType)
                          .setAppButtonSize(AppButtonSize.medium)
                          .setOnPressed(() {
                          _onPress?.call();
                          Get.back();
                        }).build(context)
                      : InkWell(
                          onTap: () {
                            _onPress?.call();
                            Get.back();
                          },
                          customBorder: const CircleBorder(),
                          splashColor: AppColors.of.grayColor[3],
                          child: R.svgs.icClose.svg(
                              height: AppThemeExt.of.majorScale(18 / 4),
                              width: AppThemeExt.of.majorScale(18 / 4))))
            ],
          ),
        ),
      ),
    );
  }

  Color? get getBackgroundColor {
    if (_appSnackBarStatus == AppSnackBarStatus.info) {
      return AppColors.of.lightBlueColor[1];
    } else if (_appSnackBarStatus == AppSnackBarStatus.warning) {
      return AppColors.of.secondaryColor[1];
    } else if (_appSnackBarStatus == AppSnackBarStatus.error) {
      return AppColors.of.redColor[1];
    } else {
      return AppColors.of.greenColor[1];
    }
  }

  Color? get getBorderColor {
    if (_appSnackBarStatus == AppSnackBarStatus.info) {
      return AppColors.of.lightBlueColor[3];
    } else if (_appSnackBarStatus == AppSnackBarStatus.warning) {
      return AppColors.of.secondaryColor[3];
    } else if (_appSnackBarStatus == AppSnackBarStatus.error) {
      return AppColors.of.redColor[3];
    } else {
      return AppColors.of.greenColor[3];
    }
  }

  Widget? get getPrefixIcon {
    if (_appSnackBarStatus == AppSnackBarStatus.info) {
      return R.svgs.icFilledInfoCircle.svg();
    } else if (_appSnackBarStatus == AppSnackBarStatus.warning) {
      return R.svgs.icWarningCircle.svg();
    } else if (_appSnackBarStatus == AppSnackBarStatus.error) {
      return R.svgs.icErrorCircle.svg();
    } else {
      return R.svgs.icSuccessCircle.svg();
    }
  }

  AppButtonType? get getSuffixButtonType =>
      _appSnackBarStatus == AppSnackBarStatus.error
          ? AppButtonType.danger
          : AppButtonType.standard;

  @override
  AppSnackBarWidget setAppSnackBarStatus(AppSnackBarStatus? appSnackBarStatus) {
    _appSnackBarStatus = appSnackBarStatus;
    return this;
  }

  @override
  AppSnackBarWidget setAppSnackBarType(AppSnackBarType? appSnackBarType) {
    _appSnackBarType = appSnackBarType;
    return this;
  }

  @override
  AppSnackBarWidget setContent(Widget? content) {
    _content = content;
    return this;
  }

  @override
  AppSnackBarWidget setLabelText(String? labelText) {
    _labelText = labelText;
    return this;
  }

  @override
  AppSnackBarWidget setOnPress(void Function()? onPress) {
    _onPress = onPress;
    return this;
  }

  @override
  AppSnackBarWidget setPrefixWidget(Widget? prefixWidget) {
    _prefixWidget = prefixWidget;
    return this;
  }

  @override
  AppSnackBarWidget setSuffixWidget(Widget? suffixWidget) {
    _suffixWidget = suffixWidget;
    return this;
  }

  @override
  AppSnackBarWidget setButtonText(String? buttonText) {
    _buttonText = buttonText;
    return this;
  }

  @override
  AppSnackBarWidget setMarginSnackBar(EdgeInsets? marginSnackBar) {
    _marginSnackBar = marginSnackBar;
    return this;
  }

  @override
  AppSnackBarWidget setShowOnTop(SnackPosition? showOnTop) {
    _showOnTop = showOnTop;
    return this;
  }
}

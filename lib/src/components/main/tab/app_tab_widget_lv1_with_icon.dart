part of 'app_tab_base_builder.dart';

class AppTabWidgetLv1WithIcon extends AppTabBaseBuilder {
  @override
  AppTabWidgetLv1WithIcon setText(String text) {
    _text = text;
    return this;
  }

  @override
  AppTabBaseBuilder setIconSelected(SvgPicture iconSelected) {
    _iconSelected = iconSelected;
    return this;
  }

  @override
  AppTabBaseBuilder setIconDefault(SvgPicture iconDefault) {
    _iconDefault = iconDefault;
    return this;
  }

  @override
  AppTabWidgetLv1WithIcon setIsSelected(bool isSelected) {
    _isSelected = isSelected;
    return this;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:
          EdgeInsets.symmetric(vertical: AppThemeExt.of.majorMarginScale(4)),
      child: _isSelected!
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: AppThemeExt.of.majorScale(14 / 4),
                  height: AppThemeExt.of.majorScale(14 / 4),
                  child: _iconSelected,
                ),
                SizedBox(
                  width: AppThemeExt.of.majorScale(1),
                ),
                AppTextBody1Widget()
                    .setText(_text)
                    .setTextAlign(TextAlign.center)
                    .setColor(AppColors.of.primaryColor)
                    .build(context),
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: AppThemeExt.of.majorScale(14 / 4),
                  height: AppThemeExt.of.majorScale(14 / 4),
                  child: _iconDefault,
                ),
                SizedBox(
                  width: AppThemeExt.of.majorScale(1),
                ),
                AppTextBody1Widget()
                    .setText(_text)
                    .setTextAlign(TextAlign.center)
                    .setColor(AppColors.of.grayColor[7])
                    .build(context),
              ],
            ),
    );
  }
}

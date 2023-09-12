part of 'app_tab_base_builder.dart';

class AppTabWidgetLv1WithNumber extends AppTabBaseBuilder {
  @override
  AppTabWidgetLv1WithNumber setText(String text) {
    _text = text;
    return this;
  }

  @override
  AppTabWidgetLv1WithNumber setIsSelected(bool isSelected) {
    _isSelected = isSelected;
    return this;
  }

  @override
  AppTabWidgetLv1WithNumber setNumber(Widget number) {
    _number = number;
    return this;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:
          EdgeInsets.symmetric(vertical: AppThemeExt.of.majorMarginScale(3)),
      child: _isSelected!
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppTextBody1Widget()
                    .setText(_text)
                    .setColor(AppColors.of.primaryColor)
                    .build(context),
                SizedBox(
                  width: AppThemeExt.of.majorScale(1),
                ),
                Container(
                  width: AppThemeExt.of.majorScale(4),
                  height: AppThemeExt.of.majorScale(4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.of.primaryColor,
                  ),
                  child: Center(
                    child: AppTextSubTitle2Widget()
                        .setText(_number.toString())
                        .setColor(AppColors.of.grayColor[1])
                        .setTextAlign(TextAlign.center)
                        .build(context),
                  ),
                ),
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppTextBody1Widget()
                    .setText(_text)
                    .setColor(AppColors.of.grayColor[7])
                    .build(context),
                SizedBox(
                  width: AppThemeExt.of.majorScale(0),
                  height: AppThemeExt.of.majorScale(0),
                ),
              ],
            ),
    );
  }
}

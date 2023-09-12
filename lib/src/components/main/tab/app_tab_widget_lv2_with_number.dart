part of 'app_tab_base_builder.dart';

class AppTabWidgetLv2WithNumber extends AppTabBaseBuilder {
  @override
  AppTabWidgetLv2WithNumber setText(String text) {
    _text = text;
    return this;
  }

  @override
  AppTabWidgetLv2WithNumber setIsSelected(bool isSelected) {
    _isSelected = isSelected;
    return this;
  }

  @override
  AppTabWidgetLv2WithNumber setNumber(Widget number) {
    _number = number;
    return this;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(
            AppThemeExt.of.majorScale(100),
          ),
        ),
        color: _isSelected == true
            ? AppColors.of.tealColor[1]
            : AppColors.of.whiteColor,
        border: Border.all(
          color: _isSelected == true
              ? AppColors.of.primaryColor
              : AppColors.of.grayColor[4]!,
          width: 1,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppThemeExt.of.majorScale(3),
          vertical: AppThemeExt.of.majorScale(5 / 4),
        ),
        child: _isSelected == true
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
                    decoration: BoxDecoration(
                      color: AppColors.of.primaryColor,
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          AppThemeExt.of.majorScale(100),
                        ),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppThemeExt.of.majorPaddingScale(6 / 4),
                        vertical: AppThemeExt.of.majorPaddingScale(3 / 4),
                      ),
                      child: Center(child: _number),
                    ),
                  ),
                ],
              )
            : AppTextBody1Widget()
                .setText(_text)
                .setColor(AppColors.of.grayColor[7])
                .build(context),
      ),
    );
  }
}

part of 'app_tab_base_builder.dart';

class AppTabWidgetLv2TextOnly extends AppTabBaseBuilder {
  @override
  AppTabWidgetLv2TextOnly setText(String text) {
    _text = text;
    return this;
  }

  @override
  AppTabWidgetLv2TextOnly setIsSelected(bool isSelected) {
    _isSelected = isSelected;
    return this;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius:
            BorderRadius.all(Radius.circular(AppThemeExt.of.majorScale(8))),
        color: _isSelected! ? AppColors.of.tealColor[1] : AppColors.of.whiteColor,
        border: Border.all(
          color: _isSelected! ? AppColors.of.primaryColor : AppColors.of.grayColor[4]!,
          width: 1,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(AppThemeExt.of.majorScale(2)),
        child: AppTextBody1Widget()
            .setText(_text)
            .setTextAlign(TextAlign.center)
            .setColor(_isSelected!
                ? AppColors.of.primaryColor
                : AppColors.of.grayColor[7])
            .build(context),
      ),
    );
  }
}

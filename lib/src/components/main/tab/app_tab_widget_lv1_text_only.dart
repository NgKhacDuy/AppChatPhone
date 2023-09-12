part of 'app_tab_base_builder.dart';

class AppTabWidgetLv1TextOnly extends AppTabBaseBuilder {
  @override
  AppTabWidgetLv1TextOnly setText(String text) {
    _text = text;
    return this;
  }

  @override
  AppTabWidgetLv1TextOnly setIsSelected(bool isSelected) {
    _isSelected = isSelected;
    return this;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:
          EdgeInsets.symmetric(vertical: AppThemeExt.of.majorMarginScale(4)),
      child: AppTextBody1Widget()
          .setText(_text)
          .setTextAlign(TextAlign.center)
          .setColor(_isSelected!
              ? AppColors.of.primaryColor
              : AppColors.of.grayColor[7])
          .build(context),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../config/app_theme.dart';
import '../text/app_text_base_builder.dart';

part 'app_tab_widget_lv1_text_only.dart';
part 'app_tab_widget_lv1_with_icon.dart';
part 'app_tab_widget_lv1_with_number.dart';
part 'app_tab_widget_lv2_text_only.dart';
part 'app_tab_widget_lv2_with_number.dart';

abstract class AppTabBaseBuilder {
  @protected
  String? _text;
  @protected
  SvgPicture? _iconSelected;
  @protected
  SvgPicture? _iconDefault;
  @protected
  bool? _isSelected;
  @protected
  Widget? _number;

  AppTabBaseBuilder setText(String text);

  AppTabBaseBuilder setIconSelected(SvgPicture iconSelected) {
    return this;
  }

  AppTabBaseBuilder setIconDefault(SvgPicture iconDefault) {
    return this;
  }

  AppTabBaseBuilder setIsSelected(bool isSelected);

  AppTabBaseBuilder setNumber(Widget number) {
    return this;
  }

  Widget build(BuildContext context);
}

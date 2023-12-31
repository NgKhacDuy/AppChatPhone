import 'package:flutter/material.dart';
import 'package:just_the_tooltip/just_the_tooltip.dart';

import '../../../config/app_theme.dart';
import '../text/app_text_base_builder.dart';

part 'app_tooltip_widget.dart';

abstract class AppTooltipBaseBuilder {
  @protected
  String? _text;
  @protected
  Color? _backgroundColor;
  @protected
  Widget? _icon;
  @protected
  AxisDirection? _preferredDirection;
  @protected
  Color? _textColor;

  Widget build(BuildContext context);

  AppTooltipBaseBuilder setText(String text);

  AppTooltipBaseBuilder setIcon(Widget icon);

  AppTooltipBaseBuilder setBackgroundColor(Color backgroundColor) {
    return this;
  }

  AppTooltipBaseBuilder setTextColor(Color textColor) {
    return this;
  }

  AppTooltipBaseBuilder setPreferredDirection(
      AxisDirection preferredDirection) {
    return this;
  }
}

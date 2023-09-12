import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:resources/resources.dart';
import '../../../config/app_theme.dart';
import '../button/app_button_base_builder.dart';
import '../text/app_text_base_builder.dart';

part 'app_bar_widget.dart';

part 'app_bar_leading_widget.dart';

part 'app_bar_leading_avatar_widget.dart';

abstract class AppBarBaseBuilder {
  @protected
  String? _headerPage;
  @protected
  Color? _headerPageColor;
  @protected
  Widget? _leading;
  @protected
  bool? _centerTitle;
  @protected
  List<Widget>? _actions;
  @protected
  Color? _backgroundColor;
  @protected
  Widget? _flexibleSpace;
  @protected
  PreferredSizeWidget? _bottom;

  AppBarBaseBuilder setHeaderPage(String? headerPage);

  AppBarBaseBuilder setHeaderPageColor(Color? headerPageColor) {
    return this;
  }

  AppBarBaseBuilder setLeading(Widget? leading) {
    return this;
  }

  AppBarBaseBuilder setCenterTitle(bool? centerTitle) {
    return this;
  }

  AppBarBaseBuilder setActions(List<Widget>? actions) {
    return this;
  }

  AppBarBaseBuilder setBackgroundColor(Color? backgroundColor) {
    return this;
  }

  AppBarBaseBuilder setFlexibleSpace(Widget? flexibleSpace) {
    return this;
  }

  AppBarBaseBuilder setBottom(PreferredSizeWidget? bottom) {
    return this;
  }

  PreferredSizeWidget build(BuildContext context);
}

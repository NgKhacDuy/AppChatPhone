import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'package:resources/resources.dart';
import '../../../config/app_theme.dart';
import '../../main/tab/app_tab_base_builder.dart';

part 'app_tab_bar_text_only_lv2_widget.dart';
part 'app_tab_bar_text_only_widget.dart';
part 'app_tab_bar_with_icon_widget.dart';
part 'app_tab_bar_with_number_lv2_widget.dart';
part 'app_tab_bar_with_number_widget.dart';

class AppTabController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;

  AppTabController(int tabLength) {
    tabController = TabController(length: tabLength, vsync: this);
  }
}

abstract class AppTabBarBaseBuilder {
  @protected
  List<String>? _tabTitleList;
  @protected
  List<Widget>? _tabNumberList;
  @protected
  List<SvgPicture>? _tabDefaultIconList;
  @protected
  List<SvgPicture>? _tabSelectedIconList;
  @protected
  List<Widget>? _tabViewList;
  @protected
  final RxInt _tabSelectedIndex = 0.obs;

  AppTabBarBaseBuilder setTabTitleList(List<String> tabTitleList);

  AppTabBarBaseBuilder setTabNumberList(List<Widget> tabNumberList) {
    return this;
  }

  AppTabBarBaseBuilder setTabDefaultIconList(
      List<SvgPicture> tabDefaultIconList) {
    return this;
  }

  AppTabBarBaseBuilder setTabSelectedIconList(
      List<SvgPicture> tabSelectedIconList) {
    return this;
  }

  AppTabBarBaseBuilder setTabViewList(List<Widget> tabViewList);

  Widget build(BuildContext context);
}

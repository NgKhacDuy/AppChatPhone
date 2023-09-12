import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../../config/app_theme.dart';

part 'app_bottom_navigation_bar_widget.dart';

abstract class AppBottomNavigationBarBaseBuilder {
  @protected
  late final PersistentTabController _controller;

  @protected
  List<PersistentBottomNavBarItem>? _items;

  @protected
  late final List<Widget> _buildScreen;

  @protected
  Colors? _colors;

  @protected
  late final NavBarStyle _style;

  AppBottomNavigationBarBaseBuilder setController(
      PersistentTabController value) {
    return this;
  }

  AppBottomNavigationBarBaseBuilder setItems(
      List<PersistentBottomNavBarItem>? value) {
    return this;
  }

  AppBottomNavigationBarBaseBuilder setBuildScreen(List<Widget> value) {
    return this;
  }

  AppBottomNavigationBarBaseBuilder setColors(Colors? value) {
    return this;
  }

  AppBottomNavigationBarBaseBuilder setStyle(NavBarStyle value) {
    return this;
  }

  Widget build(BuildContext context);
}

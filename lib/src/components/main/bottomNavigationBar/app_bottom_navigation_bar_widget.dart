part of 'app_bottom_navigation_bar_base.dart';

class AppBottomNavigationBarWidget extends AppBottomNavigationBarBaseBuilder {
  @override
  AppBottomNavigationBarBaseBuilder setItems(
      List<PersistentBottomNavBarItem>? value) {
    _items = value;
    return this;
  }

  AppBottomNavigationBarBaseBuilder setBuildScreen(List<Widget> value) {
    _buildScreen = value;
    return this;
  }

  AppBottomNavigationBarBaseBuilder setColors(Colors? value) {
    _colors = value;
    return this;
  }

  AppBottomNavigationBarBaseBuilder setStyle(NavBarStyle value) {
    _style = value;
    return this;
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      screens: _buildScreen,
      items: _items,
      confineInSafeArea: true,
      backgroundColor: AppColors.of.primaryColor,
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      hideNavigationBarWhenKeyboardShows: true,
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties(
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: _style,
    );
  }
}

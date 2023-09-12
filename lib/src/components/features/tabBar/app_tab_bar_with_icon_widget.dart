part of 'app_tab_bar_base_builder.dart';

class AppTabBarWithIconWidget extends AppTabBarBaseBuilder {
  @override
  AppTabBarWithIconWidget setTabTitleList(List<String> tabTitleList) {
    _tabTitleList = tabTitleList;
    return this;
  }

  @override
  Widget build(BuildContext context) {
    if (_isInputValidated()) {
      final appTabController = AppTabController(_tabTitleList!.length);
      appTabController.tabController.animation!.addListener(() {
        if (appTabController.tabController.indexIsChanging) {
          _updateSelectedIndex(appTabController.tabController.index);
        }
      });
      final tabList = _getTabListFromTitle(context);

      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TabBar(
            controller: appTabController.tabController,
            tabs: tabList,
            unselectedLabelColor: AppColors.of.grayColor[7],
            labelColor: AppColors.of.primaryColor,
            indicatorColor: AppColors.of.primaryColor,
            isScrollable: true,
          ),
          Expanded(
            child: TabBarView(
              controller: appTabController.tabController,
              children: _tabViewList!,
            ),
          )
        ],
      );
    }
    throw FormatException(R.strings.invalidInput);
  }

  void _updateSelectedIndex(int index) {
    _tabSelectedIndex.value = index;
  }

  List<Widget> _getTabListFromTitle(BuildContext context) {
    List<Widget> tabList = [];
    for (int i = 0; i < _tabTitleList!.length; i++) {
      tabList.add(
        Obx(
          () => i == _tabSelectedIndex.value
              ? AppTabWidgetLv1WithIcon()
                  .setText(_tabTitleList![i])
                  .setIconDefault(_tabDefaultIconList![i])
                  .setIconSelected(_tabSelectedIconList![i])
                  .setIsSelected(true)
                  .build(context)
              : AppTabWidgetLv1WithIcon()
                  .setText(_tabTitleList![i])
                  .setIconDefault(_tabDefaultIconList![i])
                  .setIconSelected(_tabSelectedIconList![i])
                  .setIsSelected(false)
                  .build(context),
        ),
      );
    }
    return tabList;
  }

  @override
  AppTabBarBaseBuilder setTabDefaultIconList(
      List<SvgPicture> tabDefaultIconList) {
    _tabDefaultIconList = tabDefaultIconList;
    return this;
  }

  @override
  AppTabBarBaseBuilder setTabSelectedIconList(
      List<SvgPicture> tabSelectedIconList) {
    _tabSelectedIconList = tabSelectedIconList;
    return this;
  }

  bool _isInputValidated() {
    if ((_tabTitleList == null) ||
        (_tabDefaultIconList == null) ||
        (_tabSelectedIconList == null)) {
      return false;
    } else if ((_tabTitleList!.length != _tabDefaultIconList!.length) ||
        (_tabTitleList!.length != _tabSelectedIconList!.length)) {
      return false;
    }
    return true;
  }

  @override
  AppTabBarBaseBuilder setTabViewList(List<Widget> tabViewList) {
    _tabViewList = tabViewList;
    return this;
  }
}

part of 'app_tab_bar_base_builder.dart';

class AppTabBarWithNumberLv2Widget extends AppTabBarBaseBuilder {
  @override
  AppTabBarWithNumberLv2Widget setTabTitleList(List<String> tabTitleList) {
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

      return Theme(
        data: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TabBar(
              padding: EdgeInsets.symmetric(
                horizontal: AppThemeExt.of.majorPaddingScale(4),
              ),
              controller: appTabController.tabController,
              tabs: tabList,
              unselectedLabelColor: AppColors.of.grayColor[7],
              labelColor: AppColors.of.primaryColor,
              indicatorColor: Colors.transparent,
              isScrollable: true,
              labelPadding: EdgeInsets.symmetric(
                horizontal: AppThemeExt.of.majorPaddingScale(1),
                vertical: AppThemeExt.of.majorPaddingScale(3),
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: appTabController.tabController,
                children: _tabViewList ?? [],
              ),
            )
          ],
        ),
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
              ? AppTabWidgetLv2WithNumber()
                  .setText(_tabTitleList![i])
                  .setNumber(_tabNumberList![i])
                  .setIsSelected(true)
                  .build(context)
              : AppTabWidgetLv2WithNumber()
                  .setText(_tabTitleList![i])
                  .setNumber(_tabNumberList![i])
                  .setIsSelected(false)
                  .build(context),
        ),
      );
    }
    return tabList;
  }

  @override
  AppTabBarBaseBuilder setTabNumberList(List<Widget> tabNumberList) {
    _tabNumberList = tabNumberList;
    return this;
  }

  bool _isInputValidated() {
    if ((_tabTitleList == null) || (_tabNumberList == null)) {
      return false;
    }
    if (_tabTitleList!.length != _tabNumberList!.length) {
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

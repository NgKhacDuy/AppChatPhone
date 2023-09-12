part of 'app_bar_base_builder.dart';

class AppBarWidget extends AppBarBaseBuilder {
  @override
  PreferredSizeWidget build(BuildContext context) {
    return AppBar(
      title: AppTextHeading3Widget().setText(_headerPage).setColor(_headerPageColor).build(context),
      centerTitle: _centerTitle,
      actions: _actions,
      backgroundColor: _backgroundColor ?? AppColors.of.grayColor[1],
      flexibleSpace: _flexibleSpace,
      bottom: _bottom,
    );
  }

  @override
  AppBarBaseBuilder setActions(List<Widget>? actions) {
    _actions = actions;
    return this;
  }

  @override
  AppBarBaseBuilder setBackgroundColor(Color? backgroundColor) {
    _backgroundColor = backgroundColor;
    return this;
  }

  @override
  AppBarBaseBuilder setBottom(PreferredSizeWidget? bottom) {
    _bottom = bottom;
    return this;
  }

  @override
  AppBarBaseBuilder setFlexibleSpace(Widget? flexibleSpace) {
    _flexibleSpace = flexibleSpace;
    return this;
  }

  @override
  AppBarBaseBuilder setCenterTitle(bool? centerTitle) {
    _centerTitle = centerTitle ?? true;
    return this;
  }

  @override
  AppBarBaseBuilder setHeaderPage(String? headerPage) {
    _headerPage = headerPage;
    return this;
  }

  @override
  AppBarBaseBuilder setHeaderPageColor(Color? headerPageColor) {
    _headerPageColor = headerPageColor;
    return this;
  }
}

part of 'search_controller.dart';

class SearchPage extends GetView<SearchUserController> {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(32.0),
    );
    return Container(
      padding: EdgeInsets.fromLTRB(
          AppThemeExt.of.majorMarginScale(6),
          AppThemeExt.of.majorMarginScale(8),
          AppThemeExt.of.majorMarginScale(6),
          AppThemeExt.of.majorMarginScale(6)),
      alignment: Alignment.center,
      child: Column(
        children: [
          TextField(
            onSubmitted: (value) {
              controller.findUserByName(value);
            },
            controller: controller._textEditingController,
            decoration: InputDecoration(
              labelText: 'Search your friends',
              contentPadding: EdgeInsets.fromLTRB(
                  AppThemeExt.of.majorMarginScale(7),
                  AppThemeExt.of.majorMarginScale(5),
                  AppThemeExt.of.majorMarginScale(3),
                  AppThemeExt.of.majorMarginScale(3)),
              focusedBorder: border,
              enabledBorder: border,
              errorBorder: border,
              border: border,
              disabledBorder: border,
              focusedErrorBorder: border,
            ),
          ),
        ],
      ),
    );
  }
}

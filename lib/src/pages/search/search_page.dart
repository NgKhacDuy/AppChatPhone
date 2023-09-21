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
          AppThemeExt.of.majorMarginScale(10),
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
          Obx(() => ListView.separated(
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    padding: EdgeInsets.all(AppThemeExt.of.majorMarginScale(4)),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: AppColors.of.grayColor[5]),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(controller.listUser[index].data['name']),
                        FaIcon(
                          FontAwesomeIcons.userPlus,
                          size: 16,
                          color: AppColors.of.grayColor[10],
                        )
                      ],
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider();
                },
                itemCount: controller.listUser.value.length ?? 0,
              )),
          TextButton(
              onPressed: () {
                controller.logout();
              },
              child: Text('log out'))
        ],
      ),
    );
  }
}

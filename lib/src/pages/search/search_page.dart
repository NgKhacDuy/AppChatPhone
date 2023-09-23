part of 'search_controller.dart';

class SearchPage extends GetView<SearchUserController> {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(32.0),
    );
    return RefreshIndicator(
      onRefresh: controller.getListRequest,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Container(
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
              SingleChildScrollView(
                child: Obx(() => ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          padding: EdgeInsets.all(
                              AppThemeExt.of.majorMarginScale(2)),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: controller.selectIndex.value == index
                                  ? AppColors.of.greenColor[4]
                                  : AppColors.of.grayColor[5]),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(controller.listUser[index].data['name']),
                              controller.listUser[index]
                                          .data['haveFriendRequest'] ==
                                      false
                                  ? IconButton(
                                      onPressed: () async {
                                        await controller.addFriendRequest(
                                            controller.listUser[index]
                                                .data['objectID']);
                                        controller.selectIndex.value = index;
                                      },
                                      icon: FaIcon(
                                        FontAwesomeIcons.userPlus,
                                        size: 16,
                                        color: AppColors.of.grayColor[10],
                                      ))
                                  : IconButton(
                                      onPressed: () {},
                                      icon: FaIcon(
                                        FontAwesomeIcons.userXmark,
                                        size: 16,
                                        color: AppColors.of.grayColor[10],
                                      ))
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(
                            height: AppThemeExt.of.majorMarginScale(4));
                      },
                      itemCount: controller.listUser.value.length ?? 0,
                    )),
              ),
              SizedBox(height: AppThemeExt.of.majorMarginScale(4)),
              const Text(
                'Danh sách lời mời kết bạn',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: AppThemeExt.of.majorMarginScale(2)),
              Obx(() => ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                          padding: EdgeInsets.all(
                              AppThemeExt.of.majorMarginScale(6)),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: AppColors.of.tealColor[3]),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(controller.listRequest[index].name),
                              Row(
                                children: [
                                  InkWell(
                                    child: FaIcon(
                                      FontAwesomeIcons.solidSquareCheck,
                                      size: 30,
                                      color: AppColors.of.greenColor,
                                    ),
                                    onTap: () async {
                                      await controller.acceptFriendRequest(
                                          controller.listRequest[index].uid);
                                    },
                                  ),
                                  SizedBox(
                                      width:
                                          AppThemeExt.of.majorMarginScale(4)),
                                  InkWell(
                                    child: FaIcon(
                                      FontAwesomeIcons.solidRectangleXmark,
                                      size: 30,
                                      color: AppColors.of.redColor,
                                    ),
                                    onTap: () async {
                                      await controller.rejectFriendRequest(
                                          controller.listRequest[index].uid);
                                    },
                                  )
                                ],
                              )
                            ],
                          ));
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(
                          height: AppThemeExt.of.majorMarginScale(4));
                    },
                    itemCount: controller.listRequest.length,
                  )),
              TextButton(
                  onPressed: () async {
                    await controller.getListRequest();
                  },
                  child: Text('log out'))
            ],
          ),
        ),
      ),
    );
  }
}

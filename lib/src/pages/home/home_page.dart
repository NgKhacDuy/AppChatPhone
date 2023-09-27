part of 'home_controller.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppMainPageWidget().setBody(body(context)).build(context);
  }

  Widget body(BuildContext context) {
    return Obx(() => Scaffold(
          body: controller.listScreen[controller.indexWidget.value],
          bottomNavigationBar: const GNav(
              backgroundColor: Colors.black,
              color: Colors.white,
              activeColor: Colors.white,
              gap: 4,
              tabs: [
                GButton(
                  icon: Icons.home,
                  text: 'Home',
                ),
                GButton(
                  icon: Icons.people,
                  text: 'Friends',
                ),
                GButton(
                  icon: Icons.settings,
                  text: 'Setting',
                )
              ]),
        ));
  }
}

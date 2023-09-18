part of 'home_controller.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppMainPageWidget().setBody(body(context)).build(context);
  }

  Widget body(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: const Text('this is home'),
    );
  }
}

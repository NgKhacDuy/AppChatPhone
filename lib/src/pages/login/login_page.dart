part of 'login_controller.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(AppThemeExt.of.majorPaddingScale(4)),
      child: Column(
        children: [
          Image(image: R.pngs.login.image().image),
          const Text(
            'Hello',
            style: TextStyle(fontSize: 28),
          ),
          SizedBox(height: AppThemeExt.of.majorMarginScale(4)),
          const Text(
            'Welcome to FAST CHATTER, where you can have a quick chat with you friends',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }
}

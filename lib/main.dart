import 'package:app_chat/src/components/main/overlay/app_loading_overlay_widget.dart';
import 'package:app_chat/src/config/app_theme.dart';
import 'package:app_chat/src/routes/app_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:resources/resources.dart';
import 'package:get/get.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Fsplash.preserve(widgetsBinding: WidgetsBinding.instance);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Fsplash.remove();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: AppThemeData.lightTheme,
      darkTheme: AppThemeData.darkTheme,
      initialRoute: Routes.login,
      getPages: AppPages.routes,
      smartManagement: SmartManagement.full,
      builder: AppLoadingOverlayWidget.init(),
      initialBinding: AppBinding(),
    );
  }
}

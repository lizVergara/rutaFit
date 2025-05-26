import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:rutafit/src/models/user_data.dart';
import 'package:rutafit/src/theme/app_theme.dart';
import 'src/controllers/auth_controller.dart';
import 'src/screens/login_screen.dart';
import 'src/screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(UserDataAdapter());
  Get.put(AuthController());
  runApp(const RutaFitApp());
}

class RutaFitApp extends StatelessWidget {
  const RutaFitApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'RutaFit',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      defaultTransition: Transition.fade,
      home: Obx(
        () => AuthController.to.isLogged.value
            ? const HomeScreen()
            : const LoginScreen(),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:centernews/core/configurations/app_binding.dart';
import 'package:centernews/core/configurations/routes.dart';
import 'package:centernews/features/screens/login/auth_controller.dart';
import 'package:centernews/features/screens/login/interface.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final appName = dotenv.env['APP_NAME'] ?? 'CenterNews';
    return GetMaterialApp(
      title: appName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      // Expose current env (helpful for debugging)
      builder: (context, child) {
        final envName = const String.fromEnvironment('FLAVOR',
            defaultValue: 'prod');
        return Banner(
          message: envName.toUpperCase(),
          location: BannerLocation.topStart,
          color: Colors.indigo,
          textStyle:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          child: child!,
        );
      },
      initialRoute: AppRoutes.login,
      initialBinding: BindingsBuilder(() {
        Get.put<IAuthController>(AuthController(), permanent: true);
      }),
      getPages: AppPages.pages,
    );
  }
}

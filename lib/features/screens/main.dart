import 'package:flutter/material.dart';
import 'package:centernews/core/configurations/flavors.dart';
import 'package:centernews/features/pages/myapp.dart';

/// Entry point used by `lib/main.dart`.
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  const appFlavor = String.fromEnvironment('FLAVOR', defaultValue: 'prod');
  switch (appFlavor.toLowerCase()) {
    case 'qat':
      await const QatFlavorConfig().loadConfig();
      break;
    case 'uat':
      await const UatFlavorConfig().loadConfig();
      break;
    case 'prod':
      await const ProdFlavorConfig().loadConfig();
      break;
    default:
      await const ProdFlavorConfig().loadConfig();
  }

  runApp(const MyApp());
}



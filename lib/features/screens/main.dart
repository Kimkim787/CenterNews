import 'package:flutter/material.dart';
import 'package:centernews/core/configurations/flavors.dart';
import 'package:centernews/features/pages/myapp.dart';

/// Entry point used by `lib/main.dart`.
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  const appFlavor = String.fromEnvironment('FLAVOR', defaultValue: 'prod');
  await loadFlavorEnv(flavorName: appFlavor);

  runApp(const MyApp());
}


import 'package:flutter_dotenv/flutter_dotenv.dart';

class QatFlavorConfig {
  const QatFlavorConfig();

  Future<void> loadConfig() async {
    await dotenv.load(fileName: "lib/environments/.env.qat");
  }
}

class UatFlavorConfig {
  const UatFlavorConfig();

  Future<void> loadConfig() async {
    await dotenv.load(fileName: "lib/environments/.env.uat");
  }
}

class ProdFlavorConfig {
  const ProdFlavorConfig();

  Future<void> loadConfig() async {
    await dotenv.load(fileName: "lib/environments/.env.prod");
  }
}

Future<void> loadFlavorEnv({String? flavorName}) async {
  final value = (flavorName ??
          const String.fromEnvironment('FLAVOR', defaultValue: 'prod'))
      .toLowerCase();

  switch (value) {
    case 'qat':
      await const QatFlavorConfig().loadConfig();
      break;
    case 'uat':
      await const UatFlavorConfig().loadConfig();
      break;
    default:
      await const ProdFlavorConfig().loadConfig();
  }
}

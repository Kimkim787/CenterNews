// Forward entry point so `flutter run` still picks up lib/main.dart
import 'package:centernews/features/screens/main.dart' as screens_main;

// Re-export MyApp so tests and imports using package:centernews/main.dart can find it.
export 'package:centernews/features/pages/myapp.dart' show MyApp;

void main() => screens_main.main();



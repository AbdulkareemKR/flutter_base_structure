import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:garage_client/app.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:garage_client/environments/services/environment_services.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

void main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  // Show notification bar when the app loads
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top]);

  await Environment.load();
  await SentryFlutter.init((options) => options.dsn = Environment.instance.apiKeys?.sentryKey,
      appRunner: () => runApp(const ProviderScope(child: App())));
}

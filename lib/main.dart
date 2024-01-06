import 'dart:async';

import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:nutrilog/app/app_module.dart';
import 'package:nutrilog/app/app_widget.dart';
import 'package:nutrilog/app/core/utils/env_vars.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

  PlatformDispatcher.instance.onError = (exception, stackTrace) {
    FirebaseCrashlytics.instance.recordError(exception, stackTrace, fatal: true);
    return true;
  };

  runApp(
    DevicePreview(
      enabled: EnvVars.previewEnabled,
      builder: (_) => ModularApp(
        module: AppModule(),
        child: const AppWidget(),
      ),
    ),
  );
}

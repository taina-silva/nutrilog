// ignore_for_file: avoid-dynamic
import 'dart:developer' as dev;
import 'dart:isolate';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:nutrilog/app/core/utils/env_vars.dart';
import 'package:nutrilog/app/core/services/local_storage/local_storage_service.dart';
import 'package:nutrilog/app/core/utils/storage_keys.dart';
import 'package:permission_handler/permission_handler.dart';

abstract class LoggerService {
  LoggerService() {
    Isolate.current.addErrorListener(isolateErrorListener);
  }

  Future<void> init();
  Future<void> recordError(dynamic exception, StackTrace? stackTrace, {String? extraInfo});
  Future<void> log(String message);

  SendPort get isolateErrorListener {
    return RawReceivePort((pair) async {
      final List<dynamic> errorAndStacktrace = pair;
      final exception = errorAndStacktrace.first;
      final stackTrace = errorAndStacktrace[1];
      recordError(exception, stackTrace);
    }).sendPort;
  }
}

class CrashlyticsLogger extends LoggerService {
  final LocalStorage _localStorage;

  CrashlyticsLogger(this._localStorage) {
    init();
  }

  @override
  Future<void> init() async {
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(EnvVars.crashlyticsEnabled);
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  }

  @override
  Future<void> log(String message) async {
    if (!kReleaseMode) {
      dev.log('Logged message: $message');
    }
    if (FirebaseCrashlytics.instance.isCrashlyticsCollectionEnabled) {
      await FirebaseCrashlytics.instance.log(message);
    }
  }

  @override
  Future<void> recordError(exception, StackTrace? stackTrace, {String? extraInfo}) async {
    if (!kReleaseMode) {
      dev.log('Exception: ${exception.toString()}');
      dev.log('StackTrace: ${stackTrace.toString()}');
    }
    if (exception != null && FirebaseCrashlytics.instance.isCrashlyticsCollectionEnabled) {
      final userId = await _localStorage.read<String>(StorageKeys.token);
      if (userId != null && !kReleaseMode) {
        dev.log('Report from user of device: $userId');
      }
      if (extraInfo != null) {
        await FirebaseCrashlytics.instance.log(extraInfo);
      }
      log('Location permission: ${await (Permission.location).isGranted}');
      await FirebaseCrashlytics.instance.setUserIdentifier(userId ?? '');
      await FirebaseCrashlytics.instance.recordError(exception, stackTrace);
    }
  }
}

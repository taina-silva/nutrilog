import 'package:flutter/services.dart';
import 'package:mobx/mobx.dart';
import 'package:nutrilog/app/core/services/local_storage/local_storage_service.dart';
import 'package:nutrilog/app/core/services/logger/logger_service.dart';
import 'package:nutrilog/app/core/utils/storage_keys.dart';
import 'package:nutrilog/app/modules/splash/presentation/stores/states/splash_states.dart';

part 'splash_store.g.dart';

class SplashStore = SplashStoreBase with _$SplashStore;

abstract class SplashStoreBase with Store {
  final LocalStorage _localStorage;
  final LoggerService _loggerService;

  SplashStoreBase(this._localStorage, this._loggerService);

  @readonly
  SplashState _state = InitialState();

  @action
  Future<void> manageSplash() async {
    _state = LoadingState();
    try {
      final String? isLogged = await _localStorage.read<String>(StorageKeys.isLogged);
      final String? userId = await _localStorage.read<String>(StorageKeys.userId);

      await Future.delayed(const Duration(seconds: 3));
      _state = isLogged == 'true' && userId != null ? ToEntryState() : ToLoginState();
    } on PlatformException catch (exception, stackTrace) {
      _state = ToLoginState();
      _localStorage.clearAll();
      _loggerService.recordError(exception, stackTrace);
    } catch (exception, stackTrace) {
      _state = ToLoginState();
      _localStorage.clearAll();
      _loggerService.recordError(exception, stackTrace);
    }
  }
}

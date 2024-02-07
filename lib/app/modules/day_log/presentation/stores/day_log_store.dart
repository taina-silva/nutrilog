import 'package:mobx/mobx.dart';

part 'day_log_store.g.dart';

class DayLogStore = DayLogStoreBase with _$DayLogStore;

abstract class DayLogStoreBase with Store {}

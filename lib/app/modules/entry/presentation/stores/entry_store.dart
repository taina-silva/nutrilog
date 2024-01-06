import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'entry_store.g.dart';

class EntryStore = EntryStoreBase with _$EntryStore;

abstract class EntryStoreBase with Store {
  @observable
  int _currentPage = 0;

  @action
  Future<void> changePage(int index) async {
    _currentPage = index;
    if (index == 0) {
      Modular.to.navigate('/entry/home/');
    } else if (index == 1) {
      Modular.to.navigate('/entry/graphics/');
    }
  }

  @computed
  int get currentPage => _currentPage;
}

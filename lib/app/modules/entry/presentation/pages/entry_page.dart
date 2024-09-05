import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:nutrilog/app/core/components/bottom_nav_bar/main_bottom_nav_bar.dart';
import 'package:nutrilog/app/core/utils/custom_colors.dart';
import 'package:nutrilog/app/modules/entry/presentation/stores/entry_store.dart';

class EntryPage extends StatefulWidget {
  const EntryPage({Key? key}) : super(key: key);

  @override
  EntryPageState createState() => EntryPageState();
}

class EntryPageState extends State<EntryPage> {
  final entryStore = Modular.get<EntryStore>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CColors.primaryBackground,
      body: const RouterOutlet(),
      bottomNavigationBar: Observer(
        builder: (_) {
          return MainBottomNavBar(
            currentIndex: entryStore.currentPage,
            onTap: entryStore.changePage,
          );
        },
      ),
    );
  }
}

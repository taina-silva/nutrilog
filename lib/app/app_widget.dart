import 'dart:async';

import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:nutrilog/app/core/services/logger/logger_service.dart';
import 'package:nutrilog/app/core/utils/custom_colors.dart';
import 'package:nutrilog/app/core/utils/log.dart';
import 'package:nutrilog/app/core/utils/status_bar_theme.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);

    Modular.get<LoggerService>().init();

    Modular.to.addListener(navigationListener);
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  Future<void> dispose() async {
    Modular.to.removeListener(navigationListener);
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void navigationListener() {
    logInfo('[NAV]: ${Modular.to.path}');

    List<String> path = Modular.to.path.split('/');

    if (path.contains('access')) {
      changeStatusBarTheme(StatusBarTheme.light,
          path.contains('signup') ? CColors.primaryNutrition : CColors.primaryActivity);
    } else {
      changeStatusBarTheme(StatusBarTheme.light, CColors.primaryBackground);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      excludeFromSemantics: true,
      onTap: () {
        final FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus!.unfocus();
        }
      },
      child: MaterialApp.router(
        title: 'Nutrilog',
        debugShowCheckedModeBanner: false,
        scrollBehavior: const CustomScrollBehavior(),
        theme: ThemeData(
          useMaterial3: false,
          primarySwatch: getMaterialColor(CColors.primaryActivity),
          fontFamily: 'K2D',
        ),
        // ignore: deprecated_member_use
        useInheritedMediaQuery: true,
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [Locale('pt', 'BR')],
        builder: DevicePreview.appBuilder,
        routeInformationParser: Modular.routeInformationParser,
        routerDelegate: Modular.routerDelegate,
      ),
    );
  }
}

class CustomScrollBehavior extends ScrollBehavior {
  const CustomScrollBehavior();
  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    return const BouncingScrollPhysics();
  }
}

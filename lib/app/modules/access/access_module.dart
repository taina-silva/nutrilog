import 'package:flutter_modular/flutter_modular.dart';
import 'package:nutrilog/app/modules/access/presentation/pages/signin_page.dart';
import 'package:nutrilog/app/modules/access/presentation/pages/signup_page.dart';

class AccessModule extends Module {
  @override
  List<Bind> binds = [];

  @override
  List<ModularRoute> routes = [
    ChildRoute(
      '/',
      child: (_, __) => const SigninPage(),
      transition: TransitionType.fadeIn,
    ),
    ChildRoute(
      '/signup',
      child: (_, __) => const SignupPage(),
      transition: TransitionType.fadeIn,
    ),
  ];
}

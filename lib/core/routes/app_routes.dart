import 'package:flutter/material.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/register.dart';
import '../../features/detail/presentation/pages/detail_page.dart';
import '../../features/home/presentation/pages/home_page.dart';
 
class AppRoutes {
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';
  static const String detail = '/detail';
 
  static const String initial = login;
 
  static Map<String, WidgetBuilder> get routes => {
        login: (_) => const LoginPage(),
        register: (_) => const RegisterPage(),
        home: (_) => const HomePage(),
      };
 
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case detail:
        final String mealId = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => DetailPage(mealId: mealId),
        );
 
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('Halaman tidak ditemukan')),
          ),
        );
    }
  }

  
}
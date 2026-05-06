import 'package:flutter/material.dart';
import 'core/constants/app_colors.dart';
import 'core/routes/app_routes.dart';
import 'core/utils/hive_helper.dart';
import 'features/auth/data/auth_local_datasource.dart';
import 'features/auth/presentation/pages/login_page.dart';
import 'features/auth/presentation/pages/register.dart';
import 'features/detail/presentation/pages/detail_page.dart';
import 'features/home/presentation/pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isLoggedIn = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _checkSession();
  }

  Future<void> _checkSession() async {
    final loggedIn = await AuthLocalDatasource().isLoggedIn();
    setState(() {
      _isLoggedIn = loggedIn;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ResepKu',
      debugShowCheckedModeBanner: false,
      theme: AppColors.theme,
      home: _isLoading
          ? const Scaffold(body: Center(child: CircularProgressIndicator()))
          : _isLoggedIn
          ? const HomePage()
          : const LoginPage(),
      routes: {
        AppRoutes.login: (_) => const LoginPage(),
        AppRoutes.register: (_) => const RegisterPage(),
        AppRoutes.home: (_) => const HomePage(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == AppRoutes.detail) {
          final mealId = settings.arguments as String;
          return MaterialPageRoute(builder: (_) => DetailPage(mealId: mealId));
        }
        return null;
      },
    );
  }
}

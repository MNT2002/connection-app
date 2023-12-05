import 'package:connection/models/profile.dart';
import 'package:connection/providers/forgotPassViewModel.dart';
import 'package:connection/providers/loginViewModel.dart';
import 'package:connection/providers/mainViewModel.dart';
import 'package:connection/providers/menuBarViewModel.dart';
import 'package:connection/providers/resgisterViewModel.dart';
import 'package:connection/services/api_services.dart';
import 'package:connection/ui/AppConstant.dart';
import 'package:connection/ui/page_forgot_pass.dart';
import 'package:connection/ui/page_login.dart';
import 'package:connection/ui/page_main.dart';
import 'package:connection/ui/page_register.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  ApiService api = ApiService();
  api.initialize();

  Profile profile = Profile();
  profile.initialize;

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<LoginViewModel>(
        create: (context) => LoginViewModel()),
    ChangeNotifierProvider<ResgisterViewModel>(
        create: (context) => ResgisterViewModel()),
    ChangeNotifierProvider<ForgotPassViewModel>(
        create: (context) => ForgotPassViewModel()),
    ChangeNotifierProvider<MainViewModel>(
        create: (context) => MainViewModel()),
    ChangeNotifierProvider<MenuBarViewModel>(
        create: (context) => MenuBarViewModel()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/home': (context) => PageMain(),
        '/login': (context) => PageLogin(),
        '/register': (context) => PageRegister(),
        '/forgot': (context) => PageForgotPass(),
      },
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: TextTheme(bodyMedium: TextStyle(fontSize: 16)),
        colorScheme: ColorScheme.fromSeed(seedColor: AppConstant.thirdColor),
        useMaterial3: true,
      ), 
      home: PageMain(),
    );
  }
}



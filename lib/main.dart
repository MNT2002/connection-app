import 'package:connection/models/profile.dart';
import 'package:connection/providers/loginViewModel.dart';
import 'package:connection/ui/page_login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  Profile profile = Profile();
  profile.initialize;

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<LoginViewModel>(
        create: (context) => LoginViewModel())
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: PageLogin(),
    );
  }
}



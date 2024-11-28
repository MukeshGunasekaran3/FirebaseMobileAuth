import 'package:batechtask/Features/Authentication/Screens/LoginScreen.dart';
import 'package:batechtask/Features/Authentication/provider/Authprovider.dart';
import 'package:batechtask/Features/adresslist.dart/provider/addressProivder.dart';
import 'package:batechtask/Features/adresslist.dart/screen/dashboard.dart';
import 'package:batechtask/core/services/api.dart';
import 'package:batechtask/core/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => AuthProivder(),
      ),
      ChangeNotifierProvider(
        create: (context) => Addressproivder(api: ApiService()),
      )
    ],
    child: Myapp(),
  ));
}

class Myapp extends StatelessWidget {
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.Darkmode(context),
      home: LoginScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

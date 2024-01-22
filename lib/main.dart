import 'package:flutter/material.dart';

import 'package:iplik/pages/main/main_page.dart';
import 'package:iplik/firebase_options.dart';
import 'package:iplik/globals.dart' as globals;
import 'package:iplik/pages/start/start_page.dart';

import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  if (globals.currentAccount != null) {
    globals.currentAccount = FirebaseAuth.instance.currentUser!;
    runApp(const IplikApp(home: MainPage()));
  } else {
    runApp(IplikApp(home: StartPage()));
  }
}

class IplikApp extends StatelessWidget {
  final Widget home;

  const IplikApp({super.key, required this.home});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "iplik",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: const ColorScheme.dark(),
        useMaterial3: true,
        fontFamily: "Gabarito",
        textTheme: Theme.of(context).textTheme.apply(
          bodyColor: Colors.white,
          displayColor: Colors.white,
        )
      ),
      home: home,
    );
  }
}
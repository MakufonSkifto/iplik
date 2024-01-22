import 'package:flutter/material.dart';

import 'package:iplik/pages/start/registering_page.dart';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:iplik/util/authentication.dart';
import 'package:iplik/widgets/custom_button.dart';

class StartPage extends StatelessWidget {
  final Authentication auth = Authentication();

  StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Image.asset("assets/icon.png", scale: 3),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5, right: 5),
                      child: AnimatedTextKit(
                        animatedTexts: [
                          TypewriterAnimatedText(
                            "iplik'in karmaşık dünyasına hoş geldin",
                            textStyle: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                            speed: const Duration(milliseconds: 50),
                          ),
                        ],
                        repeatForever: true,
                        pause: const Duration(milliseconds: 3000),
                      ),
                    ),
                  ],
                ),
              ),
              CustomButton(
                icon: const Icon(Icons.apple, color: Colors.white, size: 26),
                text: "Apple ile Giriş Yap",
                color: Colors.black,
                onTap: () {
                  auth.signInWithApple().then((value) {
                    Get.to(() => const RegisteringPage());
                  });
                }
              ),
              const SizedBox(height: 15),
              CustomButton(
                icon: const Icon(FontAwesomeIcons.google, color: Colors.white, size: 22),
                text: "Google ile Giriş Yap",
                color: Colors.red.withOpacity(.9),
                onTap: () {
                  auth.signInWithGoogle().then((value) {
                    Get.to(() => const RegisteringPage());
                  });
                }
              ),
              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}
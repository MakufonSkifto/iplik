import 'package:flutter/material.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Colors.black.withOpacity(.2),
        leading: Image.asset("assets/iconBgRemoved.png", scale: 8),
        title: const Text("ara", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23)),
      ),
    );
  }
}
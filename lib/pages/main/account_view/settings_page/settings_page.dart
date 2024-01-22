import 'package:flutter/material.dart';
import 'package:iplik/widgets/custom_button.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Colors.black.withOpacity(.2),
        title: const Text("ayarlar", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            CustomButton(
              color: Colors.white,
              text: "hesabın",
              onTap: () {},
              textColor: Colors.black,
            ),
            const SizedBox(height: 10),
            CustomButton(
              color: Colors.white,
              text: "gizlilik & kullanıcı sözleşmeleri",
              onTap: () {},
              textColor: Colors.black,
            ),
            const SizedBox(height: 10),
            CustomButton(
              color: Colors.white,
              text: "hakkımızda",
              onTap: () {},
              textColor: Colors.black,
            )
          ],
        ),
      ),
    );
  }
}
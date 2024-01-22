import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:iplik/pages/main/title_view/title_view.dart';
import 'package:iplik/util/models/lif.dart';

class LifCard extends StatelessWidget {
  final Lif lif;
  final bool withTitle;

  const LifCard({super.key, required this.lif, required this.withTitle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Visibility(
            visible: withTitle,
            child: GestureDetector(
              onTap: () {
                HapticFeedback.selectionClick();
                Get.to(() => TitleView(titleId: lif.titleId, titleName: lif.title));
              },
              child: Text(
                lif.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  decoration: TextDecoration.underline,
                  decorationColor: Colors.white
                ),
              ),
            ),
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              const Icon(Icons.account_circle, size: 35),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    lif.authorUsername,
                    style: const TextStyle(fontSize: 17)
                  ),
                  Text(DateFormat("dd/MM/yyyy HH:mm").format(lif.datePosted)),
                ],
              )
            ],
          ),
          const SizedBox(height: 10),
          Text(
            lif.content,
            style: const TextStyle(fontSize: 15)
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              GestureDetector(
                child: Image.asset("assets/leaf.png", scale: 30, color: Colors.white),
              ),
              const SizedBox(width: 5),
              Text(lif.yaprakCount.toString(), style: const TextStyle(fontSize: 16))
            ],
          )
        ],
      ),
    );
  }
}
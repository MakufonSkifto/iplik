import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:iplik/globals.dart' as globals;
import 'package:iplik/pages/main/account_view/settings_page/settings_page.dart';
import 'package:iplik/util/models/lif.dart';
import 'package:iplik/util/utilities.dart';
import 'package:iplik/widgets/lif_card.dart';

import 'package:intl/intl.dart';

class AccountView extends StatefulWidget {
  const AccountView({super.key});

  @override
  State<AccountView> createState() => _AccountViewState();
}

class _AccountViewState extends State<AccountView> {
  late Future<List<Lif>> future;

  @override
  void initState() {
    future = Utilites.getUserLifs(globals.currentAccount!.uid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Colors.black.withOpacity(.2),
        leading: Image.asset("assets/iconBgRemoved.png", scale: 8),
        title: const Text("hesabın", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23)),
        actions: [
          IconButton(
            onPressed: () {
              HapticFeedback.selectionClick();
              Get.to(() => const SettingsPage());
            },
            icon: const Icon(Icons.settings)
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SafeArea(
          child: Column(
            children: [
              Row(
                children: [
                  buildPfp(),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        globals.currentAccount!.displayName!,
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)
                      ),
                      Text("${DateFormat("dd/MM/yyyy").format(globals.currentAccount!.metadata.creationTime!)} tarihinde katıldın")
                    ],
                  ),
                ],
              ),
              const Divider(thickness: .5, height: 30),
              FutureBuilder(
                future: future,
                builder: (BuildContext context, AsyncSnapshot<List<Lif>> snapshot) {
                  if (snapshot.connectionState != ConnectionState.done) {
                    return const Center(child: CupertinoActivityIndicator());
                  }

                  List<Lif> lifs = snapshot.data!;

                  if (lifs.isEmpty) {
                    return const Center(child: Text("gösterecek bir şey yok!"));
                  }

                  return ListView.separated(
                    shrinkWrap: true,
                    itemCount: lifs.length,
                    itemBuilder: (BuildContext context, int index) {
                      return LifCard(lif: lifs[index], withTitle: true);
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const Divider();
                    },
                  );
                }
              )
            ],
          ),
        ),
      )
    );
  }

  Widget buildPfp() {
    if (globals.currentAccount!.photoURL != null) {
      return const Icon(Icons.account_circle, size: 40); // TODO
    } else {
      return const Icon(Icons.account_circle, size: 40);
    }
  }
}
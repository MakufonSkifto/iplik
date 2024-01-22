import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:iplik/util/models/lif.dart';
import 'package:iplik/util/utilities.dart';
import 'package:iplik/widgets/lif_card.dart';

class LifView extends StatefulWidget {
  const LifView({super.key});

  @override
  State<LifView> createState() => _LifViewState();
}

class _LifViewState extends State<LifView> {
  late Future<List<Lif>> future;

  @override
  void initState() {
    future = Utilites.getNewestLifs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Colors.black.withOpacity(.2),
        leading: Image.asset("assets/iconBgRemoved.png", scale: 8),
        title: const Text("lif'ler", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23)),
        actions: [
          IconButton(
            onPressed: () {
              HapticFeedback.selectionClick();
            },
            icon: const Icon(CupertinoIcons.pen, size: 30)
          )
        ],
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: future,
          builder: (context, AsyncSnapshot<List<Lif>> snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const Center(child: CupertinoActivityIndicator());
            }

            List<Lif> lifs = snapshot.data!;

            return ListView.separated(
              itemCount: lifs.length,
              itemBuilder: (BuildContext context, int index) {
                return LifCard(lif: lifs[index], withTitle: true);
              },
              separatorBuilder: (BuildContext context, int index) {
                return const Divider();
              },
            );
          }
        ),
      )
    );
  }
}
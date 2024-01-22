import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:iplik/util/models/lif.dart';
import 'package:iplik/util/utilities.dart';
import 'package:iplik/widgets/lif_card.dart';

class TitleView extends StatefulWidget {
  final String titleName;
  final String titleId;

  const TitleView({super.key, required this.titleId, required this.titleName});

  @override
  State<TitleView> createState() => _TitleViewState();
}

class _TitleViewState extends State<TitleView> {
  late Future<List<Lif>> future;

  @override
  void initState() {
    future = Utilites.getTitleLifs(widget.titleId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Colors.black.withOpacity(.2),
        title: Text(widget.titleName),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.add_box_rounded, size: 30)
          )
        ],
      ),
      body: FutureBuilder(
        future: future,
        builder: (BuildContext context, AsyncSnapshot<List<Lif>> snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CupertinoActivityIndicator());
          }

          List<Lif> lifs = snapshot.data!;

          return ListView.separated(
            itemCount: lifs.length,
            itemBuilder: (BuildContext context, int index) {
              return LifCard(lif: lifs[index], withTitle: false);
            },
            separatorBuilder: (BuildContext context, int index) {
              return const Divider();
            },
          );
        },
      ),
    );
  }
}
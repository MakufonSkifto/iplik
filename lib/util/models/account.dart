import 'package:iplik/util/models/lif.dart';

class Account {
  final String id;
  final String username;
  final String? profilePicture;
  final DateTime dateJoined;
  final DateTime birthDate;
  final List<Lif> lifs;

  Account({
    required this.id,
    required this.username,
    this.profilePicture,
    required this.dateJoined,
    required this.birthDate,
    required this.lifs
  });

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> lifsList = [];

    for (Lif lif in lifs) {
      lifsList.add(lif.toJson());
    }

    return {
      "id": id,
      "username": username,
      "profilePicture": profilePicture,
      "dateJoined": dateJoined.millisecondsSinceEpoch,
      "birthDate": birthDate.millisecondsSinceEpoch,
      "lifs": lifs
    };
  }

  factory Account.fromJson(Map<String, dynamic> data) {
    List<Lif> lifsList = [];

    for (Map<String, dynamic> lif in data["lifs"]) {
      lifsList.add(Lif.fromJson(lif));
    }

    return Account(
      id: data["id"],
      username: data["username"],
      lifs: lifsList,
      profilePicture: data["profilePicture"],
      dateJoined: DateTime.fromMillisecondsSinceEpoch(data["dateJoined"]),
      birthDate: DateTime.fromMillisecondsSinceEpoch(data["birthDate"])
    );
  }
}
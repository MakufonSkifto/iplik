class Lif {
  final String id;
  final String title;
  final String titleId;
  final String authorId;
  final String authorUsername;
  final String content;
  final int yaprakCount; // likes
  final DateTime datePosted;

  Lif({
    required this.id,
    required this.title,
    required this.titleId,
    required this.authorId,
    required this.authorUsername,
    required this.content,
    required this.yaprakCount,
    required this.datePosted
  });

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "titleId": titleId,
      "authorId": authorId,
      "authorUsername": authorUsername,
      "content": content,
      "yaprakCount": yaprakCount,
      "datePosted": datePosted.millisecondsSinceEpoch
    };
  }

  factory Lif.fromJson(Map<String, dynamic> data) {
    return Lif(
      id: data["id"],
      title: data["title"],
      titleId: data["titleId"],
      authorId: data["authorId"],
      authorUsername: data["authorUsername"],
      content: data["content"],
      yaprakCount: data["yaprakCount"],
      datePosted: DateTime.fromMillisecondsSinceEpoch(data["datePosted"])
    );
  }
}
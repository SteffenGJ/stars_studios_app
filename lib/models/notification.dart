class Notification {
  final String id;
  final String title;
  final DateTime createdAt;
  final String text;
  final String? imageUrl;
  final List<String>? links;

  Notification({
    required this.id,
    required this.title,
    required this.createdAt,
    required this.text,
    this.imageUrl,
    this.links,
  });

  //TODO: Formatér createdAt, så den kan se flot ud. Lav evt en method til formålet.

  factory Notification.fromJson(Map<String, dynamic> json) {
    return Notification(
      id: json["id"],
      title: json["title"],
      createdAt: json["createdAt"].toDate(),
      text: json["text"],
      imageUrl: json["imageUrl"],
      links: json["links"]?.cast<String>(),
    );
  }
}

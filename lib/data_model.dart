class Data {
  String title;
  String content;
  String photo_url;

  Data({this.title, this.content, this.photo_url});

  factory Data.fromJson(dynamic json) {
    return Data(
        title: "${json['title']}",
        content: "${json['name']}",
        photo_url: "${json['photo_url']}");
  }
}

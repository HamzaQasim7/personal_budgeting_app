class DataModel {
  final String title;
  final String content;

  DataModel({required this.title, required this.content});

  factory DataModel.fromJson(Map<String, dynamic> json) {
    return DataModel(
      title: json['title'],
      content: json['body'],
    );
  }
}

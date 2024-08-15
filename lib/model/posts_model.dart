import 'dart:convert';

// Define the model class
class Post {
  final int userId;
  final int id;
  final String title;
  final String body;

  Post({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  // Factory method to create a Post object from JSON
  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      userId: json['userId'] as int,
      id: json['id'] as int,
      title: json['title'] as String,
      body: json['body'] as String,
    );
  }

  // Method to convert a Post object to JSON
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'id': id,
      'title': title,
      'body': body,
    };
  }
}

// Function to parse JSON string to a list of Post objects
List<Post> parsePosts(String jsonString) {
  final List<dynamic> jsonList = json.decode(jsonString) as List<dynamic>;
  return jsonList
      .map((json) => Post.fromJson(json as Map<String, dynamic>))
      .toList();
}

// Function to convert a list of Post objects to JSON string
String postsToJson(List<Post> posts) {
  final List<Map<String, dynamic>> jsonList =
      posts.map((post) => post.toJson()).toList();
  return json.encode(jsonList);
}

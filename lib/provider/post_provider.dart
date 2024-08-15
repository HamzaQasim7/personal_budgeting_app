// post_provider.dart
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../model/posts_model.dart';

class PostProvider with ChangeNotifier {
  final List<Post> _posts = [];
  int _page = 1;
  final int _limit = 10;
  bool _hasMore = true;

  List<Post> get posts => _posts;

  bool get hasMore => _hasMore;

  Future<List<Post>> fetchPosts() async {
    if (!_hasMore) return _posts;

    final url =
        'https://jsonplaceholder.typicode.com/posts?_page=$_page&_limit=$_limit';
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        List<Post> fetchedPosts = parsePosts(response.body);

        if (fetchedPosts.length < _limit) {
          _hasMore = false;
        }

        _posts.addAll(fetchedPosts);
        _page++;
        notifyListeners();
        return _posts;
      } else {
        throw Exception('Failed to load posts');
      }
    } catch (e) {
      print('Error fetching posts: $e');
      rethrow;
    }
  }
}

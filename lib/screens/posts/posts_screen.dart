// main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/posts_model.dart';
import '../../provider/post_provider.dart';

class PostListScreen extends StatefulWidget {
  const PostListScreen({super.key});

  @override
  _PostListScreenState createState() => _PostListScreenState();
}

class _PostListScreenState extends State<PostListScreen> {
  late Future<List<Post>> _futurePosts;

  @override
  void initState() {
    super.initState();
    _futurePosts = context.read<PostProvider>().fetchPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Posts')),
      body: Consumer<PostProvider>(
        builder: (context, postProvider, child) {
          return FutureBuilder<List<Post>>(
            future: _futurePosts,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return const Center(child: Text('Got some error'));
              } else if (snapshot.hasData) {
                final posts = snapshot.data!;
                return ListView.builder(
                  itemCount: posts.length + (postProvider.hasMore ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == posts.length && postProvider.hasMore) {
                      _futurePosts = postProvider.fetchPosts();
                      return const Center(child: CircularProgressIndicator());
                    }
                    final post = posts[index];
                    return Card(
                      child: ListTile(
                        title: Text(
                          post.title,
                          style: const TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 20),
                        ),
                        subtitle: Text(post.body),
                      ),
                    );
                  },
                );
              } else {
                return const Center(child: Text('No posts available'));
              }
            },
          );
        },
      ),
    );
  }
}

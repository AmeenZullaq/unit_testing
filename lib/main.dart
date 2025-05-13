import 'package:flutter/material.dart';
import 'package:unit_testing/presentation/posts_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const PostsPage(),
                ),
              );
            },
            child: const Text('open posts page'),
          ),
        ),
      ),
    );
  }
}

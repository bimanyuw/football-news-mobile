import 'package:flutter/material.dart';
import 'package:football_news/widgets/left_drawer.dart';

class NewsListPage extends StatelessWidget {
  const NewsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Football News List')),
      drawer: const LeftDrawer(),
      body: const Center(
        child: Text('Daftar berita akan muncul di sini.'),
      ),
    );
  }
}

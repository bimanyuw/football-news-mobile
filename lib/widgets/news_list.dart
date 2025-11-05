import 'package:flutter/material.dart';
import 'package:football_news/widgets/left_drawer.dart';
import 'package:football_news/widgets/news_card.dart';

class NewsListPage extends StatelessWidget {
  const NewsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> dummyNews = [
      {
        "title": "Messi Cetak Gol Spektakuler di Laga Terakhir",
        "category": "update",
        "thumbnailUrl": "https://picsum.photos/200",
        "isFeatured": true,
      },
      {
        "title": "Transfer Musim Dingin: Pemain Muda Naik Daun",
        "category": "transfer",
        "thumbnailUrl": "",
        "isFeatured": false,
      },
      {
        "title": "Analisis Taktik Barcelona vs Real Madrid",
        "category": "analysis",
        "thumbnailUrl": "https://picsum.photos/201",
        "isFeatured": false,
      },
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Football News List')),
      drawer: const LeftDrawer(),
      body: ListView.builder(
        itemCount: dummyNews.length,
        itemBuilder: (context, index) {
          final news = dummyNews[index];
          return NewsCard(
            title: news["title"],
            category: news["category"],
            thumbnailUrl: news["thumbnailUrl"],
            isFeatured: news["isFeatured"],
          );
        },
      ),
    );
  }
}

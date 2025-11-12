import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';

import 'package:football_news/models/news_entry.dart';
import 'package:football_news/widgets/left_drawer.dart';
import 'package:football_news/screens/news_detail.dart';
import 'package:football_news/widgets/news_entry_card.dart';

class NewsEntryListPage extends StatefulWidget {
  const NewsEntryListPage({super.key});

  @override
  State<NewsEntryListPage> createState() => _NewsEntryListPageState();
}

class _NewsEntryListPageState extends State<NewsEntryListPage> {
  Future<List<NewsEntry>> fetchNews(CookieRequest request) async {
    // Pilih base URL sesuai target
    final baseUrl = kIsWeb ? "http://localhost:8000" : "http://10.0.2.2:8000";

    // Pastikan endpoint JSON kamu benar dan pakai trailing slash
    // Contoh: /json/ atau /news/json/
    final url = "$baseUrl/json/";

    // CookieRequest.get sudah mengembalikan hasil decode JSON (dynamic)
    final data = await request.get(url);

    // data seharusnya List<dynamic> (array of object)
    final List<NewsEntry> listNews = [];
    if (data is List) {
      for (final d in data) {
        if (d != null) {
          listNews.add(NewsEntry.fromJson(d as Map<String, dynamic>));
        }
      }
    }
    return listNews;
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('News Entry List'),
      ),
      drawer: const LeftDrawer(),
      body: FutureBuilder<List<NewsEntry>>(
        future: fetchNews(request),
        builder: (context, snapshot) {
          // Loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // Error
          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  'Failed to load news: ${snapshot.error}',
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }

          final items = snapshot.data ?? const <NewsEntry>[];
          if (items.isEmpty) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'There are no news in football news yet.',
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }

          // Tampilkan list
          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (_, index) {
              final news = items[index];
              return NewsEntryCard(
                news: news,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => NewsDetailPage(news: news),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

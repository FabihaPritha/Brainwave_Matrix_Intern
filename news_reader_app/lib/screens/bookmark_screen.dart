import 'package:flutter/material.dart';
import '../services/bookmark_service.dart';
import '../models/news_model.dart';
import '../widgets/news_card.dart';

class BookmarkScreen extends StatefulWidget {
  const BookmarkScreen({super.key});

  @override
  State<BookmarkScreen> createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen> {
  late Future<List<NewsArticle>> bookmarkedNews;

  @override
  void initState() {
    super.initState();
    bookmarkedNews = loadBookmarkedNews();
  }

  Future<List<NewsArticle>> loadBookmarkedNews() async {
    final bookmarks = await BookmarkService.getBookmarks();
    // Create a temporary list of articles from the URLs saved in bookmarks
    // You could fetch articles again if you want the latest details
    return bookmarks.map((url) => NewsArticle(title: url, description: 'Bookmarked article', urlToImage: '', url: url)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Bookmarked News")),
      body: FutureBuilder<List<NewsArticle>>(
        future: bookmarkedNews,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.isEmpty) {
              return const Center(child: Text("No bookmarks yet"));
            }
            return ListView(
              children: snapshot.data!.map((e) => NewsCard(article: e)).toList(),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
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

  // ✅ Updated: Load actual saved article details, not just URL placeholders
  Future<List<NewsArticle>> loadBookmarkedNews() async {
    return await BookmarkService.getBookmarks();  // Updated line
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[900],
        centerTitle: true,
        title: const Text(
          "Bookmarked News",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: FutureBuilder<List<NewsArticle>>(
        future: bookmarkedNews,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.isEmpty) {
              return const Center(child: Text("No bookmarks yet"));
            }
            return ListView(
              children: snapshot.data!
                  .map((article) => NewsCard(article: article))
                  .toList(),
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

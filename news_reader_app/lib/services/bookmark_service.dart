import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/news_model.dart';

class BookmarkService {
  static const _bookmarkKey = 'bookmarked_articles';

  // ✅ Add a bookmark (entire article)
  static Future<void> addBookmark(NewsArticle article) async {
    final prefs = await SharedPreferences.getInstance();
    final bookmarks = prefs.getStringList(_bookmarkKey) ?? [];

    // Prevent duplicates by checking URL
    if (!bookmarks.any((item) {
      final map = jsonDecode(item);
      return map['url'] == article.url;
    })) {
      bookmarks.add(jsonEncode(article.toJson()));
      await prefs.setStringList(_bookmarkKey, bookmarks);
    }
  }

  // ✅ Remove a bookmark by URL
  static Future<void> removeBookmark(String url) async {
    final prefs = await SharedPreferences.getInstance();
    final bookmarks = prefs.getStringList(_bookmarkKey) ?? [];
    bookmarks.removeWhere((item) {
      final map = jsonDecode(item);
      return map['url'] == url;
    });
    await prefs.setStringList(_bookmarkKey, bookmarks);
  }

  // ✅ Get list of saved NewsArticle objects
  static Future<List<NewsArticle>> getBookmarks() async {
    final prefs = await SharedPreferences.getInstance();
    final bookmarks = prefs.getStringList(_bookmarkKey) ?? [];
    return bookmarks
        .map((item) => NewsArticle.fromJson(jsonDecode(item)))
        .toList();
  }

  // ✅ Check if an article is bookmarked
  static Future<bool> isBookmarked(String url) async {
    final prefs = await SharedPreferences.getInstance();
    final bookmarks = prefs.getStringList(_bookmarkKey) ?? [];
    return bookmarks.any((item) {
      final map = jsonDecode(item);
      return map['url'] == url;
    });
  }
}

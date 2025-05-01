import 'package:shared_preferences/shared_preferences.dart';

class BookmarkService {
  static const String key = 'bookmarked_news';

  static Future<List<String>> getBookmarks() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(key) ?? [];
  }

  static Future<void> addBookmark(String url) async {
    final prefs = await SharedPreferences.getInstance();
    final bookmarks = await getBookmarks();
    if (!bookmarks.contains(url)) {
      bookmarks.add(url);
      await prefs.setStringList(key, bookmarks);
    }
  }

  static Future<void> removeBookmark(String url) async {
    final prefs = await SharedPreferences.getInstance();
    final bookmarks = await getBookmarks();
    bookmarks.remove(url);
    await prefs.setStringList(key, bookmarks);
  }

  static Future<bool> isBookmarked(String url) async {
    final bookmarks = await getBookmarks();
    return bookmarks.contains(url);
  }
}

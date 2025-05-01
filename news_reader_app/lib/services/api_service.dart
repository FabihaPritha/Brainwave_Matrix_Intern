import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/news_model.dart';
import 'dart:developer' as developer;

class ApiService {
  final String apiKey = '9d9c3ba1f4b94f32ad1cd8279add9f55';
  final String baseUrl = 'https://newsapi.org/v2/top-headlines?country=us';

  Future<List<NewsArticle>> fetchNews({String category = 'general'}) async {
    final url = '$baseUrl&category=$category&apiKey=$apiKey';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List articles = data['articles'];
        return articles.map((json) => NewsArticle.fromJson(json)).toList();
      } else {
        developer.log('API Error: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      developer.log('Network error: $e');
      return [];
    }
  }

  Future<List<NewsArticle>> searchNews(String query) async {
    final url = 'https://newsapi.org/v2/everything?q=$query&apiKey=$apiKey';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List articles = data['articles'];
        return articles.map((json) => NewsArticle.fromJson(json)).toList();
      } else {
        developer.log('Search Error: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      developer.log('Search network error: $e');
      return [];
    }
  }
}

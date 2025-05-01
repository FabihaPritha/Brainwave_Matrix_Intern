import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/news_model.dart';
import '../widgets/news_card.dart';
import 'bookmark_screen.dart'; // Don't forget to import this

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<NewsArticle>> newsList;
  String selectedCategory = 'general';
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    newsList = ApiService().fetchNews(category: selectedCategory);
  }

  void getNews(String category) {
    setState(() {
      selectedCategory = category;
      newsList = ApiService().fetchNews(category: category);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[900],
        centerTitle: true,
        title: const Text(
          "Flash Feed",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.bookmark),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const BookmarkScreen()),
              );
            },
            color: Colors.white,
          ),
        ],
      ),
      body: FutureBuilder<List<NewsArticle>>(
        future: newsList,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      hintText: "Search news...",
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.search),
                        onPressed: () {
                          String keyword = searchController.text.trim();
                          if (keyword.isNotEmpty) {
                            setState(() {
                              newsList = ApiService().searchNews(keyword);
                            });
                          }
                        },
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    children: [
                      for (var cat in [
                        'general',
                        'business',
                        'sports',
                        'health',
                        'technology',
                        'science',
                        'entertainment'
                      ])
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: selectedCategory == cat
                                  ? Colors.red[50]
                                  : Colors.white,
                            ),
                            onPressed: () => getNews(cat),
                            child: Text(
                              cat[0].toUpperCase() + cat.substring(1),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView(
                    children: snapshot.data!
                        .map((e) => NewsCard(article: e))
                        .toList(),
                  ),
                ),
              ],
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
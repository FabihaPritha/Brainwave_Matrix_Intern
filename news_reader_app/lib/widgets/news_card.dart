import 'package:flutter/material.dart';
import '../models/news_model.dart';
import '../services/bookmark_service.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsCard extends StatefulWidget {
  final NewsArticle article;

  const NewsCard({super.key, required this.article});

  @override
  State<NewsCard> createState() => _NewsCardState();
}

class _NewsCardState extends State<NewsCard> {
  bool isSaved = false;

  @override
  void initState() {
    super.initState();
    checkBookmark();
  }

  void checkBookmark() async {
    bool saved = await BookmarkService.isBookmarked(widget.article.url);
    if (mounted) {
      setState(() => isSaved = saved);
    }
  }

  void toggleBookmark() async {
    if (isSaved) {
      await BookmarkService.removeBookmark(widget.article.url);
    } else {
      await BookmarkService.addBookmark(widget.article);
    }
    checkBookmark();
  }

  void _launchURL(String? url) async {
    if (url == null || url.isEmpty) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Article URL is missing.")),
        );
      }
      return;
    }

    final uri = Uri.tryParse(url);
    print('Launching URL: $url'); // Debug console print

    if (uri != null && await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Could not launch the article.")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _launchURL(widget.article.url),
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.article.urlToImage.isNotEmpty)
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                child: Image.network(
                  widget.article.urlToImage,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const SizedBox(
                      height: 200,
                      child: Center(child: Icon(Icons.broken_image)),
                    );
                  },
                ),
              ),
            ListTile(
              title: Text(widget.article.title),
              subtitle: Text(widget.article.description),
              trailing: IconButton(
                icon: Icon(
                  isSaved ? Icons.bookmark : Icons.bookmark_outline,
                  color: isSaved ? Colors.red[900] : Colors.grey,
                ),
                onPressed: toggleBookmark,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

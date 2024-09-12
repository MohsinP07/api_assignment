import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:api_assignment/models/news_model.dart';
import 'package:api_assignment/widgets/blog_tile.dart';

class FavsTab extends StatefulWidget {
  const FavsTab({super.key});

  @override
  State<FavsTab> createState() => _FavsTabState();
}

class _FavsTabState extends State<FavsTab> {
  List<NewsModel> favoriteArticles = [];

  @override
  void initState() {
    super.initState();
    loadFavorites();
  }

  // Remove an article from favorites and update SharedPreferences
  void removeFromFavorites(NewsModel article) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      favoriteArticles.removeWhere((item) => item.url == article.url);
      List<String> favoritesList =
          favoriteArticles.map((item) => jsonEncode(item.toJson())).toList();
      prefs.setStringList('favorites', favoritesList);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Removed from favorites')),
    );
  }

  // Load favorites from SharedPreferences
  void loadFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? favoritesList = prefs.getStringList('favorites');
    setState(() {
      favoriteArticles = favoritesList
              ?.map((item) => NewsModel.fromJson(jsonDecode(item)))
              .toList() ??
          [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: favoriteArticles.isEmpty
          ? Center(child: Text('No favorites added'))
          : ListView.builder(
              itemCount: favoriteArticles.length,
              itemBuilder: (context, index) {
                final article = favoriteArticles[index];
                return Dismissible(
                  key: Key(article.url ?? ''),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) {
                    removeFromFavorites(article);
                  },
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  child: Card(
                    elevation: 6.0,
                    child: BlogTile(
                      imageUrl: article.urlToImage ?? '',
                      title: article.title ?? 'No Title',
                      desc: article.description ?? 'No Description',
                      url: article.url ?? '',
                      publishedAt: article.publishedAt ?? '',
                      content: article.content ?? '',
                      fromList: "Favs",
                    ),
                  ),
                );
              },
            ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:api_assignment/models/news_model.dart';
import 'package:api_assignment/services/news.dart';
import 'package:api_assignment/widgets/blog_tile.dart';

class NewsTab extends StatefulWidget {
  const NewsTab({super.key});

  @override
  State<NewsTab> createState() => _NewsTabState();
}

class _NewsTabState extends State<NewsTab> {
  List<NewsModel> articles = [];
  List<String> favoriteArticles = [];

  @override
  void initState() {
    super.initState();
    getNews();
    loadFavorites();
  }

  getNews() async {
    News newsClass = News();
    await newsClass.getNews();
    setState(() {
      articles = newsClass.news;
    });
  }

  void loadFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      favoriteArticles = prefs.getStringList('favorites') ?? [];
    });
  }

  
  void addToFavorites(NewsModel article) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      favoriteArticles.add(jsonEncode(article.toJson()));
      prefs.setStringList('favorites', favoriteArticles);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Added to favorites')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      body: articles.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Container(
              padding: const EdgeInsets.all(12),
              child: ListView.separated(
                itemCount: articles.length,
                shrinkWrap: true,
                primary: false,
                physics: const ClampingScrollPhysics(),
                itemBuilder: (context, index) {
                  final article = articles[index];
                  return Dismissible(
                    key: Key(article.url ?? ''),
                    direction: DismissDirection.endToStart,
                    onDismissed: (direction) {
                      setState(() {
                        articles.removeAt(index);
                      });
                      addToFavorites(article);
                    },
                    background: Container(
                      color: Colors.red.shade300,
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.favorite, color: Colors.white),
                          Text(
                            "Add to \nFavorite",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    ),
                    child: Card(
                      elevation: 6.0,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            color: Colors.grey.shade800.withOpacity(0.5),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: deviceSize.width * 1.5 / 100,
                            vertical: deviceSize.height * 0.5 / 100,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              BlogTile(
                                imageUrl: article.urlToImage ?? '',
                                title: article.title ?? 'No Title',
                                desc: article.description ?? 'No Description',
                                url: article.url ?? '',
                                publishedAt: article.publishedAt ?? '',
                                content: article.content ?? '',
                                fromList: "News",
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                    const SizedBox(height: 14),
              ),
            ),
    );
  }
}

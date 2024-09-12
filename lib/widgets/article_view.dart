import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class ArticleView extends StatefulWidget {
  final String imageUrl;
  final String title;
  final String publishedAt;
  final String content;
  final String fromList;

  ArticleView({
    required this.imageUrl,
    required this.title,
    required this.publishedAt,
    required this.content,
    required this.fromList,
  });

  @override
  State<ArticleView> createState() => _ArticleViewState();
}

class _ArticleViewState extends State<ArticleView> {
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    DateTime dateTime = DateTime.parse(widget.publishedAt);
    String formattedDate =
        DateFormat('EEE, dd MMM yyyy HH:mm \'GMT\'').format(dateTime);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Article'),
        backgroundColor: Colors.grey.shade600,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      widget.imageUrl,
                      height: deviceSize.height * 0.3,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        height: deviceSize.height * 0.3,
                        color: Colors.grey[200],
                        child: const Center(
                          child: Icon(
                            Icons.broken_image,
                            size: 50,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (widget.fromList == 'Favs')
                    const Positioned(
                      top: 10,
                      right: 10,
                      child: Icon(
                        FontAwesomeIcons.heart,
                        color: Colors.red,
                        size: 30,
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                widget.title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(
                    Icons.calendar_month,
                    color: Colors.grey.shade600,
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Text(
                    formattedDate,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                widget.content,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                  height: 1.5,
                ),
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:api_assignment/widgets/article_view.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BlogTile extends StatelessWidget {
  final String imageUrl, title, desc, url, publishedAt;
  final String? content;
  final String fromList;
  BlogTile(
      {required this.imageUrl,
      required this.title,
      required this.desc,
      required this.url,
      required this.publishedAt,
      this.content,
      required this.fromList});

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    DateTime dateTime = DateTime.parse(publishedAt);
    String formattedDate =
        DateFormat('EEE, dd MMM yyyy HH:mm \'GMT\'').format(dateTime);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ArticleView(
                    imageUrl: imageUrl,
                    title: title,
                    content: content!,
                    publishedAt: publishedAt,
                    fromList: fromList,
                  )),
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: deviceSize.height * 0.02),
        padding: EdgeInsets.all(deviceSize.height * 0.01),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.network(
                imageUrl,
                height: deviceSize.height * 0.15,
                width: deviceSize.height * 0.15,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              width: deviceSize.width * 0.03,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: deviceSize.width * 0.05,
                      color: Colors.black87,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: deviceSize.height * 0.01,
                  ),
                  Text(
                    desc,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.grey.shade600,
                    ),
                  ),
                  SizedBox(
                    height: deviceSize.height * 0.02,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        formattedDate,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Icon(
                        Icons.navigate_next,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:campus_carbon/constants/size_constants.dart';
import 'package:flutter/material.dart';

class NewsCard extends StatelessWidget {
  final String imgUrl, title, desc, content, postUrl;

  const NewsCard({
    super.key,
    required this.imgUrl,
    required this.desc,
    required this.title,
    required this.content,
    required this.postUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const SizedBox(height: 30),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10),
            ),
            width: MediaQuery.of(context).size.width * 0.9,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min, // Use min to fit content
              children: <Widget>[
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(Sizes.dimen_10),
                    topRight: Radius.circular(Sizes.dimen_10),
                  ),
                  child: Image.network(
                    imgUrl,
                    height: MediaQuery.of(context).size.height * 0.2,
                    width: double.infinity,
                    fit: BoxFit.cover, // Cover instead of fitWidth
                    errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                      return Card(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const SizedBox(
                          height: 200,
                          width: double.infinity,
                          child: Icon(Icons.broken_image_outlined),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(Sizes.dimen_6),
                  child: Text(
                    title,
                    maxLines: 2, // Limit to two lines
                    overflow: TextOverflow.ellipsis, // Ellipsis for overflow
                    style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomCardNormal extends StatelessWidget {
  final String title;
  final String chapter;
  final String imageUrl;
  final String? type;

  const CustomCardNormal({
    super.key,
    required this.title,
    required this.chapter,
    required this.imageUrl,
    this.type,
  });

  String getFlagImage(type) {
    if (type == 'manga') {
      return 'https://flagcdn.com/w20/jp.jpg';
    } else if (type == 'manhwa') {
      return 'https://flagcdn.com/w20/kr.jpg';
    } else if (type == 'manhua') {
      return 'https://flagcdn.com/w20/cn.jpg';
    } else {
      return 'https://flagcdn.com/w20/jp.jpg';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            Container(
              height: 150, // Reduced height since title is now below
              width: 120,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: CachedNetworkImageProvider(imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
              foregroundDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            Positioned(
              left: 7,
              top: 7,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  chapter,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            if (type != null)
              Positioned(
                right: 9,
                top: 7,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(2),
                  child: CachedNetworkImage(
                    imageUrl: getFlagImage(type),
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 4), // Add some space between card and title
        Container(
          width: 120,
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Text(
            title,
            maxLines: 2,
            textAlign: TextAlign.start, // Changed from center to start
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.white, // Changed from white to black
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}

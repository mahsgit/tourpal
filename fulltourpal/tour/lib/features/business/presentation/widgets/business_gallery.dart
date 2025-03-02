import 'package:flutter/material.dart';

class BusinessGallery extends StatefulWidget {
  final String businessId;

  const BusinessGallery({
    Key? key,
    required this.businessId,
  }) : super(key: key);

  @override
  State<BusinessGallery> createState() => _BusinessGalleryState();
}

class _BusinessGalleryState extends State<BusinessGallery> {
  int _currentIndex = 0;
  final int _imageCount = 5;

  String _getRandomImageUrl(int index) {
    return 'https://picsum.photos/800/600?random=${widget.businessId}$index';
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PageView.builder(
          itemCount: _imageCount,
          onPageChanged: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          itemBuilder: (context, index) {
            return Image.network(
              _getRandomImageUrl(index),
              fit: BoxFit.cover,
            );
          },
        ),
        Positioned(
          bottom: 16,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              _imageCount,
              (index) => Container(
                width: 8,
                height: 8,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentIndex == index
                      ? Theme.of(context).primaryColor
                      : Colors.white.withOpacity(0.5),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}


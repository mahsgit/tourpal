import 'package:flutter/material.dart';
import 'dart:math';
import '../../domain/entities/business_entity.dart';
import 'rating_display.dart';

class BusinessCard extends StatelessWidget {
  final BusinessEntity business;

  const BusinessCard({
    Key? key,
    required this.business,
  }) : super(key: key);

  String _getRandomImageUrl() {
    final List<String> hotelImages = [
      'https://picsum.photos/200/300?7',
      'https://picsum.photos/200/300?8',
      'https://picsum.photos/200/300?9',
      'https://picsum.photos/200/300?10',
    ];
    final randomIndex = Random().nextInt(hotelImages.length);
    return hotelImages[randomIndex];
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          '/business/details',
          arguments: business.id,
        );
      },
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 16 / 9, // Wider aspect ratio to reduce image height
              child: Image.network(
                _getRandomImageUrl(),
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible( // Constrain business name
                      child: Text(
                        business.businessName,
                        style: Theme.of(context).textTheme.titleMedium,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Flexible( // Constrain business type
                      child: Text(
                        business.businessType,
                        style: Theme.of(context).textTheme.bodySmall,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              RatingDisplay(rating: business.rating),
                              Text(
                                '\$${business.price.toStringAsFixed(0)}',
                                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                      color: Theme.of(context).primaryColor,
                                    ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    minimumSize: const Size(0, 36), // Smaller button height
                                    padding: const EdgeInsets.symmetric(vertical: 4),
                                  ),
                                  onPressed: () {
                                    Navigator.pushNamed(
                                      context,
                                      '/business/details',
                                      arguments: business.id,
                                    );
                                  },
                                  child: const Text('Details'),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
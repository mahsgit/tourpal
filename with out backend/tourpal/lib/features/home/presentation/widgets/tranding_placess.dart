import 'package:flutter/material.dart';
import 'package:tourpal/features/home/domain/entities/place_entity.dart';

class TrendingPlaces extends StatelessWidget {
  final List<PlaceEntity> places;
  final VoidCallback onSeeAllPressed;

  const TrendingPlaces({
    Key? key,
    required this.places,
    required this.onSeeAllPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Trending Places',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              TextButton(
                onPressed: onSeeAllPressed,
                child: Text('See All'),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: places.length,
            itemBuilder: (context, index) {
              final place = places[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/place-details',
                      arguments: {'placeId': place.id},
                    );
                  },
                  child: PlaceCard(place: place),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class PlaceCard extends StatelessWidget {
  final PlaceEntity place;

  const PlaceCard({Key? key, required this.place}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              place.imageUrl,
              height: 100,
              width: 150,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 8),
          Text(
            place.name,
            style: Theme.of(context).textTheme.titleMedium,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            place.location,
            style: Theme.of(context).textTheme.bodySmall,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}


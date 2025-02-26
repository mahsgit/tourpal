class Place {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final String openingHours;
  final String waitingTime;
  final String type;
  final String capacity;
  final List<String> goodFor;
  final List<String> amenities;
  final double distance;
  final List<String> photos;
  final List<Review> reviews;
  final List<Participant> participants;

  Place({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.openingHours,
    required this.waitingTime,
    required this.type,
    required this.capacity,
    required this.goodFor,
    required this.amenities,
    required this.distance,
    required this.photos,
    required this.reviews,
    required this.participants,
  });
}

class Review {
  final String authorName;
  final String authorAvatar;
  final double rating;
  final String content;
  final String timePosted;
  final List<String> images;

  Review({
    required this.authorName,
    required this.authorAvatar,
    required this.rating,
    required this.content,
    required this.timePosted,
    required this.images,
  });
}

class Participant {
  final String name;
  final String avatar;

  Participant({
    required this.name,
    required this.avatar,
  });
}


import '../../../home/data/models/place_model.dart';

abstract class SearchLocalDataSource {
 
  Future<List<PlaceModel>> searchPlaces(String query);
}

class SearchLocalDataSourceImpl implements SearchLocalDataSource {
  final List<PlaceModel> _places = [
    const PlaceModel(
      id: '1',
      name: 'Lalibela',
      imageUrl: 'https://picsum.photos/200/300?1',
      rating: 4.5,
      description: 'Historic churches carved from rock',
      price: 1200,
      isFavorite: false,
      location:  'Addis Ababa'
    ),
    const PlaceModel(
      id: '2',
      name: 'Menelik Statue',
      imageUrl: 'https://picsum.photos/200/300?2',
      rating: 4.0,
      description: 'Historic statue in the heart of Addis',
      price: 1300,
      isFavorite: true,
      location:  'Addis Ababa'
    ),
    const PlaceModel(
      id: '3',
      name: 'Ambassador',
      imageUrl: 'https://picsum.photos/200/300?3',
      rating: 4.2,
      description: 'Luxury hotel in the city center',
      price: 1500,
      isFavorite: false,
      location:  'Addis Ababa'
    ),
  ];

  

  @override
  Future<List<PlaceModel>> searchPlaces(String query) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _places.where((place) =>
      place.name.toLowerCase().contains(query.toLowerCase()) ||
      place.description.toLowerCase().contains(query.toLowerCase())
    ).toList();
  }
}


import '../models/place_model.dart';
import '../models/category_model.dart';

abstract class HomeLocalDataSource {
  Future<List<PlaceModel>> getTrendingPlaces();
  Future<List<CategoryModel>> getCategories();
  Future<List<PlaceModel>> getRecommendedPlaces();
  // Future<List<PlaceModel>> searchPlaces(String query);
}

class HomeLocalDataSourceImpl implements HomeLocalDataSource {
  final List<PlaceModel> _places = [
    const PlaceModel(
      id: '1',
      name: 'Lalibela',
      imageUrl: 'https://picsum.photos/200/300?1',
      rating: 4.5,
      description: 'Historic churches carved from rock',
      price: 1200,
      isFavorite: false,
      location: 'Addis Ababa'
    ),
    const PlaceModel(
      id: '2',
      name: 'Menelik Statue',
      imageUrl: 'https://picsum.photos/200/300?2',
      rating: 4.0,
      description: 'Historic statue in the heart of Addis',
      price: 1300,
      isFavorite: true,
      location: 'Addis Ababa'
    ),
    const PlaceModel(
      id: '3',
      name: 'Ambassador',
      imageUrl: 'https://picsum.photos/200/300?3',
      rating: 4.2,
      description: 'Luxury hotel in the city center',
      price: 1500,
      isFavorite: false,
      location: 'Addis Ababa'
    ),
  ];

  final List<CategoryModel> _categories = const [
    CategoryModel(
      id: '1',
      name: 'Mountains',
      icon: '🏔️',
    ),
    CategoryModel(
      id: '2',
      name: 'Beach',
      icon: '🏖️',
    ),
    CategoryModel(
      id: '3',
      name: 'Lakes',
      icon: '🌊',
    ),
    CategoryModel(
      id: '4',
      name: 'Desert',
      icon: '🏜️',
    ),
  ];

  @override
  Future<List<PlaceModel>> getTrendingPlaces() async {
    await Future.delayed(const Duration(seconds: 1));
    return _places.take(2).toList();
  }

  @override
  Future<List<CategoryModel>> getCategories() async {
    await Future.delayed(const Duration(seconds: 1));
    return _categories;
  }

  @override
  Future<List<PlaceModel>> getRecommendedPlaces() async {
    await Future.delayed(const Duration(seconds: 1));
    return _places.skip(1).take(2).toList();
  }

  // @override
  // Future<List<PlaceModel>> searchPlaces(String query) async {
  //   await Future.delayed(const Duration(milliseconds: 500));
  //   return _places.where((place) =>
  //     place.name.toLowerCase().contains(query.toLowerCase()) ||
  //     place.description.toLowerCase().contains(query.toLowerCase())
  //   ).toList();
  // }
}

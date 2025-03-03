import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/room_type_model.dart';

abstract class RoomLocalDataSource {
  Future<List<RoomTypeModel>> getCachedRoomTypes(String businessId);
  Future<void> cacheRoomTypes(String businessId, List<RoomTypeModel> rooms);
}

class RoomLocalDataSourceImpl implements RoomLocalDataSource {
  final SharedPreferences sharedPreferences;
  final String cacheKey = 'CACHED_ROOM_TYPES';

  RoomLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<List<RoomTypeModel>> getCachedRoomTypes(String businessId) async {
    final jsonString = sharedPreferences.getString('${cacheKey}_$businessId');
    if (jsonString != null) {
      final List<dynamic> jsonList = json.decode(jsonString);
      return jsonList.map((json) => RoomTypeModel.fromJson(json)).toList();
    }
    return [];
  }

  @override
  Future<void> cacheRoomTypes(String businessId, List<RoomTypeModel> rooms) async {
    final String jsonString = json.encode(
      rooms.map((room) => room.toJson()).toList(),
    );
    await sharedPreferences.setString('${cacheKey}_$businessId', jsonString);
  }
}


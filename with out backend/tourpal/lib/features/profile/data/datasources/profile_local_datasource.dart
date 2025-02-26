import '../models/profile_model.dart';

abstract class ProfileLocalDataSource {
  Future<ProfileModel> getProfile();
}

class ProfileLocalDataSourceImpl implements ProfileLocalDataSource {
  @override
  Future<ProfileModel> getProfile() async {
    await Future.delayed(const Duration(seconds: 1));
    return const ProfileModel(
      id: '1',
      name: 'Elsa Abebe',
      imageUrl: 'https://i.pravatar.cc/150?img=1',
      address: 'Ethiopia, AA - 1230',
      isPremium: true,
    );
  }
}


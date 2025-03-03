// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../domain/entities/user_profile_entity.dart';
// import '../bloc/profile_bloc.dart';
// import '../bloc/profile_event.dart';
// import '../bloc/profile_state.dart';
// import '../widgets/profile_image_picker.dart';

// class EditProfilePage extends StatefulWidget {
//   final UserProfileEntity profile;

//   const EditProfilePage({Key? key, required this.profile}) : super(key: key);

//   @override
//   State<EditProfilePage> createState() => _EditProfilePageState();
// }

// class _EditProfilePageState extends State<EditProfilePage> {
//   late final TextEditingController _firstNameController;
//   late final TextEditingController _lastNameController;
//   late final TextEditingController _phoneController;
//   late final TextEditingController _nationalityController;
//   late final TextEditingController _streetController;
//   late final TextEditingController _cityController;
//   late final TextEditingController _stateController;
//   late final TextEditingController _postalCodeController;
//   late final TextEditingController _countryController;

//   @override
//   void initState() {
//     super.initState();
//     _firstNameController = TextEditingController(text: widget.profile.firstName);
//     _lastNameController = TextEditingController(text: widget.profile.lastName);
//     _phoneController = TextEditingController(text: widget.profile.phoneNumber);
//     _nationalityController = TextEditingController(text: widget.profile.nationality);
//     _streetController = TextEditingController(text: widget.profile.address?.street);
//     _cityController = TextEditingController(text: widget.profile.address?.city);
//     _stateController = TextEditingController(text: widget.profile.address?.state);
//     _postalCodeController = TextEditingController(text: widget.profile.address?.postalCode);
//     _countryController = TextEditingController(text: widget.profile.address?.country);
//   }

//   @override
//   void dispose() {
//     _firstNameController.dispose();
//     _lastNameController.dispose();
//     _phoneController.dispose();
//     _nationalityController.dispose();
//     _streetController.dispose();
//     _cityController.dispose();
//     _stateController.dispose();
//     _postalCodeController.dispose();
//     _countryController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Edit Profile'),
//       ),
//       body: BlocConsumer<ProfileBloc, ProfileState>(
//         listener: (context, state) {
//           if (state is ProfileError) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(content: Text(state.message)),
//             );
//           } else if (state is ProfileLoaded) {
//             Navigator.pop(context);
//           }
//         },
//         builder: (context, state) {
//           return SingleChildScrollView(
//             padding: const EdgeInsets.all(16),
//             child: Column(
//               children: [
//                 ProfileImagePicker(
//                   currentImageUrl: widget.profile.profilePicture?.url,
//                   onImageSelected: (file) {
//                     // Handle image selection
//                   },
//                 ),
//                 const SizedBox(height: 24),
//                 TextFormField(
//                   controller: _firstNameController,
//                   decoration: const InputDecoration(
//                     labelText: 'First Name',
//                     border: OutlineInputBorder(),
//                   ),
//                 ),
//                 const SizedBox(height: 16),
//                 TextFormField(
//                   controller: _lastNameController,
//                   decoration: const InputDecoration(
//                     labelText: 'Last Name',
//                     border: OutlineInputBorder(),
//                   ),
//                 ),
//                 const SizedBox(height: 16),
//                 TextFormField(
//                   controller: _phoneController,
//                   decoration: const InputDecoration(
//                     labelText: 'Phone Number',
//                     border: OutlineInputBorder(),
//                   ),
//                 ),
//                 const SizedBox(height: 16),
//                 TextFormField(
//                   controller: _nationalityController,
//                   decoration: const InputDecoration(
//                     labelText: 'Nationality',
//                     border: OutlineInputBorder(),
//                   ),
//                 ),
//                 const SizedBox(height: 24),
//                 const Text(
//                   'Address',
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const SizedBox(height: 16),
//                 TextFormField(
//                   controller: _streetController,
//                   decoration: const InputDecoration(
//                     labelText: 'Street',
//                     border: OutlineInputBorder(),
//                   ),
//                 ),
//                 const SizedBox(height: 16),
//                 TextFormField(
//                   controller: _cityController,
//                   decoration: const InputDecoration(
//                     labelText: 'City',
//                     border: OutlineInputBorder(),
//                   ),
//                 ),
//                 const SizedBox(height: 16),
//                 TextFormField(
//                   controller: _stateController,
//                   decoration: const InputDecoration(
//                     labelText: 'State',
//                     border: OutlineInputBorder(),
//                   ),
//                 ),
//                 const SizedBox(height: 16),
//                 TextFormField(
//                   controller: _postalCodeController,
//                   decoration: const InputDecoration(
//                     labelText: 'Postal Code',
//                     border: OutlineInputBorder(),
//                   ),
//                 ),
//                 const SizedBox(height: 16),
//                 TextFormField(
//                   controller: _countryController,
//                   decoration: const InputDecoration(
//                     labelText: 'Country',
//                     border: OutlineInputBorder(),
//                   ),
//                 ),
//                 const SizedBox(height: 24),
//                 SizedBox(
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     onPressed: state is ProfileLoading
//                         ? null
//                         : () {
//                             // TODO: Create updated profile entity and dispatch update event
//                           },
//                     child: state is ProfileLoading
//                         ? const CircularProgressIndicator()
//                         : const Text('Save Changes'),
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/user_profile_entity.dart';
import '../../domain/entities/address_entity.dart';
import '../bloc/profile_bloc.dart';
import '../bloc/profile_event.dart';
import '../bloc/profile_state.dart';
import '../widgets/profile_image_picker.dart';

class EditProfilePage extends StatefulWidget {
  final UserProfileEntity profile;

  const EditProfilePage({Key? key, required this.profile}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late final TextEditingController _firstNameController;
  late final TextEditingController _lastNameController;
  late final TextEditingController _phoneController;
  late final TextEditingController _nationalityController;
  late final TextEditingController _streetController;
  late final TextEditingController _cityController;
  late final TextEditingController _stateController;
  late final TextEditingController _postalCodeController;
  late final TextEditingController _countryController;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController(text: widget.profile.firstName);
    _lastNameController = TextEditingController(text: widget.profile.lastName);
    _phoneController = TextEditingController(text: widget.profile.phoneNumber);
    _nationalityController = TextEditingController(text: widget.profile.nationality);
    _streetController = TextEditingController(text: widget.profile.address?.street);
    _cityController = TextEditingController(text: widget.profile.address?.city);
    _stateController = TextEditingController(text: widget.profile.address?.state);
    _postalCodeController = TextEditingController(text: widget.profile.address?.postalCode);
    _countryController = TextEditingController(text: widget.profile.address?.country);
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _nationalityController.dispose();
    _streetController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _postalCodeController.dispose();
    _countryController.dispose();
    super.dispose();
  }

  void _handleSaveChanges() {
    setState(() {
      _isLoading = true;
    });
    final updatedProfile = UserProfileEntity(
      id: widget.profile.id,
      email: widget.profile.email,
      firstName: _firstNameController.text,
      lastName: _lastNameController.text,
      phoneNumber: _phoneController.text,
      nationality: _nationalityController.text,
      profilePicture: widget.profile.profilePicture,
      address: AddressEntity(
        street: _streetController.text,
        city: _cityController.text,
        state: _stateController.text,
        postalCode: _postalCodeController.text,
        country: _countryController.text,
      ),
      registrationDate: widget.profile.registrationDate,
      isComplete: widget.profile.isComplete,
      emailVerified: widget.profile.emailVerified,
    );

    context.read<ProfileBloc>().add(UpdateProfileRequested(profile: updatedProfile));
  }

  void _handleDeleteAccount() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Account'),
        content: const Text(
          'Are you sure you want to delete your account? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              context.read<ProfileBloc>().add(DeleteProfileRequested( profile: widget.profile));
              Navigator.pop(context); // Close dialog
            },
            child: const Text(
              'Delete',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            color: Colors.red,
            onPressed: _handleDeleteAccount,
          ),
        ],
      ),
      body: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) {
          setState(() {
            _isLoading = false;
          });
          if (state is ProfileError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          } else if (state is ProfileLoaded) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Profile updated successfully')),
            );
            Navigator.pop(context, true); // Pass true to indicate successful update
          } else if (state is ProfileDeleted) {
            Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                ProfileImagePicker(
                  currentImageUrl: widget.profile.profilePicture?.url,
                  onImageSelected: (file) {
                    // Handle image selection
                  },
                ),
                const SizedBox(height: 24),
                TextFormField(
                  controller: _firstNameController,
                  decoration: const InputDecoration(
                    labelText: 'First Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _lastNameController,
                  decoration: const InputDecoration(
                    labelText: 'Last Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _phoneController,
                  decoration: const InputDecoration(
                    labelText: 'Phone Number',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _nationalityController,
                  decoration: const InputDecoration(
                    labelText: 'Nationality',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Address',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _streetController,
                  decoration: const InputDecoration(
                    labelText: 'Street',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _cityController,
                  decoration: const InputDecoration(
                    labelText: 'City',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _stateController,
                  decoration: const InputDecoration(
                    labelText: 'State',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _postalCodeController,
                  decoration: const InputDecoration(
                    labelText: 'Postal Code',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _countryController,
                  decoration: const InputDecoration(
                    labelText: 'Country',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _handleSaveChanges,
                    child: _isLoading
                        ? const CircularProgressIndicator()
                        : const Text('Save Changes'),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/profile_bloc.dart';
import '../bloc/profile_event.dart';
import '../bloc/profile_state.dart';
import '../widgets/profile_menu_item.dart';
import '../widgets/profile_header.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is ProfileError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          } else if (state is ProfileDeleted) {
            Navigator.of(context).pushReplacementNamed('/login');
          }
        },
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProfileLoaded) {
            return SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ProfileHeader(profile: state.profile),
                    const SizedBox(height: 24),
                    ProfileMenuItem(
                      icon: Icons.edit,
                      title: 'Edit Profile',
                      onTap: () => Navigator.pushNamed(
                        context,
                        '/profile/edit',
                        arguments: state.profile,
                      ),
                    ),
                    ProfileMenuItem(
                      icon: Icons.calendar_today,
                      title: 'Track My Bookings',
                      onTap: () {},
                    ),
                    ProfileMenuItem(
                      icon: Icons.history,
                      title: 'My History',
                      onTap: () {},
                    ),
                    ProfileMenuItem(
                      icon: Icons.backpack,
                      title: 'Packing Tips',
                      onTap: () {},
                    ),
                    const Divider(),
                    ProfileMenuItem(
                      icon: Icons.payment,
                      title: 'Payment Method',
                      onTap: () {},
                    ),
                    const Divider(),
                    ProfileMenuItem(
                      icon: Icons.help,
                      title: 'Help Center',
                      onTap: () {},
                    ),
                    ProfileMenuItem(
                      icon: Icons.info,
                      title: 'Legal Info',
                      onTap: () {},
                    ),
                    ProfileMenuItem(
                      icon: Icons.delete,
                      title: 'Delete Account',
                      onTap: () => _showDeleteConfirmation(context),
                      textColor: Colors.red,
                    ),
                  ],
                ),
              ),
            );
          }
          return const Center(child: Text('Something went wrong'));
        },
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context) {
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
              context.read<ProfileBloc>().add(DeleteProfileRequested());
              Navigator.pop(context);
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
}


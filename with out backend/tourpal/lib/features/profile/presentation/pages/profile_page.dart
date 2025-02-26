import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/profile_bloc.dart';
import '../bloc/profile_state.dart';
import '../widgets/profile_header.dart';
import '../widgets/profile_menu.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileInitial) {
            context.read<ProfileBloc>().add(LoadProfile());
            return const Center(child: CircularProgressIndicator());
          }
          
          if (state is ProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          
          if (state is ProfileLoaded) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  ProfileHeader(profile: state.profile),
                  const SizedBox(height: 24),
                  ProfileMenuItem(
                    icon: Icons.edit,
                    title: 'Edit Profile',
                    onTap: () {
                      // Handle edit profile
                    },
                  ),
                  ProfileMenuItem(
                    icon: Icons.bookmark,
                    title: 'Track My Bookings',
                    onTap: () {
                      // Handle bookings
                    },
                  ),
                  ProfileMenuItem(
                    icon: Icons.history,
                    title: 'My History',
                    onTap: () {
                      // Handle history
                    },
                  ),
                  ProfileMenuItem(
                    icon: Icons.backpack,
                    title: 'Packing Tips',
                    onTap: () {
                      // Handle packing tips
                    },
                  ),
                  ProfileMenuItem(
                    icon: Icons.payment,
                    title: 'Payment Method',
                    onTap: () {
                      // Handle payment method
                    },
                  ),
                  ProfileMenuItem(
                    icon: Icons.help,
                    title: 'Help Center',
                    onTap: () {
                      // Handle help center
                    },
                  ),
                  ProfileMenuItem(
                    icon: Icons.info,
                    title: 'Legal Info',
                    onTap: () {
                      // Handle legal info
                    },
                  ),
                ],
              ),
            );
          }
          
          if (state is ProfileError) {
            return Center(
              child: Text(state.message),
            );
          }
          
          return const SizedBox.shrink();
        },
      ),
    );
  }
}


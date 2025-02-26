import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tour/features/auth/auth/presentation/bloc/auth_bloc.dart';
import 'package:tour/features/auth/auth/presentation/bloc/auth_event.dart';
import 'package:tour/features/auth/auth/presentation/bloc/auth_state.dart';
import 'package:tour/features/profile/presentation/bloc/profile_event.dart';
import 'features/profile/presentation/bloc/profile_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              context.read<ProfileBloc>().add(LoadProfile());
              Navigator.pushNamed(context, '/profile');
            },
          ),
        ],
      ),
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthAuthenticated) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Welcome, ${state.user.email}!',
                    style: const TextStyle(fontSize: 24),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<AuthBloc>().add(LogoutRequested());
                    },
                    child: const Text('Logout'),
                  ),
                ],
              ),
            );
          }
          return const Center(
            child: Text('Please login to continue'),
          );
        },
      ),
    );
  }
}


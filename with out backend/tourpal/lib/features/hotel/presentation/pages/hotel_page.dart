

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/hotel_bloc.dart';
import '../widgets/hotel_card_widgest.dart';
import '../widgets/service_tabs.dart';

class HotelsPage extends StatelessWidget {
  const HotelsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Services'),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
      ),
      body: Column(
        children: [
          const ServiceTabs(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search any hotels...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[100],
              ),
              onChanged: (query) {
                context.read<HotelBloc>().add(SearchHotels(query));
              },
            ),
          ),
          Expanded(
            child: BlocBuilder<HotelBloc, HotelState>(
              builder: (context, state) {
                if (state is HotelInitial) {
                  context.read<HotelBloc>().add(LoadHotels());
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is HotelLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is HotelsLoaded) {
                  if (state.hotels.isEmpty) {
                    return const Center(
                      child: Text('No hotels found'),
                    );
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: state.hotels.length,
                    itemBuilder: (context, index) {
                      return HotelCard(
                        hotel: state.hotels[index],
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            '/room-services',
                            arguments: state.hotels[index].id,
                          );
                        },
                      );
                    },
                  );
                }

                if (state is HotelError) {
                  return Center(child: Text(state.message));
                }

                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }
}


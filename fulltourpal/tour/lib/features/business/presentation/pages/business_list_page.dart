import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/business_bloc.dart';
import '../bloc/business_event.dart';
import '../bloc/business_state.dart';
import '../widgets/business_card.dart';
import '../widgets/service_category.dart';

class BusinessListPage extends StatefulWidget {
  const BusinessListPage({Key? key}) : super(key: key);

  @override
  State<BusinessListPage> createState() => _BusinessListPageState();
}

class _BusinessListPageState extends State<BusinessListPage> {
  final ScrollController _scrollController = ScrollController();
  int _currentPage = 1;
  static const int _itemsPerPage = 10;

  @override
  void initState() {
    super.initState();
    _loadBusinesses();
    _scrollController.addListener(_onScroll);
  }

  void _loadBusinesses() {
    context.read<BusinessBloc>().add(LoadBusinesses());
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _currentPage++;
      context.read<BusinessBloc>().add(
            LoadMoreBusinesses(
              page: _currentPage,
              limit: _itemsPerPage,
            ),
          );
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const CircleAvatar(
                          backgroundImage: NetworkImage(
                            'https://example.com/profile.jpg',
                          ),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Hello,',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            Text(
                              'Daniel',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ],
                        ),
                        const Spacer(),
                        IconButton(
                          icon: const Icon(Icons.notifications_outlined),
                          onPressed: () {
                            // Handle notifications
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Services',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 16),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          ServiceCategory(
                            icon: Icons.hotel,
                            label: 'Hotels',
                            isActive: true,
                            onTap: () {
                              // Handle hotel category tap
                            },
                          ),
                          ServiceCategory(
                            icon: Icons.flight,
                            label: 'Flights',
                            onTap: () {
                              // Coming soon
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Coming soon!'),
                                ),
                              );
                            },
                          ),
                          ServiceCategory(
                            icon: Icons.car_rental,
                            label: 'Car Rental',
                            onTap: () {
                              // Coming soon
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Coming soon!'),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Popular Hotels',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
              ),
            ),
            BlocBuilder<BusinessBloc, BusinessState>(
              builder: (context, state) {
                if (state is BusinessLoading && _currentPage == 1) {
                  return const SliverFillRemaining(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                if (state is BusinessError) {
                  return SliverFillRemaining(
                    child: Center(
                      child: Text(state.message),
                    ),
                  );
                }

                if (state is BusinessesLoaded) {
                  return SliverPadding(
                    padding: const EdgeInsets.all(16.0),
                    sliver: SliverGrid(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 16.0,
                        crossAxisSpacing: 16.0,
                        childAspectRatio: 0.75,
                      ),
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          if (index >= state.businesses.length) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          return BusinessCard(
                            business: state.businesses[index],
                          );
                        },
                        childCount: state.businesses.length +
                            (state is BusinessLoading ? 1 : 0),
                      ),
                    ),
                  );
                }

                return const SliverToBoxAdapter(child: SizedBox.shrink());
              },
            ),
          ],
        ),
      ),
    );
  }
}


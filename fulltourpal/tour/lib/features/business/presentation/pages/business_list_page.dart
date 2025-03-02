import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/business_bloc.dart';
import '../bloc/business_event.dart';
import '../bloc/business_state.dart';
import '../widgets/business_card.dart';
import '../widgets/service_category.dart';
import '../widgets/search_bar.dart';

class BusinessListPage extends StatefulWidget {
  const BusinessListPage({Key? key}) : super(key: key);

  @override
  State<BusinessListPage> createState() => _BusinessListPageState();
}

class _BusinessListPageState extends State<BusinessListPage> {
  final ScrollController _scrollController = ScrollController();
  int _currentPage = 1;
  static const int _itemsPerPage = 10;
  String _selectedCategory = 'Hotels';
  String _searchQuery = '';

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

  void _onSearch(String query) {
    setState(() {
      _searchQuery = query;
    });
    context.read<BusinessBloc>().add(SearchBusinesses(query: query));
  }

  void _onCategorySelected(String category) {
    setState(() {
      _selectedCategory = category;
    });
    if (category == 'Hotels') {
      context.read<BusinessBloc>().add(FilterBusinessesByCategory(category: 'hotel'));
    } else {
      // For other categories, load all businesses (for now)
      context.read<BusinessBloc>().add(LoadBusinesses());
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
                          backgroundImage: AssetImage('image/image.png'),
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
                          icon: const Icon(Icons.person_outline),
                          onPressed: () {
                            Navigator.pushNamed(context, '/profile');
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.notifications_outlined),
                          onPressed: () {
                            // Handle notifications
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    CustomSearchBar(
                      onSearch: _onSearch,
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
                            isActive: _selectedCategory == 'Hotels',
                            onTap: () => _onCategorySelected('Hotels'),
                          ),
                          ServiceCategory(
                            icon: Icons.flight,
                            label: 'Flights',
                            isActive: _selectedCategory == 'Flights',
                            onTap: () {
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
                            isActive: _selectedCategory == 'Car Rental',
                            onTap: () {
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
                  final filteredBusinesses = state.businesses.where((business) {
                    final matchesSearch = business.businessName
                        .toLowerCase()
                        .contains(_searchQuery.toLowerCase());
                    final matchesCategory = _selectedCategory == 'Hotels'
                        ? business.businessType.toLowerCase() == 'hotel'
                        : true; // For now, only filter Hotels, show all for other categories
                    return matchesSearch && matchesCategory;
                  }).toList();

                  if (filteredBusinesses.isEmpty) {
                    return const SliverFillRemaining(
                      child: Center(
                        child: Text('No businesses found'),
                      ),
                    );
                  }

                  return SliverPadding(
                    padding: const EdgeInsets.all(16.0),
                    sliver: SliverGrid(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 16.0,
                        crossAxisSpacing: 16.0,
                        childAspectRatio: 0.8,
                      ),
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          if (index >= filteredBusinesses.length) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          return BusinessCard(
                            business: filteredBusinesses[index],
                          );
                        },
                        childCount: filteredBusinesses.length +
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


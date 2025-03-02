import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tour/features/business/presentation/widgets/search_bar.dart';
import '../bloc/business_bloc.dart';
import '../bloc/business_event.dart';
import '../bloc/business_state.dart';
import '../widgets/business_card.dart';

class BusinessListPage extends StatefulWidget {
  const BusinessListPage({Key? key}) : super(key: key);

  @override
  State<BusinessListPage> createState() => _BusinessListPageState();
}

class _BusinessListPageState extends State<BusinessListPage> {
  final ScrollController _scrollController = ScrollController();
  int _currentPage = 1;
  static const int _itemsPerPage = 10;
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
                    return matchesSearch;
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
                        childAspectRatio: 0.75,
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


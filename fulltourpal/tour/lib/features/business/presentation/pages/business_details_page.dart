import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/business_entity.dart';
import '../bloc/business_bloc.dart';
import '../bloc/business_event.dart';
import '../bloc/business_state.dart';
import '../widgets/business_gallery.dart';
import '../widgets/business_info_section.dart';
import '../widgets/rating_display.dart';

class BusinessDetailsPage extends StatefulWidget {
  final String businessId;

  const BusinessDetailsPage({
    Key? key,
    required this.businessId,
  }) : super(key: key);

  @override
  State<BusinessDetailsPage> createState() => _BusinessDetailsPageState();
}

class _BusinessDetailsPageState extends State<BusinessDetailsPage> {
  @override
  void initState() {
    super.initState();
    context.read<BusinessBloc>().add(LoadBusinessDetails(widget.businessId));
  }

  void _handleBookNow(BusinessEntity business) {
    Navigator.pushNamed(
      context,
      '/booking',
      arguments: business,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<BusinessBloc, BusinessState>(
        builder: (context, state) {
          if (state is BusinessLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is BusinessError) {
            return Center(child: Text(state.message));
          }

          if (state is BusinessDetailsLoaded) {
            final business = state.business;
            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: 300.0,
                  floating: false,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                    background: BusinessGallery(
                      images: business.media.isEmpty
                          ? ['https://via.placeholder.com/400x300']
                          : business.media,
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                business.businessName,
                                style: Theme.of(context).textTheme.headlineSmall,
                              ),
                            ),
                            RatingDisplay(rating: business.rating),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '${business.address.city}, ${business.address.country}',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        const SizedBox(height: 24),
                        BusinessInfoSection(
                          title: 'Description',
                          content: business.description,
                        ),
                        const SizedBox(height: 16),
                        BusinessInfoSection(
                          title: 'Contact',
                          content:
                              'Phone: ${business.phoneNumber}\nEmail: ${business.email}',
                        ),
                        const SizedBox(height: 16),
                        BusinessInfoSection(
                          title: 'Address',
                          content:
                              '${business.address.street}\n${business.address.city}, ${business.address.state} ${business.address.postalCode}\n${business.address.country}',
                        ),
                        const SizedBox(height: 32),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }

          return const SizedBox.shrink();
        },
      ),
      bottomNavigationBar: BlocBuilder<BusinessBloc, BusinessState>(
        builder: (context, state) {
          if (state is BusinessDetailsLoaded) {
            return Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: ElevatedButton(
                onPressed: () => _handleBookNow(state.business),
                child: const Text('Book Now'),
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}


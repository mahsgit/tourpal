// import 'package:flutter/material.dart';
// import 'package:tourpal/features/home/presentation/places/pages/place_model.dart';

// class PlaceDetailPage extends StatefulWidget {
//   final Place place;

//   const PlaceDetailPage({
//     Key? key,
//     required this.place,
//   }) : super(key: key);

//   @override
//   _PlaceDetailPageState createState() => _PlaceDetailPageState();
// }

// class _PlaceDetailPageState extends State<PlaceDetailPage>
//     with SingleTickerProviderStateMixin {
//   late TabController _tabController;
//   int cleanShaveCount = 0;
//   int foodCount = 0;

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 4, vsync: this);
//   }

//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: CustomScrollView(
//         slivers: [
//           _buildAppBar(),
//           SliverPersistentHeader(
//             delegate: _SliverAppBarDelegate(
//               TabBar(
//                 controller: _tabController,
//                 labelColor: Theme.of(context).primaryColor,
//                 unselectedLabelColor: Colors.grey,
//                 indicatorColor: Theme.of(context).primaryColor,
//                 tabs: const [
//                   Tab(text: 'Overview'),
//                   Tab(text: 'Photo'),
//                   Tab(text: 'Review'),
//                   Tab(text: 'Community'),
//                 ],
//               ),
//             ),
//             pinned: true,
//           ),
//           SliverFillRemaining(
//             child: TabBarView(
//               controller: _tabController,
//               children: [
//                 _buildOverviewTab(),
//                 _buildPhotosTab(),
//                 _buildReviewsTab(),
//                 _buildBookTab(),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildAppBar() {
//     return SliverAppBar(
//       expandedHeight: 200,
//       pinned: true,
//       flexibleSpace: FlexibleSpaceBar(
//         title: Text(widget.place.name),
//         background: Image.network(
//           widget.place.imageUrl,
//           fit: BoxFit.cover,
//         ),
//       ),
//     );
//   }

//   Widget _buildOverviewTab() {
//     return ListView(
//       padding: const EdgeInsets.all(16),
//       children: [
//         const Text(
//           'About',
//           style: TextStyle(
//             fontSize: 20,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         const SizedBox(height: 12),
//         Text(widget.place.description),
//         const SizedBox(height: 24),
//         _buildInfoRow('Opening hours', widget.place.openingHours),
//         _buildInfoRow('Waiting time', widget.place.waitingTime),
//         _buildInfoRow('Type', widget.place.type),
//         _buildInfoRow('Capacity', widget.place.capacity),
//         _buildInfoRow('Good for', widget.place.goodFor.join(', ')),
//         const SizedBox(height: 24),
//         _buildAmenities(),
//         const SizedBox(height: 24),
//         _buildVRSection(),
//         const SizedBox(height: 24),
//         _buildParticipants(),
//       ],
//     );
//   }

//   Widget _buildInfoRow(String label, String value) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             label,
//             style: const TextStyle(
//               color: Colors.grey,
//             ),
//           ),
//           Text(
//             value,
//             style: const TextStyle(
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildAmenities() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           'Amenities',
//           style: TextStyle(
//             fontSize: 18,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         const SizedBox(height: 16),
//         Wrap(
//           spacing: 16,
//           runSpacing: 16,
//           children: widget.place.amenities.map((amenity) {
//             IconData icon;
//             switch (amenity.toLowerCase()) {
//               case 'coffee':
//                 icon = Icons.coffee;
//                 break;
//               case 'bike park':
//                 icon = Icons.pedal_bike;
//                 break;
//               case 'delivery':
//                 icon = Icons.delivery_dining;
//                 break;
//               default:
//                 icon = Icons.star;
//             }
//             return Column(
//               children: [
//                 Icon(icon),
//                 const SizedBox(height: 4),
//                 Text(amenity),
//               ],
//             );
//           }).toList(),
//         ),
//       ],
//     );
//   }

//   Widget _buildVRSection() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             const Text(
//               'VR',
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             Text(
//               '${widget.place.distance}km',
//               style: const TextStyle(color: Colors.grey),
//             ),
//           ],
//         ),
//         const SizedBox(height: 12),
//         ClipRRect(
//           borderRadius: BorderRadius.circular(12),
//           child: Image.network(
//             widget.place.imageUrl,
//             height: 200,
//             width: double.infinity,
//             fit: BoxFit.cover,
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildParticipants() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           'Travel participants',
//           style: TextStyle(
//             fontSize: 18,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         const SizedBox(height: 12),
//         SizedBox(
//           height: 60,
//           child: ListView.builder(
//             scrollDirection: Axis.horizontal,
//             itemCount: widget.place.participants.length,
//             itemBuilder: (context, index) {
//               final participant = widget.place.participants[index];
//               return Padding(
//                 padding: const EdgeInsets.only(right: 8),
//                 child: CircleAvatar(
//                   radius: 30,
//                   backgroundImage: NetworkImage(participant.avatar),
//                 ),
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildPhotosTab() {
//     return GridView.builder(
//       padding: const EdgeInsets.all(16),
//       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 3,
//         mainAxisSpacing: 8,
//         crossAxisSpacing: 8,
//       ),
//       itemCount: widget.place.photos.length,
//       itemBuilder: (context, index) {
//         return ClipRRect(
//           borderRadius: BorderRadius.circular(8),
//           child: Image.network(
//             widget.place.photos[index],
//             fit: BoxFit.cover,
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildReviewsTab() {
//     return ListView.builder(
//       padding: const EdgeInsets.all(16),
//       itemCount: widget.place.reviews.length,
//       itemBuilder: (context, index) {
//         final review = widget.place.reviews[index];
//         return Card(
//           margin: const EdgeInsets.only(bottom: 16),
//           child: Padding(
//             padding: const EdgeInsets.all(16),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   children: [
//                     CircleAvatar(
//                       backgroundImage: NetworkImage(review.authorAvatar),
//                     ),
//                     const SizedBox(width: 12),
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             review.authorName,
//                             style: const TextStyle(
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           Text(
//                             review.timePosted,
//                             style: const TextStyle(
//                               color: Colors.grey,
//                               fontSize: 12,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Container(
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 8,
//                         vertical: 4,
//                       ),
//                       decoration: BoxDecoration(
//                         color: Colors.green,
//                         borderRadius: BorderRadius.circular(4),
//                       ),
//                       child: Text(
//                         review.rating.toString(),
//                         style: const TextStyle(
//                           color: Colors.white,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 12),
//                 Text(review.content),
//                 if (review.images.isNotEmpty) ...[
//                   const SizedBox(height: 12),
//                   SizedBox(
//                     height: 80,
//                     child: ListView.builder(
//                       scrollDirection: Axis.horizontal,
//                       itemCount: review.images.length,
//                       itemBuilder: (context, index) {
//                         return Padding(
//                           padding: const EdgeInsets.only(right: 8),
//                           child: ClipRRect(
//                             borderRadius: BorderRadius.circular(8),
//                             child: Image.network(
//                               review.images[index],
//                               width: 80,
//                               height: 80,
//                               fit: BoxFit.cover,
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                 ],
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildBookTab() {
//     return ListView(
//       padding: const EdgeInsets.all(16),
//       children: [
//         _buildDateSection(),
//         const SizedBox(height: 24),
//         _buildGuestSection(),
//         const SizedBox(height: 24),
//         _buildAmenitiesSection(),
//         const SizedBox(height: 24),
//         _buildPricingSection(),
//         const SizedBox(height: 24),
//         ElevatedButton(
//           onPressed: () {
//             // Implement booking functionality
//           },
//           style: ElevatedButton.styleFrom(
//             backgroundColor: Colors.deepOrange,
//             padding: const EdgeInsets.symmetric(vertical: 16),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(8),
//             ),
//           ),
//           child: const Text(
//             'Book',
//             style: TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildDateSection() {
//     return Row(
//       children: [
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Text(
//                 'Check in',
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               const SizedBox(height: 8),
//               Container(
//                 padding: const EdgeInsets.all(12),
//                 decoration: BoxDecoration(
//                   border: Border.all(color: Colors.grey.shade300),
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: const Row(
//                   children: [
//                     Icon(Icons.calendar_today, size: 20),
//                     SizedBox(width: 8),
//                     Text('10 Jun 2023'),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//         const SizedBox(width: 16),
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Text(
//                 'Check out',
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               const SizedBox(height: 8),
//               Container(
//                 padding: const EdgeInsets.all(12),
//                 decoration: BoxDecoration(
//                   border: Border.all(color: Colors.grey.shade300),
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: const Row(
//                   children: [
//                     Icon(Icons.calendar_today, size: 20),
//                     SizedBox(width: 8),
//                     Text('10 Jun 2023'),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildGuestSection() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           'Guest',
//           style: TextStyle(
//             fontSize: 16,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         const SizedBox(height: 8),
//         Container(
//           padding: const EdgeInsets.all(12),
//           decoration: BoxDecoration(
//             border: Border.all(color: Colors.grey.shade300),
//             borderRadius: BorderRadius.circular(8),
//           ),
//           child: const Row(
//             children: [
//               Icon(Icons.person_outline, size: 20),
//               SizedBox(width: 8),
//               Text('1 Guest'),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildAmenitiesSection() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           'Amenities',
//           style: TextStyle(
//             fontSize: 16,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         const SizedBox(height: 16),
//         _buildAmenityItem('Car Park', 160, null),
//         _buildAmenityItem('Clean Shave', 80, cleanShaveCount),
//         _buildAmenityItem('Food', 80, foodCount),
//       ],
//     );
//   }

//   Widget _buildAmenityItem(String name, double price, int? count) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 12),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(name),
//           if (count != null)
//             Row(
//               children: [
//                 IconButton(
//                   icon: const Icon(Icons.remove),
//                   onPressed: () {
//                     setState(() {
//                       if (name == 'Clean Shave' && cleanShaveCount > 0) {
//                         cleanShaveCount--;
//                       } else if (name == 'Food' && foodCount > 0) {
//                         foodCount--;
//                       }
//                     });
//                   },
//                 ),
//                 Text('$count'),
//                 IconButton(
//                   icon: const Icon(Icons.add),
//                   onPressed: () {
//                     setState(() {
//                       if (name == 'Clean Shave') {
//                         cleanShaveCount++;
//                       } else if (name == 'Food') {
//                         foodCount++;
//                       }
//                     });
//                   },
//                 ),
//               ],
//             ),
//           Text('\$$price'),
//         ],
//       ),
//     );
//   }

//   Widget _buildPricingSection() {
//     final itemTotal = 160 + (80 * cleanShaveCount) + (80 * foodCount);
//     const couponDiscount = 10;
//     final amountPayable = itemTotal - couponDiscount;

//     return Column(
//       children: [
//         _buildPriceRow('Item total', itemTotal as double),
//         _buildPriceRow('Coupon Discount', (-couponDiscount) as double),
//         const SizedBox(height: 8),
//         _buildPriceRow('Amount Payable', amountPayable as double,
//             style: const TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//             )),
//       ],
//     );
//   }

//   Widget _buildPriceRow(String label, double amount,
//       {TextStyle style = const TextStyle()}) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 4),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(label, style: style),
//           Text(
//             '\$${amount.toStringAsFixed(2)}',
//             style: style,
//           ),
//         ],
//       ),
//     );
//   }
// }

// class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
//   final TabBar tabBar;

//   _SliverAppBarDelegate(this.tabBar);

//   @override
//   Widget build(
//       BuildContext context, double shrinkOffset, bool overlapsContent) {
//     return Container(
//       color: Theme.of(context).scaffoldBackgroundColor,
//       child: tabBar,
//     );
//   }

//   @override
//   double get maxExtent => tabBar.preferredSize.height;

//   @override
//   double get minExtent => tabBar.preferredSize.height;

//   @override
//   bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
//     return false;
//   }
// }

import 'package:flutter/material.dart';

class PlaceDetailPage extends StatefulWidget {
  final Map<String, dynamic> place;

  const PlaceDetailPage({
    Key? key,
    required this.place,
  }) : super(key: key);

  @override
  _PlaceDetailPageState createState() => _PlaceDetailPageState();
}

class _PlaceDetailPageState extends State<PlaceDetailPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int cleanShaveCount = 0;
  int foodCount = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _buildAppBar(),
          SliverPersistentHeader(
            delegate: _SliverAppBarDelegate(
              TabBar(
                controller: _tabController,
                labelColor: Theme.of(context).primaryColor,
                unselectedLabelColor: Colors.grey,
                indicatorColor: Theme.of(context).primaryColor,
                tabs: const [
                  Tab(text: 'Overview'),
                  Tab(text: 'Photo'),
                  Tab(text: 'Review'),
                  Tab(text: 'Community'),
                ],
              ),
            ),
            pinned: true,
          ),
          SliverFillRemaining(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildOverviewTab(),
                _buildPhotosTab(),
                _buildReviewsTab(),
                _buildBookTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar() {
    return SliverAppBar(
      expandedHeight: 200,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(widget.place['name'] ?? ''),
        background: Image.network(
          widget.place['imageUrl'] ?? '',
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildOverviewTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text(
          'About',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Text(widget.place['description'] ?? ''),
        const SizedBox(height: 24),
        _buildInfoRow('Opening hours', widget.place['openingHours'] ?? 'N/A'),
        _buildInfoRow('Waiting time', widget.place['waitingTime'] ?? 'N/A'),
        _buildInfoRow('Type', widget.place['category'] ?? 'N/A'),
        _buildInfoRow('Capacity', widget.place['capacity'] ?? 'N/A'),
        _buildInfoRow('Good for', (widget.place['goodFor'] as List<String>?)?.join(', ') ?? 'N/A'),
        const SizedBox(height: 24),
        _buildAmenities(),
        const SizedBox(height: 24),
        _buildVRSection(),
        const SizedBox(height: 24),
        _buildParticipants(),
      ],
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Colors.grey,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAmenities() {
    final amenities = widget.place['amenities'] as List<String>? ?? [];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Amenities',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 16,
          runSpacing: 16,
          children: amenities.map((amenity) {
            IconData icon;
            switch (amenity.toLowerCase()) {
              case 'coffee':
                icon = Icons.coffee;
                break;
              case 'bike park':
                icon = Icons.pedal_bike;
                break;
              case 'delivery':
                icon = Icons.delivery_dining;
                break;
              default:
                icon = Icons.star;
            }
            return Column(
              children: [
                Icon(icon),
                const SizedBox(height: 4),
                Text(amenity),
              ],
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildVRSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'VR',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '${widget.place['distance'] ?? 'N/A'}km',
              style: const TextStyle(color: Colors.grey),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.network(
            widget.place['imageUrl'] ?? '',
            height: 200,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }

  Widget _buildParticipants() {
    final participants = widget.place['participants'] as List<Map<String, dynamic>>? ?? [];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Travel participants',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 60,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: participants.length,
            itemBuilder: (context, index) {
              final participant = participants[index];
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(participant['avatar'] ?? ''),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildPhotosTab() {
    final photos = widget.place['photos'] as List<String>? ?? [];
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
      ),
      itemCount: photos.length,
      itemBuilder: (context, index) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            photos[index],
            fit: BoxFit.cover,
          ),
        );
      },
    );
  }

  Widget _buildReviewsTab() {
    final reviews = widget.place['reviews'] as List<Map<String, dynamic>>? ?? [];
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: reviews.length,
      itemBuilder: (context, index) {
        final review = reviews[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(review['authorAvatar'] ?? ''),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            review['authorName'] ?? '',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            review['timePosted'] ?? '',
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        (review['rating'] ?? 0).toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(review['content'] ?? ''),
                if ((review['images'] as List<String>?)?.isNotEmpty ?? false) ...[
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 80,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: (review['images'] as List<String>).length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              (review['images'] as List<String>)[index],
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildBookTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildDateSection(),
        const SizedBox(height: 24),
        _buildGuestSection(),
        const SizedBox(height: 24),
        _buildAmenitiesSection(),
        const SizedBox(height: 24),
        _buildPricingSection(),
        const SizedBox(height: 24),
        ElevatedButton(
          onPressed: () {
            // Implement booking functionality
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepOrange,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Text(
            'Book',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDateSection() {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Check in',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.calendar_today, size: 20),
                    SizedBox(width: 8),
                    Text('10 Jun 2023'),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Check out',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.calendar_today, size: 20),
                    SizedBox(width: 8),
                    Text('10 Jun 2023'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildGuestSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Guest',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Row(
            children: [
              Icon(Icons.person_outline, size: 20),
              SizedBox(width: 8),
              Text('1 Guest'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAmenitiesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Amenities',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        _buildAmenityItem('Car Park', 160, null),
        _buildAmenityItem('Clean Shave', 80, cleanShaveCount),
        _buildAmenityItem('Food', 80, foodCount),
      ],
    );
  }

  Widget _buildAmenityItem(String name, double price, int? count) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(name),
          if (count != null)
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: () {
                    setState(() {
                      if (name == 'Clean Shave' && cleanShaveCount > 0) {
                        cleanShaveCount--;
                      } else if (name == 'Food' && foodCount > 0) {
                        foodCount--;
                      }
                    });
                  },
                ),
                Text('$count'),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    setState(() {
                      if (name == 'Clean Shave') {
                        cleanShaveCount++;
                      } else if (name == 'Food') {
                        foodCount++;
                      }
                    });
                  },
                ),
              ],
            ),
          Text('\$$price'),
        ],
      ),
    );
  }

  Widget _buildPricingSection() {
    final itemTotal = 160 + (80 * cleanShaveCount) + (80 * foodCount);
    const couponDiscount = 10;
    final amountPayable = itemTotal - couponDiscount;

    return Column(
      children: [
        _buildPriceRow('Item total', itemTotal.toDouble()),
        _buildPriceRow('Coupon Discount', -couponDiscount.toDouble()),
        const SizedBox(height: 8),
        _buildPriceRow('Amount Payable', amountPayable.toDouble(),
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            )),
      ],
    );
  }

  Widget _buildPriceRow(String label, double amount,
      {TextStyle style = const TextStyle()}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: style),
          Text(
            '\$${amount.toStringAsFixed(2)}',
            style: style,
          ),
        ],
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar tabBar;

  _SliverAppBarDelegate(this.tabBar);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: tabBar,
    );
  }

  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  double get minExtent => tabBar.preferredSize.height;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}


import 'dart:math';
import 'package:flutter/material.dart';
import 'package:tour/features/ai_planner/presentation/pages/ai_planner_page.dart';
import 'package:tour/features/home/widget/explore.dart';
import 'package:tour/features/home/widget/trending.dart';
import 'package:tour/features/vr/page/vr_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  // List of URLs for random beautiful images
  final List<String> _imageUrls = [
    'https://picsum.photos/200/300?1',
    'https://picsum.photos/200/300?2',
    'https://picsum.photos/200/300?3',
  ];

  String _randomImageUrl = '';

  @override
  void initState() {
    super.initState();

    // Get a random image from the list when the page is loaded
    _randomImageUrl = _imageUrls[Random().nextInt(_imageUrls.length)];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Navigate to different pages based on the selected index
    switch (_selectedIndex) {
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const VrPage()),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AIPlannerPage()),
        );
        break;
      default:
        break;
    }
  }

  void _showComingSoon(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Coming soon!')),
    );
  }

  void _navigateToHotels(BuildContext context) {
    Navigator.pushNamed(context, '/businesses');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Section with random image
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage('https://picsum.photos/200/300?1'), // Display random image here
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
                      onPressed: () => Navigator.pushNamed(context, '/profile'),
                    ),
                    IconButton(
                      icon: const Icon(Icons.notifications_outlined),
                      onPressed: () => _showComingSoon(context),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              // Explore More Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Explore More',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Explore our carefully selected hotels, restaurants, attractions, and expert guides for an unforgettable experience.',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Colors.grey[600],
                          ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                height: 180,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: [
                    ExploreCard(
                      title: 'Hotels',
                      image: 'https://picsum.photos/200/300?2', //
                      onTap: () => _navigateToHotels(context),
                    ),
                    ExploreCard(
                      title: 'Restaurant',
                      image: 'https://picsum.photos/200/300?3',
                      onTap: () => _showComingSoon(context),
                    ),
                    ExploreCard(
                      title: 'Attraction',
                      image: 'https://picsum.photos/200/300?4',
                      onTap: () => _showComingSoon(context),
                    ),
                    ExploreCard(
                      title: 'Tour Guide',
                      image: 'https://picsum.photos/200/300?5',
                      onTap: () => _showComingSoon(context),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              // Trending Places Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Trending places',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Discover our thoughtfully curated selection of unique and unforgettable destinations.',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Colors.grey[600],
                          ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              GridView.builder(
                padding: const EdgeInsets.all(16),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.8,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: 6,
                itemBuilder: (context, index) {
                  return TrendingPlaceCard(
                    title: 'African Union',
                    image: _randomImageUrl,
                    rating: 4.7,
                    price: 1200,
                    onTap: () => _showComingSoon(context),
                  );
                },
              ),
              Center(
                child: TextButton(
                  onPressed: () => _showComingSoon(context),
                  child: const Text('See More'),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.vrpano),
            label: 'VR',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.smart_toy),
            label: 'AI Planner',
          ),
        ],
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        elevation: 8,
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:tourpal/features/home/presentation/places/pages/place_detail.dart';
// import 'package:tourpal/features/home/presentation/widgets/place_card.dart';

// class AllPlacesPage extends StatefulWidget {
//   const AllPlacesPage({Key? key}) : super(key: key);

//   @override
//   _AllPlacesPageState createState() => _AllPlacesPageState();
// }

// class _AllPlacesPageState extends State<AllPlacesPage> {
//   final TextEditingController _searchController = TextEditingController();
//   String _selectedFilter = 'All';
//   final List<String> _filters = ['All', 'Coffee', 'Breakfast', 'Museum', 'Sightseeing', 'Nature'];

//   final List<Map<String, dynamic>> _places = [
//     {
//       'id': '1',
//       'name': 'Eiffel Tower',
//       'location': 'Paris, France',
//       'rating': 4.7,
//       'price': 25,
//       'imageUrl': 'https://picsum.photos/200/300?1',
//       'category': 'Sightseeing',
//       'description': 'Iconic iron tower on the Champ de Mars',
//       'isFavorite': false,
//     },
//     {
//       'id': '2',
//       'name': 'Central Park',
//       'location': 'New York City, USA',
//       'rating': 4.5,
//       'price': 0,
//       'imageUrl': 'https://picsum.photos/200/300?2',
//       'category': 'Nature',
//       'description': 'Urban oasis in the heart of Manhattan',
//       'isFavorite': true,
//     },
//     {
//       'id': '3',
//       'name': 'Louvre Museum',
//       'location': 'Paris, France',
//       'rating': 4.8,
//       'price': 17,
//       'imageUrl': 'https://picsum.photos/200/300?3',
//       'category': 'Museum',
//       'description': 'World\'s largest art museum and historic monument',
//       'isFavorite': false,
//     },
//     {
//       'id': '4',
//       'name': 'Café de Flore',
//       'location': 'Paris, France',
//       'rating': 4.3,
//       'price': 15,
//       'imageUrl': 'https://picsum.photos/200/300?4',
//       'category': 'Coffee',
//       'description': 'Iconic Parisian café with a rich history',
//       'isFavorite': true,
//     },
//     {
//       'id': '5',
//       'name': 'Breakfast Club',
//       'location': 'London, UK',
//       'rating': 4.6,
//       'price': 20,
//       'imageUrl': 'https://picsum.photos/200/300?5',
//       'category': 'Breakfast',
//       'description': 'Popular breakfast spot with all-day breakfast menu',
//       'isFavorite': false,
//     },
//   ];

//   List<Map<String, dynamic>> get filteredPlaces {
//     return _places.where((place) {
//       final nameMatches = place['name'].toLowerCase().contains(_searchController.text.toLowerCase());
//       final filterMatches = _selectedFilter == 'All' || place['category'] == _selectedFilter;
//       return nameMatches && filterMatches;
//     }).toList();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('All Places'),
//         bottom: PreferredSize(
//           preferredSize: Size.fromHeight(60),
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//             child: TextField(
//               controller: _searchController,
//               decoration: InputDecoration(
//                 hintText: 'Search places...',
//                 prefixIcon: Icon(Icons.search),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(30),
//                 ),
//               ),
//               onChanged: (_) => setState(() {}),
//             ),
//           ),
//         ),
//       ),
//       body: Column(
//         children: [
//           SizedBox(
//             height: 50,
//             child: ListView.builder(
//               scrollDirection: Axis.horizontal,
//               itemCount: _filters.length,
//               itemBuilder: (context, index) {
//                 return Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 4.0),
//                   child: ChoiceChip(
//                     label: Text(_filters[index]),
//                     selected: _selectedFilter == _filters[index],
//                     onSelected: (selected) {
//                       if (selected) {
//                         setState(() {
//                           _selectedFilter = _filters[index];
//                         });
//                       }
//                     },
//                   ),
//                 );
//               },
//             ),
//           ),
//           Expanded(
//             child: GridView.builder(
//               padding: EdgeInsets.all(16),
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//                 childAspectRatio: 0.75,
//                 crossAxisSpacing: 16,
//                 mainAxisSpacing: 16,
//               ),
//               itemCount: filteredPlaces.length,
//               itemBuilder: (context, index) {
//                 final place = filteredPlaces[index];
//                 return PlaceCard(
//                   place: place,
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => PlaceDetailPage(place: place),
//                       ),
//                     );
//                   },
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }




// import 'package:flutter/material.dart';
// import 'package:tourpal/features/home/presentation/places/pages/place_detail.dart';
// import 'package:tourpal/features/home/presentation/widgets/place_card.dart';

// class AllPlacesPage extends StatefulWidget {
//   const AllPlacesPage({Key? key}) : super(key: key);

//   @override
//   _AllPlacesPageState createState() => _AllPlacesPageState();
// }

// class _AllPlacesPageState extends State<AllPlacesPage> {
//   final TextEditingController _searchController = TextEditingController();
//   String _selectedFilter = 'All';
//   final List<String> _filters = ['All', 'Historic Site', 'Monument', 'Hotel', 'Restaurant', 'Nature'];

//   final List<Map<String, dynamic>> _places = [
//     {
//       'id': '1',
//       'name': 'Eiffel Tower',
//       'location': 'Paris, France',
//       'rating': 4.7,
//       'price': 25,
//       'imageUrl': 'https://picsum.photos/200/300?1',
//       'category': 'Sightseeing',
//       'description': 'Iconic iron tower on the Champ de Mars',
//       'isFavorite': false,
//     },
//     {
//       'id': '2',
//       'name': 'Colosseum',
//       'location': 'Rome, Italy',
//       'rating': 4.5,
//       'price': 15,
//       'imageUrl': 'https://picsum.photos/200/300?2',
//       'category': 'Historic Site',
//       'description': 'Ancient amphitheater in the center of Rome',
//       'isFavorite': false,
//     },
//     {
//       'id': '3',
//       'name': 'Great Wall of China',
//       'location': 'China',
//       'rating': 4.9,
//       'price': 30,
//       'imageUrl': 'https://picsum.photos/200/300?3',
//       'category': 'Monument',
//       'description': 'One of the greatest wonders of the world',
//       'isFavorite': false,
//     },
//     {
//       'id': '4',
//       'name': 'Taj Mahal',
//       'location': 'Agra, India',
//       'rating': 4.8,
//       'price': 20,
//       'imageUrl': 'https://picsum.photos/200/300?4',
//       'category': 'Monument',
//       'description': 'A beautiful mausoleum made of white marble',
//       'isFavorite': false,
//     },
//     {
//       'id': '5',
//       'name': 'Machu Picchu',
//       'location': 'Peru',
//       'rating': 4.6,
//       'price': 40,
//       'imageUrl': 'https://picsum.photos/200/300?5',
//       'category': 'Nature',
//       'description': 'Inca citadel nestled high in the Andes Mountains',
//       'isFavorite': false,
//     },
//   ];


//   List<Map<String, dynamic>> get filteredPlaces {
//     return _places.where((place) {
//       final nameMatches = place['name'].toLowerCase().contains(_searchController.text.toLowerCase());
//       final descriptionMatches = place['description'].toLowerCase().contains(_searchController.text.toLowerCase());
//       final filterMatches = _selectedFilter == 'All' || place['category'] == _selectedFilter;
//       return (nameMatches || descriptionMatches) && filterMatches;
//     }).toList();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: CustomScrollView(
//         slivers: [
//           SliverAppBar(
//             floating: true,
//             pinned: true,
//             title: Text('Discover Places'),
//             bottom: PreferredSize(
//               preferredSize: Size.fromHeight(60),
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//                 child: TextField(
//                   controller: _searchController,
//                   decoration: InputDecoration(
//                     hintText: 'Search places...',
//                     prefixIcon: Icon(Icons.search),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(30),
//                     ),
//                     filled: true,
//                     fillColor: Colors.white,
//                   ),
//                   onChanged: (_) => setState(() {}),
//                 ),
//               ),
//             ),
//           ),
//           SliverToBoxAdapter(
//             child: SizedBox(
//               height: 50,
//               child: ListView.builder(
//                 scrollDirection: Axis.horizontal,
//                 itemCount: _filters.length,
//                 itemBuilder: (context, index) {
//                   return Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 4.0),
//                     child: ChoiceChip(
//                       label: Text(_filters[index]),
//                       selected: _selectedFilter == _filters[index],
//                       onSelected: (selected) {
//                         if (selected) {
//                           setState(() {
//                             _selectedFilter = _filters[index];
//                           });
//                         }
//                       },
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ),
//           SliverPadding(
//             padding: EdgeInsets.all(16),
//             sliver: SliverGrid(
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//                 childAspectRatio: 0.75,
//                 crossAxisSpacing: 16,
//                 mainAxisSpacing: 16,
//               ),
//               delegate: SliverChildBuilderDelegate(
//                 (BuildContext context, int index) {
//                   final place = filteredPlaces[index];
//                   return PlaceCard(
//                     name: place['name'],
//                     location: place['location'],
//                     rating: place['rating'],
//                     price: place['price'],
//                     imageUrl: place['imageUrl'],
//                     category: place['category'],
//                     isFavorite: place['isFavorite'],
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => PlaceDetailPage(place: place),
//                         ),
//                       );
//                     },
//                   );
//                 },
//                 childCount: filteredPlaces.length,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:tourpal/features/home/presentation/places/pages/place_detail.dart';
import 'package:tourpal/features/home/presentation/widgets/place_card.dart';

class AllPlacesPage extends StatefulWidget {
  const AllPlacesPage({Key? key}) : super(key: key);

  @override
  _AllPlacesPageState createState() => _AllPlacesPageState();
}

class _AllPlacesPageState extends State<AllPlacesPage> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedFilter = 'All';
  final List<String> _filters = ['All', 'Historic Site', 'Monument', 'Hotel', 'Restaurant', 'Nature'];

  final List<Map<String, dynamic>> _places = [
    {
      'id': '1',
      'name': 'Eiffel Tower',
      'location': 'Paris, France',
      'rating': 4.7,
      'price': 25,
      'imageUrl': 'https://picsum.photos/200/300?1',
      'category': 'Monument',
      'description': 'Iconic iron tower on the Champ de Mars',
      'isFavorite': false,
      'openingHours': '09:00 - 00:45',
      'waitingTime': '30-60 minutes',
      'capacity': '10,000 visitors per day',
      'goodFor': ['Sightseeing', 'Photography', 'Romantic dates'],
      'amenities': ['Elevator', 'Restaurant', 'Gift shop'],
      'distance': 2.5,
      'photos': [
        'https://picsum.photos/200/300?11',
        'https://picsum.photos/200/300?12',
        'https://picsum.photos/200/300?13',
      ],
      'reviews': [
        {
          'authorName': 'John Doe',
          'authorAvatar': 'https://i.pravatar.cc/150?img=1',
          'rating': 5.0,
          'content': 'Amazing view of Paris!',
          'timePosted': '2 days ago',
          'images': ['https://picsum.photos/200/300?21'],
        },
      ],
      'participants': [
        {'name': 'Alice', 'avatar': 'https://i.pravatar.cc/150?img=5'},
        {'name': 'Bob', 'avatar': 'https://i.pravatar.cc/150?img=6'},
      ],
    },
    {
      'id': '2',
      'name': 'Colosseum',
      'location': 'Rome, Italy',
      'rating': 4.5,
      'price': 15,
      'imageUrl': 'https://picsum.photos/200/300?2',
      'category': 'Historic Site',
      'description': 'Ancient amphitheater in the center of Rome',
      'isFavorite': false,
      'openingHours': '08:30 - 19:00',
      'waitingTime': '15-45 minutes',
      'capacity': '3,000 visitors at a time',
      'goodFor': ['History buffs', 'Architecture enthusiasts'],
      'amenities': ['Guided tours', 'Information center'],
      'distance': 1.8,
      'photos': [
        'https://picsum.photos/200/300?14',
        'https://picsum.photos/200/300?15',
      ],
      'reviews': [
        {
          'authorName': 'Jane Smith',
          'authorAvatar': 'https://i.pravatar.cc/150?img=2',
          'rating': 4.5,
          'content': 'Breathtaking historical site!',
          'timePosted': '1 week ago',
          'images': [],
        },
      ],
      'participants': [
        {'name': 'Charlie', 'avatar': 'https://i.pravatar.cc/150?img=7'},
      ],
    },
    {
      'id': '3',
      'name': 'Great Wall of China',
      'location': 'China',
      'rating': 4.9,
      'price': 30,
      'imageUrl': 'https://picsum.photos/200/300?3',
      'category': 'Monument',
      'description': 'One of the greatest wonders of the world',
      'isFavorite': false,
      'openingHours': '07:00 - 18:00',
      'waitingTime': '10-30 minutes',
      'capacity': 'Varies by section',
      'goodFor': ['Hiking', 'Photography', 'History'],
      'amenities': ['Cable car', 'Souvenir shops'],
      'distance': 50.0,
      'photos': [
        'https://picsum.photos/200/300?16',
        'https://picsum.photos/200/300?17',
      ],
      'reviews': [
        {
          'authorName': 'Mike Johnson',
          'authorAvatar': 'https://i.pravatar.cc/150?img=3',
          'rating': 5.0,
          'content': 'Unforgettable experience!',
          'timePosted': '3 days ago',
          'images': ['https://picsum.photos/200/300?22'],
        },
      ],
      'participants': [
        {'name': 'David', 'avatar': 'https://i.pravatar.cc/150?img=8'},
        {'name': 'Emma', 'avatar': 'https://i.pravatar.cc/150?img=9'},
      ],
    },
    {
      'id': '4',
      'name': 'Taj Mahal',
      'location': 'Agra, India',
      'rating': 4.8,
      'price': 20,
      'imageUrl': 'https://picsum.photos/200/300?4',
      'category': 'Monument',
      'description': 'A beautiful mausoleum made of white marble',
      'isFavorite': false,
      'openingHours': 'Sunrise to sunset (Closed on Fridays)',
      'waitingTime': '20-40 minutes',
      'capacity': '40,000 visitors per day',
      'goodFor': ['Architecture', 'History', 'Romance'],
      'amenities': ['Guided tours', 'Gardens'],
      'distance': 3.5,
      'photos': [
        'https://picsum.photos/200/300?18',
        'https://picsum.photos/200/300?19',
      ],
      'reviews': [
        {
          'authorName': 'Sarah Lee',
          'authorAvatar': 'https://i.pravatar.cc/150?img=4',
          'rating': 4.8,
          'content': 'A true wonder of the world!',
          'timePosted': '5 days ago',
          'images': ['https://picsum.photos/200/300?23'],
        },
      ],
      'participants': [
        {'name': 'Frank', 'avatar': 'https://i.pravatar.cc/150?img=10'},
      ],
    },
    {
      'id': '5',
      'name': 'Machu Picchu',
      'location': 'Peru',
      'rating': 4.6,
      'price': 40,
      'imageUrl': 'https://picsum.photos/200/300?5',
      'category': 'Historic Site',
      'description': 'Inca citadel nestled high in the Andes Mountains',
      'isFavorite': false,
      'openingHours': '06:00 - 17:30',
      'waitingTime': '30-60 minutes',
      'capacity': '2,500 visitors per day',
      'goodFor': ['Hiking', 'Archaeology', 'Nature'],
      'amenities': ['Guided tours', 'Train access'],
      'distance': 75.0,
      'photos': [
        'https://picsum.photos/200/300?20',
        'https://picsum.photos/200/300?24',
      ],
      'reviews': [
        {
          'authorName': 'Tom Wilson',
          'authorAvatar': 'https://i.pravatar.cc/150?img=5',
          'rating': 4.7,
          'content': 'Breathtaking views and rich history!',
          'timePosted': '1 week ago',
          'images': ['https://picsum.photos/200/300?25'],
        },
      ],
      'participants': [
        {'name': 'Grace', 'avatar': 'https://i.pravatar.cc/150?img=11'},
        {'name': 'Henry', 'avatar': 'https://i.pravatar.cc/150?img=12'},
      ],
    },
  ];

  List<Map<String, dynamic>> get filteredPlaces {
    return _places.where((place) {
      final nameMatches = place['name'].toLowerCase().contains(_searchController.text.toLowerCase());
      final descriptionMatches = place['description'].toLowerCase().contains(_searchController.text.toLowerCase());
      final filterMatches = _selectedFilter == 'All' || place['category'] == _selectedFilter;
      return (nameMatches || descriptionMatches) && filterMatches;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            pinned: true,
            title: Text('Discover Places'),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(60),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search places...',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  onChanged: (_) => setState(() {}),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _filters.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: ChoiceChip(
                      label: Text(_filters[index]),
                      selected: _selectedFilter == _filters[index],
                      onSelected: (selected) {
                        if (selected) {
                          setState(() {
                            _selectedFilter = _filters[index];
                          });
                        }
                      },
                    ),
                  );
                },
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.all(16),
            sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  final place = filteredPlaces[index];
                  return PlaceCard(
                    name: place['name'],
                    location: place['location'],
                    rating: place['rating'],
                    price: place['price'],
                    imageUrl: place['imageUrl'],
                    category: place['category'],
                    isFavorite: place['isFavorite'],
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PlaceDetailPage(place: place),
                        ),
                      );
                    },
                  );
                },
                childCount: filteredPlaces.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}


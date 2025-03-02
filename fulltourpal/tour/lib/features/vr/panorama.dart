// import 'package:flutter/material.dart';
// import 'package:tour/features/home/widget/explore.dart';
// import 'package:tour/features/home/widget/trending.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Tour App',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       home: const MainScreen(),
//       routes: {
//         '/businesses': (context) => const BusinessesPage(),
//         '/profile': (context) => const ProfilePage(),
//       },
//     );
//   }
// }

// class MainScreen extends StatefulWidget {
//   const MainScreen({super.key});

//   @override
//   State<MainScreen> createState() => _MainScreenState();
// }

// class _MainScreenState extends State<MainScreen> {
//   int _currentIndex = 0;

//   final List<Widget> _pages = [
//     const HomeContent(),
//     const VRPage(),
//     const AIPlannerPage(),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _pages[_currentIndex],
//       bottomNavigationBar: _buildFancyNavBar(),
//     );
//   }

//   Widget _buildFancyNavBar() {
//     return Container(
//       height: 80,
//       decoration: BoxDecoration(
//         gradient: const LinearGradient(
//           colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
//           begin: Alignment.centerLeft,
//           end: Alignment.centerRight,
//         ),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.2),
//             blurRadius: 10,
//             spreadRadius: 2,
//           ),
//         ],
//         borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
//       child: ClipRRect(
//         borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
//         child: NavigationBar(
//           height: 80,
//           backgroundColor: Colors.transparent,
//           labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
//           selectedIndex: _currentIndex,
//           onDestinationSelected: (index) => setState(() => _currentIndex = index),
//           destinations: [
//             _NavItem(icon: Icons.home, label: 'Home', isSelected: _currentIndex == 0),
//             _NavItem(icon: Icons.vr_handheld, label: 'VR', isSelected: _currentIndex == 1),
//             _NavItem(icon: Icons.auto_awesome, label: 'Planner', isSelected: _currentIndex == 2),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class _NavItem extends StatelessWidget {
//   final IconData icon;
//   final String label;
//   final bool isSelected;

//   const _NavItem({
//     required this.icon,
//     required this.label,
//     required this.isSelected,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedContainer(
//       duration: const Duration(milliseconds: 300),
//       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//       decoration: BoxDecoration(
//         color: isSelected ? Colors.white.withOpacity(0.2) : Colors.transparent,
//         borderRadius: BorderRadius.circular(20),
//       ),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Icon(icon, color: Colors.white, size: 28),
//           if (isSelected)
//             Text(
//               label,
//               style: const TextStyle(
//                 color: Colors.white,
//                 fontSize: 12,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }

// class HomeContent extends StatelessWidget {
//   const HomeContent({super.key});

//   void _showComingSoon(BuildContext context) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text('Coming soon!')),
//     );
//   }

//   void _navigateToHotels(BuildContext context) {
//     Navigator.pushNamed(context, '/businesses');
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // ... Rest of your original HomePage content here ...
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Row(
//                 children: [
//                   const CircleAvatar(
//                     backgroundImage: AssetImage('lib/asset/image.avif'),
//                   ),
//                   const SizedBox(width: 12),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Hello,',
//                         style: Theme.of(context).textTheme.bodyLarge,
//                       ),
//                       Text(
//                         'Daniel',
//                         style: Theme.of(context).textTheme.titleLarge,
//                       ),
//                     ],
//                   ),
//                   const Spacer(),
//                   IconButton(
//                     icon: const Icon(Icons.person_outline),
//                     onPressed: () => Navigator.pushNamed(context, '/profile'),
//                   ),
//                   IconButton(
//                     icon: const Icon(Icons.notifications_outlined),
//                     onPressed: () => _showComingSoon(context),
//                   ),
//                 ],
//               ),
//             ),
//             //
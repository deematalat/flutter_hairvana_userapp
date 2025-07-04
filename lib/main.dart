import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import ' features/booking/presentation/providers/app_state.dart';
import ' features/home/presentation/screens/home_screen.dart';
import ' features/splesh/presentation/controllers/app_flow_controller.dart';
import 'core/di/service_locator.dart';
import ' features/ar/presentation/screens/ar_screen.dart';
import ' features/gallery/presentation/screens/gallery_screen.dart';
import ' features/salon/presentation/screens/salon_finder_screen.dart';
import ' features/chat/presentation/screens/chat_screen.dart';
import ' features/home/presentation/widgets/bottom_nav_bar.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupServiceLocator();
  runApp( MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => AppState()),
    ],
    child: const HairvanaApp(),
  ),);
}

class HairvanaApp extends StatelessWidget {
  const HairvanaApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hairvana',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        scaffoldBackgroundColor: Colors.grey[50],
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const AppFlowController(),
      debugShowCheckedModeBanner: false,
    );
  }
}



class MainNavigation extends StatefulWidget {
  final int initialIndex;
  const MainNavigation({Key? key, this.initialIndex = 0}) : super(key: key);

  static void navigateToTab(BuildContext context, int tabIndex) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => MainNavigation(initialIndex: tabIndex)),
          (route) => false,
    );
  }

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  late int _selectedIndex;
  final List<Widget> _screens = [
    const HomeScreen(),
    const ARScreen(),
    const GalleryScreen(),
    SalonFinderScreen(),
    const ChatScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

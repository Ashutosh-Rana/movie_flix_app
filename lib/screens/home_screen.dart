import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:movie_flix_app/screens/currently_playing_screen.dart';
import 'package:movie_flix_app/screens/top_rated_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  PageController pageController=PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        onPageChanged: (index) {
          setState(() {
            _tabController.index = index;
          });
        },
        children: [
          CurrentlyPlayingTab(),
          TopRatedTab(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items:const [
          BottomNavigationBarItem(
            icon: Icon(Icons.play_arrow),
            label: 'Currently Playing',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Top Rated',
          ),
        ],
        currentIndex: _tabController.index,
        onTap: (index) {
          setState(() {
            _tabController.index=index;
          });
          pageController.jumpToPage(index);
          // _tabController.animateTo(index);
        },
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}
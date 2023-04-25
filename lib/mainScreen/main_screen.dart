import 'package:driver/tabPages/earning_tab.dart';
import 'package:driver/tabPages/home_tab.dart';
import 'package:driver/tabPages/profile_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/material/tabs.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  TabController? tabController;
  int selectedIndex = 0;

  inItemClicked(int index) {
    setState(() {
      selectedIndex = index;
      tabController!.index = selectedIndex;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: tabController,
        children: const [HomeTabPage(), EarnigsTabPage(), ProfileTabPage()],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              label: "Accueil"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.credit_card,
              ),
              label: "Revenus"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
              ),
              label: "Profil"),
        ],
        unselectedItemColor: Colors.white54,
        selectedItemColor: Colors.white,
        backgroundColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: const TextStyle(fontSize: 14),
        showUnselectedLabels: true,
        currentIndex: selectedIndex,
        onTap: inItemClicked,
      ),
    );
  }
}

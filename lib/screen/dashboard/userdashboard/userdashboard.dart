import 'package:flutter/material.dart';
import 'package:we_exchange/constants/constants.dart';
import 'package:we_exchange/screen/dashboard/admindashboard/tabs/activities.dart';
import 'package:we_exchange/screen/dashboard/userdashboard/tabs/deposit.dart';
import 'package:we_exchange/screen/dashboard/userdashboard/tabs/home.dart';
import 'package:we_exchange/screen/dashboard/userdashboard/tabs/settings.dart';
import 'package:we_exchange/screen/dashboard/userdashboard/tabs/withdraw.dart';

class UserDashboard extends StatefulWidget {
  static String id = 'users dashboard';
  const UserDashboard({Key? key}) : super(key: key);

  @override
  _UserDashboardState createState() => _UserDashboardState();
}

class _UserDashboardState extends State<UserDashboard> {
  int selectedIndex = 0;
  final List<Widget> _widgetoption = [
    const Home(),
    const Deposit(),
    const Withdraw(),
    const AdminActivities(),
    const Setting()
  ];

  void _onItemTap(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: kContentDarkTheme,
        showUnselectedLabels: true,
        fixedColor: kPrimaryColor,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.arrow_circle_up),
            label: "Deposit",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.arrow_circle_down),
            label: "Withdraw",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.access_time),
            label: "Activities",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Setting",
          ),
        ],
        currentIndex: selectedIndex,
        onTap: _onItemTap,
      ),
      body: _widgetoption.elementAt(selectedIndex),
    );
  }
}
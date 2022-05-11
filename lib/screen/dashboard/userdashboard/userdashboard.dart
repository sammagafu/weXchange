import 'package:flutter/material.dart';
import 'package:we_exchange/constants/constants.dart';
import 'package:we_exchange/generated/l10n.dart';
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
    const AdminDashboard(),
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
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: S.of(context).home,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.arrow_circle_up),
            label: S.of(context).deposit,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.arrow_circle_down),
            label: S.of(context).withdraw,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.access_time),
            label: S.of(context).activities,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.settings),
            label: S.of(context).settings,
          ),
        ],
        currentIndex: selectedIndex,
        onTap: _onItemTap,
      ),
      body: _widgetoption.elementAt(selectedIndex),
    );
  }
}
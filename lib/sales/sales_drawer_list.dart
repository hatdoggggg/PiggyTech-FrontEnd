import 'package:flutter/material.dart';

import 'sales_sidebar/pos.dart';
import 'sales_sidebar/sales_dashboard.dart';
import 'sales_sidebar/history.dart';
import 'sales_sidebar/sales_profile.dart';
import 'sales_drawer_header.dart';

import '/login_screen.dart';

enum DrawerSections {
  dashboard,
  pos,
  history,
  profile,
  logout,
}

class SalesDrawerList extends StatefulWidget {
  @override
  _SalesDrawerListState createState() => _SalesDrawerListState();
}

class _SalesDrawerListState extends State<SalesDrawerList> {
  var currentPage = DrawerSections.dashboard;

  // Map to store titles for each section
  final Map<DrawerSections, String> sectionTitles = {
    DrawerSections.dashboard: "Dashboard",
    DrawerSections.pos: "Pos",
    DrawerSections.history: "History",
    DrawerSections.profile: "Profile",
    DrawerSections.logout: "Logout",
  };

  @override
  Widget build(BuildContext context) {
    Widget container;
    switch (currentPage) {
      case DrawerSections.dashboard:
        container = SalesDashboardPage();
        break;
      case DrawerSections.pos:
        container = PosPage();
        break;
      case DrawerSections.history:
        container = HistoryPage();
        break;
      case DrawerSections.profile:
        container = SalesProfilePage();
        break;
      case DrawerSections.logout:
        container = LoginScreen();
        break;
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        title: Text(
          sectionTitles[currentPage] ?? "PiggyTech", // Default to "PiggyTech" if not found
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: container,
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height, // Ensure full screen height
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    SalesDrawerHeader(),
                    MyDrawerList(),
                  ],
                ),
                Footer(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget MyDrawerList() {
    return Container(
      padding: EdgeInsets.only(
        top: 15,
      ),
      child: Column(
        children: [
          menuItem(1, "Dashboard", Icons.dashboard_outlined,
              currentPage == DrawerSections.dashboard),
          Divider(),
          menuItem(2, "Pos", Icons.countertops_outlined,
              currentPage == DrawerSections.pos),
          Divider(),
          menuItem(3, "History", Icons.countertops_outlined,
              currentPage == DrawerSections.history),
          Divider(),
          menuItem(4, "Profile", Icons.perm_identity_outlined,
              currentPage == DrawerSections.profile),
          Divider(),
          menuItem(5, "Logout", Icons.logout,
              currentPage == DrawerSections.logout),
        ],
      ),
    );
  }

  Widget menuItem(int id, String title, IconData icon, bool selected) {
    return Material(
      color: selected ? Colors.grey[300] : Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
          if (id == 5) {
            _showLogoutDialog();
          } else {
            setState(() {
              switch (id) {
                case 1:
                  currentPage = DrawerSections.dashboard;
                  break;
                case 2:
                  currentPage = DrawerSections.pos;
                  break;
                case 3:
                  currentPage = DrawerSections.history;
                  break;
                case 4:
                  currentPage = DrawerSections.profile;
                  break;
              }
            });
          }
        },
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Row(
            children: [
              Expanded(
                child: Icon(
                  icon,
                  size: 20,
                  color: Colors.black,
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  title,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text("Are you sure you want to logout?"),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            },
            child: Text("Log Out"),
          ),
        ],
      ),
    );
  }

  Widget Footer() {
    return Container(
      padding: EdgeInsets.all(15.0),
      color: Colors.grey,
      height: 60,
      width: double.infinity,
      child: Text(
        "Cashier",
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
    );
  }
}

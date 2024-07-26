import 'package:flutter/material.dart';

import '/services/user_all.dart';
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
  final DrawerSections initialPage;
  final User_all userAll;

  SalesDrawerList({required this.userAll, this.initialPage = DrawerSections.dashboard}); // Make sure to accept initialPage

  @override
  _SalesDrawerListState createState() => _SalesDrawerListState();
}

class _SalesDrawerListState extends State<SalesDrawerList> {
  late DrawerSections currentPage; // Use late keyword to initialize later

  final Map<DrawerSections, String> sectionTitles = {
    DrawerSections.dashboard: "Dashboard",
    DrawerSections.pos: "POS",
    DrawerSections.history: "History",
    DrawerSections.profile: "Profile",
    DrawerSections.logout: "Logout",
  };

  @override
  void initState() {
    super.initState();
    currentPage = widget.initialPage; // Set the initial page
  }

  @override
  Widget build(BuildContext context) {
    Widget container;
    switch (currentPage) {
      case DrawerSections.dashboard:
        container = SalesDashboardPage(userAll: widget.userAll);
        break;
      case DrawerSections.pos:
        container = PosPage(userAll: widget.userAll);
        break;
      case DrawerSections.history:
        container = HistoryPage(userAll: widget.userAll);
        break;
      case DrawerSections.profile:
        container = SalesProfilePage(userAll: widget.userAll);
        break;
      case DrawerSections.logout:
        container = LoginScreen();
        break;
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        title: Text(
          sectionTitles[currentPage] ?? "PiggyTech",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: container,
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    SalesDrawerHeader(userAll: widget.userAll),
                    _buildDrawerList(),
                  ],
                ),
                _buildFooter(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDrawerList() {
    return Container(
      padding: EdgeInsets.only(top: 15),
      child: Column(
        children: [
          _buildMenuItem(DrawerSections.dashboard, "Dashboard", Icons.dashboard_outlined),
          Divider(),
          _buildMenuItem(DrawerSections.pos, "POS", Icons.countertops_outlined),
          Divider(),
          _buildMenuItem(DrawerSections.history, "History", Icons.history_outlined),
          Divider(),
          _buildMenuItem(DrawerSections.profile, "Profile", Icons.perm_identity_outlined),
          Divider(),
          _buildMenuItem(DrawerSections.logout, "Logout", Icons.logout),
        ],
      ),
    );
  }

  Widget _buildMenuItem(DrawerSections section, String title, IconData icon) {
    final bool isSelected = currentPage == section;
    return Material(
      color: isSelected ? Colors.grey[300] : Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
          if (section == DrawerSections.logout) {
            _showLogoutDialog();
          } else {
            setState(() {
              currentPage = section;
            });
          }
        },
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Row(
            children: [
              Icon(
                icon,
                size: 20,
                color: Colors.black,
              ),
              SizedBox(width: 15),
              Text(
                title,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
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
              Navigator.of(context).pop(); // Close the dialog
            },
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
              _logout();
            },
            child: Text("Log Out"),
          ),
        ],
      ),
    );
  }

  void _logout() {
    // Perform any necessary cleanup actions
    widget.userAll.clear(); // Ensure the clear method is working

    // Navigate to the login screen and remove all previous routes
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
          (route) => false,
    );
  }

  Widget _buildFooter() {
    return Container(
      padding: EdgeInsets.all(15.0),
      color: Colors.grey,
      height: 60,
      width: double.infinity,
      child: Center(
        child: Text(
          "Cashier",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}

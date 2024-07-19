import 'package:flutter/material.dart';

import 'admin_sidebar/admin_dashboard.dart';
import 'admin_sidebar/admin_product.dart';
import 'admin_sidebar/admin_inventory.dart';
import 'admin_sidebar/admin_sales.dart';
import 'admin_sidebar/admin_reports.dart';
import 'admin_sidebar/admin_users.dart';
import 'admin_sidebar/admin_profile.dart';
import 'admin_drawer_header.dart';
import '/login_screen.dart';

enum DrawerSections {
  dashboard,
  product,
  inventory,
  sales,
  reports,
  users,
  profile,
  logout,
}

class AdminDrawerList extends StatefulWidget {
  final DrawerSections initialPage;

  AdminDrawerList({this.initialPage = DrawerSections.dashboard});

  @override
  _AdminDrawerListState createState() => _AdminDrawerListState();
}

class _AdminDrawerListState extends State<AdminDrawerList> {
  late DrawerSections currentPage;

  // Map to store titles for each section
  final Map<DrawerSections, String> sectionTitles = {
    DrawerSections.dashboard: "Dashboard",
    DrawerSections.product: "Product",
    DrawerSections.inventory: "Inventory",
    DrawerSections.sales: "Sales",
    DrawerSections.reports: "Reports",
    DrawerSections.users: "Users",
    DrawerSections.profile: "Profile",
    DrawerSections.logout: "Logout",
  };

  @override
  void initState() {
    super.initState();
    currentPage = widget.initialPage;
  }

  @override
  Widget build(BuildContext context) {
    Widget container;
    switch (currentPage) {
      case DrawerSections.dashboard:
        container = AdminDashboardPage();
        break;
      case DrawerSections.product:
        container = AdminProductPage();
        break;
      case DrawerSections.inventory:
        container = AdminInventoryPage();
        break;
      case DrawerSections.sales:
        container = AdminSalesPage();
        break;
      case DrawerSections.reports:
        container = AdminReportsPage();
        break;
      case DrawerSections.users:
        container = AdminUsersPage();
        break;
      case DrawerSections.profile:
        container = AdminProfilePage();
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
                    AdminDrawerHeader(),
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
      padding: EdgeInsets.only(top: 15),
      child: Column(
        children: [
          menuItem(1, "Dashboard", Icons.dashboard_outlined, currentPage == DrawerSections.dashboard),
          Divider(),
          menuItem(2, "Product", Icons.shopping_cart_outlined, currentPage == DrawerSections.product),
          menuItem(3, "Inventory", Icons.inventory_outlined, currentPage == DrawerSections.inventory),
          Divider(),
          menuItem(4, "Sales", Icons.monetization_on_outlined, currentPage == DrawerSections.sales),
          menuItem(5, "Reports", Icons.report_outlined, currentPage == DrawerSections.reports),
          Divider(),
          menuItem(6, "Users", Icons.people_alt_outlined, currentPage == DrawerSections.users),
          menuItem(7, "Profile", Icons.perm_identity_outlined, currentPage == DrawerSections.profile),
          Divider(),
          menuItem(8, "Logout", Icons.logout, currentPage == DrawerSections.logout),
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
          if (id == 8) {
            _showLogoutDialog();
          } else {
            setState(() {
              switch (id) {
                case 1:
                  currentPage = DrawerSections.dashboard;
                  break;
                case 2:
                  currentPage = DrawerSections.product;
                  break;
                case 3:
                  currentPage = DrawerSections.inventory;
                  break;
                case 4:
                  currentPage = DrawerSections.sales;
                  break;
                case 5:
                  currentPage = DrawerSections.reports;
                  break;
                case 6:
                  currentPage = DrawerSections.users;
                  break;
                case 7:
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
        "Admin",
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

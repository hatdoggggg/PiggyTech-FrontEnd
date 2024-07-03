import 'package:flutter/material.dart';

import 'admin_sidebar/admin_dashboard.dart';
import 'admin_sidebar/admin_category.dart';
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
  category,
  product,
  inventory,
  sales,
  reports,
  users,
  profile,
  logout,
}

class AdminDrawerList extends StatefulWidget {
  @override
  _AdminDrawerListState createState() => _AdminDrawerListState();
}

class _AdminDrawerListState extends State<AdminDrawerList> {
  var currentPage = DrawerSections.dashboard;

  @override
  Widget build(BuildContext context) {
    Widget container;
    switch (currentPage) {
      case DrawerSections.dashboard:
        container = AdminDashboardPage();
        break;
      case DrawerSections.category:
        container = AdminCategoryPage();
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
        backgroundColor: Colors.blue[700],
        title: Text(
          "PiggyTech",
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
      padding: EdgeInsets.only(
        top: 15,
      ),
      child: Column(
        children: [
          menuItem(1, "Dashboard", Icons.dashboard_outlined,
              currentPage == DrawerSections.dashboard),
          Divider(),
          menuItem(2, "Category", Icons.category_outlined,
              currentPage == DrawerSections.category),
          menuItem(3, "Product", Icons.shopping_cart_outlined,
              currentPage == DrawerSections.product),
          menuItem(4, "Inventory", Icons.inventory_outlined,
              currentPage == DrawerSections.inventory),
          Divider(),
          menuItem(5, "Sales", Icons.monetization_on_outlined,
              currentPage == DrawerSections.sales),
          menuItem(6, "Reports", Icons.report_outlined,
              currentPage == DrawerSections.reports),
          Divider(),
          menuItem(7, "Users", Icons.people_alt_outlined,
              currentPage == DrawerSections.users),
          menuItem(8, "Profile", Icons.perm_identity_outlined,
              currentPage == DrawerSections.profile),
          Divider(),
          menuItem(9, "Logout", Icons.logout,
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
          if (id == 9) {
            _showLogoutDialog();
          } else {
            setState(() {
              switch (id) {
                case 1:
                  currentPage = DrawerSections.dashboard;
                  break;
                case 2:
                  currentPage = DrawerSections.category;
                  break;
                case 3:
                  currentPage = DrawerSections.product;
                  break;
                case 4:
                  currentPage = DrawerSections.inventory;
                  break;
                case 5:
                  currentPage = DrawerSections.sales;
                  break;
                case 6:
                  currentPage = DrawerSections.reports;
                  break;
                case 7:
                  currentPage = DrawerSections.users;
                  break;
                case 8:
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

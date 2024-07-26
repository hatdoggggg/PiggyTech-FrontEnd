import 'package:flutter/material.dart';
import '/services/user_all.dart';
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
  final User_all userAll;

  AdminDrawerList({required this.userAll, this.initialPage = DrawerSections.dashboard});

  @override
  _AdminDrawerListState createState() => _AdminDrawerListState();
}

class _AdminDrawerListState extends State<AdminDrawerList> {
  late DrawerSections currentPage;

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
        container = AdminDashboardPage(userAll: widget.userAll);
        break;
      case DrawerSections.product:
        container = AdminProductPage(userAll: widget.userAll);
        break;
      case DrawerSections.inventory:
        container = AdminInventoryPage(userAll: widget.userAll);
        break;
      case DrawerSections.sales:
        container = AdminSalesPage();
        break;
      case DrawerSections.reports:
        container = AdminReportsPage();
        break;
      case DrawerSections.users:
        container = AdminUsersPage(userAll: widget.userAll);
        break;
      case DrawerSections.profile:
        container = AdminProfilePage(userAll: widget.userAll);
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AdminDrawerHeader(userAll: widget.userAll),
              _buildDrawerList(),
              SizedBox(height: 105),
              _buildFooter(),
            ],
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
          _buildMenuDivider(),
          _buildMenuItem(DrawerSections.product, "Product", Icons.shopping_cart_outlined),
          _buildMenuItem(DrawerSections.inventory, "Inventory", Icons.inventory_outlined),
          _buildMenuDivider(),
          _buildMenuItem(DrawerSections.sales, "Sales", Icons.monetization_on_outlined),
          _buildMenuItem(DrawerSections.reports, "Reports", Icons.report_outlined),
          _buildMenuDivider(),
          _buildMenuItem(DrawerSections.users, "Users", Icons.people_alt_outlined),
          _buildMenuItem(DrawerSections.profile, "Profile", Icons.perm_identity_outlined),
          _buildMenuDivider(),
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
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              Icon(icon, size: 20, color: Colors.black),
              SizedBox(width: 20),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuDivider() {
    return Divider(
      color: Colors.grey,
      thickness: 1,
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Logout'),
        content: Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              _logout();
            },
            child: Text('Logout'),
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
          "Admin",
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

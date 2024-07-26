import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '/admin/admin_sidebar/admin_users/add_admin.dart';
import '/services/user_all.dart';
import 'admin_users/selectedUsers.dart';

class AdminUsersPage extends StatefulWidget {
  final User_all userAll;

  const AdminUsersPage({super.key, required this.userAll});

  @override
  _AdminUsersPageState createState() => _AdminUsersPageState();
}

class _AdminUsersPageState extends State<AdminUsersPage> {
  final TextEditingController _searchController = TextEditingController();
  late Future<List<User_all>> user_all;

  @override
  void initState() {
    super.initState();
    user_all = fetchData();
    _searchController.addListener(_onSearchChanged);
  }

  Future<List<User_all>> fetchData([String query = '']) async {
    final response = await http.get(
        Uri.parse('http://10.0.2.2:8080/api/v1/auth/all?search=$query')
    );
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((item) => User_all.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }

  void _onSearchChanged() {
    setState(() {
      user_all = fetchData(_searchController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildSearchBarWithFunnel(),
            SizedBox(height: 10.0),
            _buildUserTable(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewAdmin,
        child: Icon(Icons.add),
        backgroundColor: Colors.yellow,
      ),
    );
  }

  Widget _buildSearchBarWithFunnel() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Search...',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                  color: Colors.blue,
                ),
              ),
              filled: true,
              fillColor: Colors.grey[200],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildUserTable() {
    return Expanded(
      child: FutureBuilder<List<User_all>>(
        future: user_all,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: SpinKitRing(
                color: Colors.black,
                size: 60.0,
              ),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }
          if (snapshot.hasData) {
            final users = snapshot.data!;
            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                String avatarPath = user.gender == 'male'
                    ? 'assets/images/male.png'
                    : 'assets/images/female.png';
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: AssetImage(avatarPath),
                    ),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              user.username ?? 'Unknown',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 20.0,),
                            Text(
                              '-',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15.0,
                              ),
                            ),
                            SizedBox(width: 20.0,),
                            Text(
                              user.roles?.join(', ') ?? 'Unknown Role',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15.0,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          user.email ?? 'No email',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15.0,
                          ),
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SelectedUsers(user_all: user),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          }
          return Center(
            child: Text('Unable to load data'),
          );
        },
      ),
    );
  }

  void _addNewAdmin() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddAdmin(userAll: widget.userAll),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}

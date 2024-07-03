import 'package:flutter/material.dart';

class AdminProfilePage extends StatefulWidget {
  const AdminProfilePage({super.key});

  @override
  _AdminProfilePageState createState() => _AdminProfilePageState();
}

class _AdminProfilePageState extends State<AdminProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.limeAccent,
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(
                  child: CircleAvatar(
                    backgroundImage: AssetImage('assets/images/user.png'),
                    radius: 50.0,
                  ),
                ),
                Divider(height: 55.0,
                  color: Colors.black,
                  thickness: 3.0,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.person_2,
                      color: Colors.black,
                    ),
                    SizedBox(width: 3.0,),
                    Text(
                      'NAME',
                      style: TextStyle(
                        fontSize:25.0,
                        color: Colors.black,
                        letterSpacing: 2.0,
                      ),
                    ),
                  ],
                ),
                Text(
                  'Vhenus M. Tumbaga',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 25.0,
                  ),
                ),
                SizedBox(height: 30.0,),
                Row(
                    children:[
                      Icon(
                        Icons.calendar_month_sharp,
                        color:Colors.black,
                      ),
                      SizedBox(width: 3.0,),
                      Text(
                        'YEAR',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 25.0,
                        ),
                      ),
                    ]
                ),
                Text(
                  'Year',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 25.0,
                  ),
                ),
                SizedBox(height: 30.0,),
                Row(
                  children: [
                    Icon(
                      Icons.email_sharp,
                      color: Colors.black,
                    ),
                    SizedBox(width: 3.0,),
                    Text(
                      'EMAIL',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 25.0
                      ),
                    ),
                  ],
                ),
                Text(
                  'jvrclclothing@gmail.com',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 25.0
                  ),
                ),
              ],
            ),
          ],
        ),
        ),
      );
  }
}

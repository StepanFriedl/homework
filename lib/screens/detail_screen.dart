import 'package:flutter/material.dart';
import 'package:homework/classes/user.dart';

class DetailScreen extends StatelessWidget {
  final User user;

  DetailScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Set black background color
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Row with close button
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF263238),
                  ),
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context); // Navigate back when close button is pressed
                    },
                    child: Icon(Icons.close, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          // User information displayed using ListTiles and Dividers
          ListTile(
            title: Text(
              'Name: ${user.name}',
              style: TextStyle(color: Colors.white),
            ),
            subtitle: Text(
              'Username: ${user.username}',
              style: TextStyle(color: Colors.white70),
            ),
          ),
          Divider(color: Colors.white70), // Divider after the first ListTile
          ListTile(
            title: Text(
              'Email: ${user.email}',
              style: TextStyle(color: Colors.white),
            ),
            subtitle: Text(
              'Phone: ${user.phone}',
              style: TextStyle(color: Colors.white70),
            ),
          ),
          Divider(color: Colors.white70), // Divider after the second ListTile
          ListTile(
            title: Text(
              'Website: ${user.website}',
              style: TextStyle(color: Colors.white),
            ),
          ),
          Divider(color: Colors.white70), // Divider after the third ListTile
          ListTile(
            title: Text(
              'Address:',
              style: TextStyle(color: Colors.white),
            ),
            subtitle: Text(
              '${user.address.street}, ${user.address.suite}, ${user.address.city}, ${user.address.zipcode}',
              style: TextStyle(color: Colors.white70),
            ),
          ),
          Divider(color: Colors.white70), // Divider after the address ListTile
          ListTile(
            title: Text(
              'Company: ${user.company.name}',
              style: TextStyle(color: Colors.white),
            ),
            subtitle: Text(
              'Catch Phrase: ${user.company.catchPhrase}',
              style: TextStyle(color: Colors.white70),
            ),
          ),
        ],
      ),
    );
  }
}

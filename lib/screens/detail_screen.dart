import 'package:flutter/material.dart';
import 'package:homework/classes/user.dart';

class DetailScreen extends StatelessWidget {
  final User user;

  DetailScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 32.0),
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFF263238),
                    ),
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.close, color: Colors.white),
                    ),
                  ),
                ),

              ],
            ),
          ),
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
          Divider(color: Colors.white70),
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
          Divider(color: Colors.white70),
          ListTile(
            title: Text(
              'Website: ${user.website}',
              style: TextStyle(color: Colors.white),
            ),
          ),
          Divider(color: Colors.white70),
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
          Divider(color: Colors.white70),
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

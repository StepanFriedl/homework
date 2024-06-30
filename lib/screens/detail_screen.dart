import 'package:flutter/material.dart';
import 'package:homework/classes/user.dart';

class DetailScreen extends StatelessWidget {
  final User user;

  DetailScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.close),
                ),
              ],
            ),
          ),
          ListTile(
            title: Text('Name: ${user.name}'),
            subtitle: Text('Username: ${user.username}'),
          ),
          Divider(),
          ListTile(
            title: Text('Email: ${user.email}'),
            subtitle: Text('Phone: ${user.phone}'),
          ),
          Divider(),
          ListTile(
            title: Text('Website: ${user.website}'),
          ),
          Divider(),
          ListTile(
            title: Text('Address:'),
            subtitle: Text(
                '${user.address.street}, ${user.address.suite}, ${user.address
                    .city}, ${user.address.zipcode}'),
          ),
          Divider(),
          ListTile(
            title: Text('Company: ${user.company.name}'),
            subtitle: Text('Catch Phrase: ${user.company.catchPhrase}'),
          ),
        ],
      ),
    );
  }
}

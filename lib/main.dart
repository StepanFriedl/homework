import 'package:flutter/material.dart';
import 'package:homework/screens/users_list.dart';

void main() => runApp(MaterialApp(
  initialRoute: "/users_list",
  routes: {
    "/users_list": (context) => UsersList(),
  },
));

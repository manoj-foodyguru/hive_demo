import 'package:flutter/material.dart';

import 'data/operations.dart';

class UserList extends StatefulWidget {
  List<String> users = [];
  UserList({super.key, required this.users});

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: widget.users.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(widget.users[index]),
          );
        },
      ),
    );
  }
}

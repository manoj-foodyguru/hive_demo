import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'data/local_data_access.dart';
import 'models/user.dart';

class UserList extends StatefulWidget {
  List<String> users = [];
  UserList({super.key, required this.users});

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  getData() async {
    User response = await LocalDataAccess().get(26, 'users');
    print(response.id);
  }

  showUser(id) {
    Fluttertoast.showToast(
      msg: 'This is a toast message!',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.grey[600],
      textColor: Colors.white,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: widget.users.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
              title: Text(widget.users[index]),
              onTap: () async {
                // showUser((User)widget.users[index]);
              });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          List response = await LocalDataAccess().getAll('address');
          response.forEach((element) => print(element.country));
        },
        child: Icon(Icons.map),
      ),
    );
  }
}

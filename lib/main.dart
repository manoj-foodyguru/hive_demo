import 'dart:io';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:isardb/data/operations.dart';
import 'package:isardb/models/user.dart';
import 'package:isardb/user-list.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    Hive.init("./");
  } else {
    Directory appDocumentsDirectory =
        await path_provider.getApplicationDocumentsDirectory();
    Hive.init(appDocumentsDirectory.path);
  }

  Operations().registerAdapter();
  runApp(App());
}

class App extends StatelessWidget {
  App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: UserForm(),
    );
  }
}

class UserForm extends StatefulWidget {
  @override
  _UserFormState createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final _formKey = GlobalKey<FormState>();

  final List<String> items = [];

  String? _name;
  int? _age;

  save() async {
    var user = User();
    user.name = _name;
    user.age = _age;
    user.id = Random().nextInt(100);

    var response = await Operations().dbPush<User>(user, user.id, "users");
    user.save();
  }

  getData() async {
    User response = await Operations().dbGet(26, 'users');
    print(response.id);
  }

  getAllData() async {
    List response = await Operations().dbGetAll('users');
    response.forEach((element) => print(element.name));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      child: TextFormField(
                        decoration: InputDecoration(labelText: 'Name'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _name = value;
                        },
                      ),
                    ),
                    Container(
                      child: TextFormField(
                        decoration: InputDecoration(labelText: 'Age'),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your age';
                          }
                          if (int.tryParse(value) == null) {
                            return 'Please enter a valid age';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _age = int.parse(value!);
                        },
                      ),
                    ),
                    SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          save();
                        }
                      },
                      child: Text('Submit'),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          items.clear();
          List response = await Operations().dbGetAll('users');
          response.forEach((element) => items.add(element.name));
          Navigator.push(context,
              MaterialPageRoute(builder: (_) => UserList(users: items)));
        },
        child: Icon(Icons.list),
      ),
    );
  }
}

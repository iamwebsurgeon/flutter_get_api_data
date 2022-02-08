import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: DataFromAPI(),);
  }
}

class DataFromAPI extends StatefulWidget {
  const DataFromAPI({Key? key}) : super(key: key);

  @override
  _DataFromAPIState createState() => _DataFromAPIState();
}

class _DataFromAPIState extends State<DataFromAPI> {
  getUserData() async {
    var url = Uri.http('jsonplaceholder.typicode.com', 'users');
    var response = await http.get(url);
    var jsonData = jsonDecode(response.body);

    List<User> users = [];

    for(var u in jsonData){
      User user = User(u['name'], u['email'], u['username']);
      users.add(user);
    }

    print(users.length);
    return users;

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('API Data'),
      ),
      body: Container(
        child: Card(
          child: FutureBuilder(
              future: getUserData(),
              builder: (context, AsyncSnapshot snapshot){
                if(snapshot.data == null){
                  return Container(
                    child: Center(
                      child: Text('Loading...'),
                    ),
                  );
                }
                else return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, i){
                      return ListTile(
                        title: Text(snapshot.data[i].name),
                        subtitle: Text(snapshot.data[i].email),
                        trailing: Text(snapshot.data[i].username),
                      );
                    }
                );
              }
          ),
        ),
      ),

    );
  }
}

class User {
  final String name, email, username;
  User(this.name, this.email, this.username);
}




import 'package:flutter/material.dart';
import 'package:market_watch/state/app_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    Map _userData = AppStateScope.of(context).userData;
    return Center(
      child: Card(
        child: ListTile(
          subtitle: Text('${_userData['email']}'),
          title: Text('${_userData['fullName']}'),
          leading: CircleAvatar(
            radius: 25,
            backgroundImage: NetworkImage('${_userData['profilePhoto']}'),
          ),
        ),
      ),
    );
  }
}

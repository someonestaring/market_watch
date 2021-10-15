import 'package:flutter/material.dart';

class SavedList extends StatefulWidget {
  const SavedList({Key? key}) : super(key: key);

  @override
  _SavedListState createState() => _SavedListState();
}

class _SavedListState extends State<SavedList> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Saved Page',
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class AlertsList extends StatefulWidget {
  const AlertsList({Key? key}) : super(key: key);

  @override
  _AlertsListState createState() => _AlertsListState();
}

class _AlertsListState extends State<AlertsList> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Alerts Page',
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}

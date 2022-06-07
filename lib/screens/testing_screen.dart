import 'package:flutter/material.dart';
import 'package:flutter_rider_app/api/api.dart';

class Testing extends StatefulWidget {
  const Testing({Key? key}) : super(key: key);

  @override
  State<Testing> createState() => _TestingState();
}

class _TestingState extends State<Testing> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: const Text('Testing Page'),
        ),
        body: Column(
          children: [
            Center(
              child: Text('Testing Screen'),
            )
          ],
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_template/main.dart';

List<Widget> pages = const [
  Home()
];

class Skeleton extends StatelessWidget {
  const Skeleton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Poke-Mapp'),
      ),
      body: pages[0],
    );
  }
}

import 'package:flutter/material.dart';


import '../../Widget/riders_datatable.dart';

class Riders extends StatefulWidget {
  const Riders({super.key});

  @override
  State<Riders> createState() => _RidersState();
}

class _RidersState extends State<Riders> {


  @override
  Widget build(BuildContext context) {
    
    return const Scaffold(
      body: SafeArea(
        child: RidersData(),
      ),
      // floatingActionButton: FloatingActionButton(
      //     onPressed: () {}, child: const Icon(Icons.add)),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:admin/Widget/users_datatable.dart';


class Users extends StatefulWidget {
  const Users({super.key});

  @override
  State<Users> createState() => _UsersState();
}

class _UsersState extends State<Users> {
 


  @override
  Widget build(BuildContext context) {
    
    return const Scaffold(
      body: SafeArea(
        child: UsersData(),
      ),
      // floatingActionButton: FloatingActionButton(
      //     onPressed: () {}, child: const Icon(Icons.add)),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:admin/Widget/profile_datatable.dart';




class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  



  @override
  Widget build(BuildContext context) {
    
   return  const Scaffold(
            body: SafeArea(
              child: ProfileData(),
            ),
          );
  }
}

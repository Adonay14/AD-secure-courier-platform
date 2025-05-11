import 'package:admin/constance.dart';
import 'package:admin/widget/feeds%20data/add_feeds.dart';
import 'package:flutter/material.dart';


import '../widget/feeds data/feeds_datatable.dart';



class Feeds extends StatefulWidget {
  const Feeds({super.key});

  @override
  State<Feeds> createState() => _FeedsState();
}

class _FeedsState extends State<Feeds> {
 


  @override
  Widget build(BuildContext context) {
    
   return   Scaffold(
      floatingActionButton: MediaQuery.of(context).size.width >= 1100
          ? null
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: FloatingActionButton(
                backgroundColor: buttonColor,
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (builder) {
                        return const AddFeed();
                      });
                },
                child: const Icon(Icons.add),
              ),
            ),
            body: const SafeArea(
              child: FeedsData(),
            ),
          );
  }
}

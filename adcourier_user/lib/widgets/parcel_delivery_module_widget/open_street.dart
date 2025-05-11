import 'package:flutter/material.dart';
import 'package:osm_search_and_pick/open_street_map_search_and_pick.dart';
import 'package:user_web/constant.dart';

class OpenStreetProfile extends StatefulWidget {
  const OpenStreetProfile({super.key});

  @override
  State<OpenStreetProfile> createState() => _OpenStreetProfileState();
}

class _OpenStreetProfileState extends State<OpenStreetProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Google Map'),
      ),
      body: OpenStreetMapSearchAndPick(

          // center: LatLong(23, 89),
          buttonColor: appColor,
          buttonTextStyle: const TextStyle(fontSize: 15, color: Colors.white),
          buttonText: 'Set Current Location',
          onPicked: (pickedData) {
            Navigator.pop(context, {
              'address': pickedData.addressName,
              'lat': pickedData.latLong.latitude,
              'long': pickedData.latLong.longitude
            });
          }),
    );
  }
}

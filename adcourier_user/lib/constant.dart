import 'dart:math';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'model/module_model.dart';

const String googleApiKey = 'AIzaSyCAi0WBoE2u0KOZepJVoV6Y0aJGYfqSXgc';
Color appColor = Color(0xff64c9f3);
const String email = 'syedmahsan1993@gmail.com';
const String serverUrl = 'https://olivette-server.onrender.com';
const String domainUrl = 'https://olivette-market-place.web.app';
const String logo = "assets/image/new logo.png";
const String logoLoader = "assets/image/icon loader.png";
const String appName = 'AD Courier';
const String country = 'Oman';
String loadingText = 'Loading...';
const String networkText = 'Please check internet connection...';
String projectID = 'ad-courier';
String googleAPiKey = "AIzaSyCIG4hrwrTleFvlUvNuf9fD3PEqUH3Q2dI";
bool loadingBool = false;
const playstoreUrl = '';
const appStoreUrl = '';
const footerDescription =
    'The site is owned and operated by $appName Limited – owners of Marketsquare - a company registered in Nigeria whose registered office is 23 Nzimiro Street, Old GRA, Port Harcourt, Rivers State, Nigeria. Company Registration No. 1181249, TIN No. 17810525 © 2023 olivette-store.web.app All Rights Reserved.';
List<String> sliderBackgroundImages = [
  'assets/image/2.png',
  'assets/image/2.png',
  "assets/image/3.png",
];

List<Color> groceryFeedsColors = [
  Colors.blue,
  Colors.orange,
  Colors.red,
  Colors.green
];
selectgroceryFeedsColors() {
  final random = Random();

  // Pick a random item
  Color randomItem =
      groceryFeedsColors[random.nextInt(groceryFeedsColors.length)];
  return randomItem;
}

selectSlider() {
  final random = Random();

  // Pick a random item
  String randomItem =
      sliderBackgroundImages[random.nextInt(sliderBackgroundImages.length)];
  return randomItem;
}

Future<void> makePhoneCall(String phoneNumber) async {
  // Format the phone number for the URL
  final Uri phoneUri = Uri(
    scheme: 'tel',
    path: phoneNumber,
  );

  try {
    // Check if the URL can be launched
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    } else {
      throw 'Could not launch $phoneUri';
    }
  } catch (e) {
    // Handle web-specific behavior
    // For web, we'll provide a fallback to copy the number
    final fallbackUri = Uri(
      scheme: 'https',
      host: 'web.whatsapp.com',
      path: '/send',
      queryParameters: {'phone': phoneNumber.replaceAll(RegExp(r'[^0-9]'), '')},
    );

    if (await canLaunchUrl(fallbackUri)) {
      await launchUrl(fallbackUri);
    } else {
      debugPrint('Could not launch call or WhatsApp: $e');
    }
  }
}

List<ModuleModel> allModule = [
  ModuleModel(
      name: 'Ecommerce',
      image: 'assets/image/ecommerce.png',
      route: '/ecommerce'),
  ModuleModel(
      name: 'Restaurant',
      image: 'assets/image/restaurant.png',
      route: '/restaurant'),
  ModuleModel(
      name: 'Pharmacy', image: 'assets/image/pharmacy.png', route: '/pharmacy'),
  ModuleModel(
      name: 'Grocery', image: 'assets/image/grocery.png', route: '/grocery'),
  ModuleModel(
      name: 'Parcel Delivery',
      image: 'assets/image/delivery guy.png',
      route: '/parcel-delivery'),
];

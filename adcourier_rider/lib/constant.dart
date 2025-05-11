import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

const String googleApiKey = 'AIzaSyAcqpzOvxzn1GHebVAuxZC-25EmCr3n1bs';
Color appColor = Color(0xff62c9f3);
String googleAPiKey = "AIzaSyCIG4hrwrTleFvlUvNuf9fD3PEqUH3Q2dI";
const String email = 'preciousoliver03@gmail.com';
const String serverUrl = 'https://olivette-server.onrender.com';
const String domainUrl = 'https://olivette-single-vendor.web.app';
const String logo = "assets/image/new logo.png";
const String logoLoader = "assets/image/new new splash.png";
const String appName = 'AD Courier Rider';
const String country = 'Nigeria';
String loadingText = 'Loading...';
const String networkText = 'Please check internet connection...';
bool loadingBool = false;
const playstoreUrl = '';
const appStoreUrl = '';
String projectID = 'delivery-system-9e0df';
const String countryCode = 'NG';
const footerDescription =
    'The site is owned and operated by $appName Limited – owners of Marketsquare - a company registered in Nigeria whose registered office is 23 Nzimiro Street, Old GRA, Port Harcourt, Rivers State, Nigeria. Company Registration No. 1181249, TIN No. 17810525 © 2023 olivette-store.web.app All Rights Reserved.';
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

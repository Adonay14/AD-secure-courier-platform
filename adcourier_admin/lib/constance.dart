import 'package:flutter/material.dart';

String loginBackground = 'assets/image/background.jpg';
String logo = 'assets/image/new logo.png';
String iconLoader = 'assets/image/icon loader.png';
String appName = 'AD Courier';
String adminTitle = 'AD Courier Admin';
Color buttonColor = Colors.green;
String hostURL = 'https://olivette-server.onrender.com';
bool demo = true;
String projectID = 'ad-courier';
List<String> userCollection = ["Users", "Vendors", "Riders"];
String googleAPiKey = "AIzaSyCAi0WBoE2u0KOZepJVoV6Y0aJGYfqSXgc";
postEmailSubject(String orderID) {
  return 'Update of your order with order id $orderID';
}

postEmailContent(String orderStatus, String orderID) {
  if (orderStatus == 'Pending') {
    return 'Your order with order id $orderID is pending';
  } else if (orderStatus == 'Cancelled') {
    return 'Your order with order id $orderID has been cancelled';
  } else if (orderStatus == 'Processing') {
    return 'Your order with order id $orderID is processing';
  } else if (orderStatus == 'On the way') {
    return 'Your order with order id $orderID is on the way';
  } else if (orderStatus == 'Confirmed') {
    return 'Your order with order id $orderID has been confirmed';
  } else if (orderStatus == 'Delivered') {
    return 'Your order with order id $orderID has been delivered';
  }
}

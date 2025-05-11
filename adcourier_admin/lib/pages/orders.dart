import 'package:flutter/material.dart';
import '../widget/orders tabs/order_tabs_page.dart';


class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {


  @override
  Widget build(BuildContext context) {
    
   return  const Scaffold(
            body: SafeArea(
              child: OrdersPage(),
            ),
          );
  }
}

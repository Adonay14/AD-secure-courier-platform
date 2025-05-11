import 'package:admin/widget/categories%20data/parcel_category_datatable.dart';
import 'package:flutter/material.dart';


class ParcelCategories extends StatefulWidget {
  const ParcelCategories({super.key});

  @override
  State<ParcelCategories> createState() => _ParcelCategoriesState();
}

class _ParcelCategoriesState extends State<ParcelCategories> {


 

  @override
  Widget build(BuildContext context) {
    
    return const Scaffold(
            body: SafeArea(
              child: ParcelCategoryDatatable(),
            ),
          );
  }
}

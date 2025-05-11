import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:user_web/widgets/cat_image_widget.dart';

class ParcelStaticWidgetOne extends StatefulWidget {
  const ParcelStaticWidgetOne({super.key});

  @override
  State<ParcelStaticWidgetOne> createState() => _ParcelStaticWidgetOneState();
}

class _ParcelStaticWidgetOneState extends State<ParcelStaticWidgetOne> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Delivery Solutions for Online Retailers',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize:
                  MediaQuery.of(context).size.width >= 1100 ? 30.r : 20.r),
        ),
        Text(
          'Quickly integrate powerful solutions that give you more flexibility and control over your parcel shipping and logistics processes.',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize:
                  MediaQuery.of(context).size.width >= 1100 ? 20.r : 15.r),
        ),
        const Gap(20),
        Column(
          children: details.asMap().entries.map((entry) {
            final index = entry.key;
            final e = entry.value;
            return SizedBox(
                height: 400,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: Stack(
                    children: [
                      CatImageWidget(url: e['image'], boxFit: 'cover'),
                      Align(
                        alignment: MediaQuery.of(context).size.width >= 1100
                            ? (index == 1
                                ? Alignment.centerRight
                                : Alignment.centerLeft)
                            : Alignment.bottomCenter,
                        child: Container(
                          height: MediaQuery.of(context).size.width >= 1100
                              ? 600
                              : 150,
                          width: MediaQuery.of(context).size.width >= 1100
                              ? MediaQuery.of(context).size.width / 3
                              : double.infinity,
                          decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha:0.8)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                e['title'],
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.r),
                              ),
                              Text(
                                e['desc'],
                                textAlign: TextAlign.center,
                                maxLines:
                                    MediaQuery.of(context).size.width >= 1100
                                        ? null
                                        : 4,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontSize: 15.r),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ));
          }).toList(),
        )
      ],
    );
  }
}

List<Map<String, dynamic>> details = [
  {
    'title': 'Crediblity',
    'desc':
        'At Olivette Logistics, we offer sophisticated logistics services to help manage your entire supply chain process for your E-commerce business, both B2C and B2B.',
    'image':
        'https://insights.workwave.com/wp-content/uploads/2021/08/WorkWave-How-to-Add-a-Delivery-Service-For-Your-Business.jpg'
  },
  {
    'title': 'SwiftDrop Delivery',
    'desc':
        'SwiftDrop Delivery offers fast, reliable, and affordable same-day delivery for businesses and individuals. From documents to packages, our trusted network ensures your items are delivered securely and on time, every time. Available 24/7 with real-time tracking and eco-friendly options',
    'image':
        'https://media.istockphoto.com/id/1434715649/photo/parcel-delivery-for-senior.jpg?s=612x612&w=0&k=20&c=OX81ZQI64AmtLdflUFEw4G3UsRnrfkkjLRhHH3OTrBY='
  },
  {
    'title': 'Secure Payment',
    'desc':
        'Olivette Logistics offers effective and prompt door-door delivery across the nation',
    'image':
        'https://media.istockphoto.com/id/511661096/photo/woman-hand-accepting-a-delivery-of-boxes-from-deliveryman.jpg?s=612x612&w=0&k=20&c=m6e7vtu_UJ97nM50VkIBtAvNnSt76ndRv4-MrVYVkns='
  },
];

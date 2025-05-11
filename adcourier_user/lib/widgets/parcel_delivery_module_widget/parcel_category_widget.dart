import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';
import 'package:user_web/constant.dart';
import 'package:user_web/model/parcel_category.dart';
import 'package:user_web/widgets/cat_image_widget.dart';

import '../../providers/profile_provider.dart';

class ParcelCategoryWidget extends ConsumerStatefulWidget {
  final Function openDrawerEndrawer;
  const ParcelCategoryWidget({
    super.key,
    required this.openDrawerEndrawer,
  });

  @override
  ConsumerState<ParcelCategoryWidget> createState() =>
      _ParcelCategoryWidgetState();
}

class _ParcelCategoryWidgetState extends ConsumerState<ParcelCategoryWidget> {
  List<ParcelCategoriesModel> cats = [];
  bool isLoading = false;
  getCats() {
    setState(() {
      isLoading = true;
    });
    List<ParcelCategoriesModel> categories = [];
    return FirebaseFirestore.instance
        .collection('Parcel Categories')
        .snapshots()
        .listen((value) {
      setState(() {
        isLoading = false;
      });
      cats.clear();
      for (var element in value.docs) {
        setState(() {
          var fetchServices =
              ParcelCategoriesModel.fromMap(element.data(), element.id);
          categories.insert(0, fetchServices);
          cats = categories;
        });
      }
    });
  }

  @override
  void initState() {
    getCats();
    super.initState();
  }

  int current = 0;
  final CarouselSliderController _controller = CarouselSliderController();
  bool isHovered = false;
  @override
  Widget build(BuildContext context) {
    final isLogged = ref.watch(getAuthListenerProvider).value ?? false;
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          // height: 200,
          child: isLoading == true
              ? Padding(
                  padding: MediaQuery.of(context).size.width >= 1100
                      ? const EdgeInsets.all(0)
                      : const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),

                    itemCount: 8, // Number of grid items
                    itemBuilder: (BuildContext context, int index) {
                      return Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          color: Colors.white,
                          // margin: EdgeInsets.all(8.0),
                        ),
                      );
                    },
                  ),
                )
              : Padding(
                  padding: MediaQuery.of(context).size.width >= 1100
                      ? const EdgeInsets.all(0)
                      : const EdgeInsets.all(8.0),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        height: 180,
                        width: double.infinity,
                        child: CarouselSlider.builder(
                          carouselController: _controller,
                          options: CarouselOptions(
                              initialPage: 0,
                              disableCenter: false,
                              enableInfiniteScroll: false,
                              padEnds: false,
                              aspectRatio: 1,
                              viewportFraction:
                                  MediaQuery.of(context).size.width >= 1100
                                      ? 0.3
                                      : 0.8,
                              reverse: false,
                              autoPlay: false,
                              autoPlayInterval: const Duration(seconds: 3),
                              autoPlayAnimationDuration:
                                  const Duration(milliseconds: 800),
                              autoPlayCurve: Curves.fastOutSlowIn,
                              enlargeCenterPage: false,
                              // onPageChanged: callbackFunction,
                              scrollDirection: Axis.horizontal,
                              onPageChanged: (index, reason) {
                                setState(() {
                                  current = index;
                                  // // ignore: avoid_print
                                  // print('current is $current');
                                });
                              }),
                          itemCount: cats.length,
                          itemBuilder:
                              (BuildContext context, int d, int index) {
                            ParcelCategoriesModel parcelCategoriesModel =
                                cats[d];
                            return InkWell(
                              hoverColor: Colors.transparent,
                              onHover: (value) {
                                setState(() {
                                  isHovered = value;
                                });
                              },
                              onTap: () {
                                if (isLogged == true) {
                                  widget.openDrawerEndrawer(
                                      parcelCategoriesModel);
                                } else {
                                  context.go('/login');
                                  Fluttertoast.showToast(
                                      msg: "Login to continue.".tr(),
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.TOP,
                                      timeInSecForIosWeb: 1,
                                      fontSize: 14.0);
                                }
                              },
                              child: ParcelWidget(
                                  isLogged: isLogged,
                                  openDrawerEndrawer: widget.openDrawerEndrawer,
                                  parcelCategoriesModel: parcelCategoriesModel),
                            );
                          },
                        ),
                      ),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () {
                                _controller.previousPage();
                              },
                              child: Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                    color: appColor,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Center(
                                      child: Icon(
                                    Icons.chevron_left,
                                    color: Colors.white,
                                  ))),
                            ),
                          )),
                      Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () {
                                _controller.nextPage();
                              },
                              child: Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                    color: appColor,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Center(
                                      child: Icon(
                                    Icons.chevron_right,
                                    color: Colors.white,
                                  ))),
                            ),
                          ))
                    ],
                  ),
                ),
        ),
      ],
    );
  }
}

class ParcelWidget extends StatefulWidget {
  final ParcelCategoriesModel parcelCategoriesModel;
  final Function openDrawerEndrawer;
  final bool isLogged;
  const ParcelWidget(
      {super.key,
      required this.parcelCategoriesModel,
      required this.openDrawerEndrawer,
      required this.isLogged});

  @override
  State<ParcelWidget> createState() => _ParcelWidgetState();
}

class _ParcelWidgetState extends State<ParcelWidget> {
  bool isHovered = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      hoverColor: Colors.transparent,
      onHover: (value) {
        setState(() {
          isHovered = value;
        });
      },
      onTap: () {
        if (widget.isLogged == true) {
          widget.openDrawerEndrawer(widget.parcelCategoriesModel);
        } else {
          context.go('/login');
          Fluttertoast.showToast(
              msg: "Login to continue.".tr(),
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.TOP,
              timeInSecForIosWeb: 1,
              fontSize: 14.0);
        }
      },
      child: Transform.scale(
        scale: MediaQuery.of(context).size.width >= 1100
            ? (isHovered == true ? 1.05 : 1.0)
            : (isHovered == true ? 1 : 1.0),
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 10,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: SizedBox(
                          height: 100,
                          width: 100,
                          child: Center(
                            child: CatImageWidget(
                                url: widget.parcelCategoriesModel.image,
                                boxFit: 'fill'),
                          ),
                        ),
                      ),
                      const Gap(10),
                      Expanded(
                        flex: 5,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              widget.parcelCategoriesModel.category,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 18.r,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Gap(5),
                            Text(
                              widget.parcelCategoriesModel.description,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12.r,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )),
      ),
    );
  }
}

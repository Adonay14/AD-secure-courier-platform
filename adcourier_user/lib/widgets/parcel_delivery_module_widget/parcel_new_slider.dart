// ignore_for_file: avoid_print

import 'package:carousel_slider/carousel_slider.dart';

import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import 'package:shimmer/shimmer.dart';

// import 'package:user_web/constant.dart';
import 'package:user_web/model/feeds.dart';
import 'package:user_web/providers/parcel_providers/parcel_feed_provider.dart';

class ParcelNewSlider extends ConsumerStatefulWidget {
  const ParcelNewSlider({
    super.key,
  });

  @override
  ConsumerState<ParcelNewSlider> createState() => _ParcelNewSliderState();
}

class _ParcelNewSliderState extends ConsumerState<ParcelNewSlider> {
  int _current = 0;
  final CarouselSliderController _controller = CarouselSliderController();

  String category = '';

  @override
  Widget build(BuildContext context) {
    final allList = ref.watch(parcelFeedsProvider);

    return allList.when(data: (v) {
      return Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(0)),
            child: Stack(
              children: [
                CarouselSlider.builder(
                  carouselController: _controller,
                  itemCount: v.length,
                  itemBuilder:
                      (BuildContext context, int itemIndex, int pageViewIndex) {
                    FeedsModel feedsModel = v[itemIndex];

                    return Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(
                                    feedsModel.image,
                                  ),
                                  fit: BoxFit.cover)),
                          child: Container(
                            color: Colors.black
                                .withValues(alpha:0.3), // Adjust opacity as needed
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                const Gap(20),
                                Text(
                                  feedsModel.title,
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize:
                                          MediaQuery.of(context).size.width <=
                                                  1100
                                              ? 25.r
                                              : 30.r,
                                      fontWeight: FontWeight.bold),
                                ),
                                if (MediaQuery.of(context).size.width <= 1100)
                                  const Gap(20),
                                if (MediaQuery.of(context).size.width >= 1100)
                                  const Gap(10),
                                Padding(
                                  padding:
                                      MediaQuery.of(context).size.width >= 1100
                                          ? const EdgeInsets.only(
                                              left: 50, right: 50)
                                          : const EdgeInsets.all(0),
                                  child: Text(
                                    feedsModel.detail,
                                    maxLines:
                                        MediaQuery.of(context).size.width >=
                                                1100
                                            ? 3
                                            : 2,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16.r),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                  options: CarouselOptions(
                      height: MediaQuery.of(context).size.width >= 1100
                          ? MediaQuery.of(context).size.height / 1
                          : MediaQuery.of(context).size.height / 1,
                      aspectRatio: 1,
                      viewportFraction: 1,
                      initialPage: 0,
                      enableInfiniteScroll: true,
                      reverse: false,
                      autoPlay: true,
                      padEnds: false,
                      disableCenter: true,
                      autoPlayInterval: const Duration(seconds: 10),
                      // autoPlayAnimationDuration:
                      //     const Duration(milliseconds: 1500),
                      // autoPlayCurve: Curves.slowMiddle,
                      enlargeCenterPage: false,
                      // onPageChanged: callbackFunction,
                      scrollDirection: Axis.horizontal,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _current = index;
                        });
                      }),
                ),
                Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: v.asMap().entries.map((entry) {
                        return GestureDetector(
                          onTap: () => _controller.animateToPage(entry.key),
                          child: Container(
                            width: 12.0,
                            height: 12.0,
                            margin: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 4.0),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.black.withValues(alpha:
                                    _current == entry.key ? 0.9 : 0.4)),
                          ),
                        );
                      }).toList(),
                    )),
              ],
            ),
          )
        ],
      );
    }, error: (e, r) {
      return Text(e.toString());
    }, loading: () {
      return Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(12)),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Expanded(
                child: Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  enabled: true,
                  child: CarouselSlider.builder(
                    options: CarouselOptions(
                      height: MediaQuery.of(context).size.height / 1,
                      aspectRatio: 1,
                      viewportFraction: 1,
                      initialPage: 0,
                      enableInfiniteScroll: true,
                      reverse: false,
                      autoPlay: MediaQuery.of(context).size.width >= 1100
                          ? true
                          : false,
                      autoPlayInterval: const Duration(seconds: 5),
                      autoPlayAnimationDuration:
                          const Duration(milliseconds: 800),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enlargeCenterPage: true,
                      // onPageChanged: callbackFunction,
                      scrollDirection: Axis.horizontal,
                    ),
                    itemBuilder: (_, __, int pageViewIndex) => SizedBox(
                        height: MediaQuery.of(context).size.height / 1.2,
                        width: MediaQuery.of(context).size.width >= 1100
                            ? MediaQuery.of(context).size.width / 1
                            : MediaQuery.of(context).size.width / 1,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0),
                          ),
                        )),
                    itemCount: 1,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

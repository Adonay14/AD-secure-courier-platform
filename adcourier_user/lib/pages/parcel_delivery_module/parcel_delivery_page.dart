// import 'package:adaptive_theme/adaptive_theme.dart';
// import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
// import 'package:go_router/go_router.dart';
// import 'package:user_web/constant.dart';
// import 'package:modal_bottom_sheet/modal_bottom_sheet.dart' as modalsheet;
import 'package:user_web/model/parcel_category.dart';
import 'package:user_web/widgets/footer_widget.dart';
import 'package:user_web/widgets/parcel_delivery_module_widget/parcel_cart.dart';
import 'package:user_web/widgets/parcel_delivery_module_widget/parcel_new_slider.dart';
// import '../../widgets/language_widget.dart';
import '../../widgets/parcel_delivery_module_widget/parcel_category_widget.dart';
import '../../widgets/parcel_delivery_module_widget/parcel_static_widget_one.dart';
import '../../widgets/parcel_delivery_module_widget/parcel_track_order_form_widget.dart';
import '../../widgets/testimonies.dart';

class ParcelDeliveryPage extends StatefulWidget {
  const ParcelDeliveryPage({super.key});

  @override
  State<ParcelDeliveryPage> createState() => _ParcelDeliveryPageState();
}

class _ParcelDeliveryPageState extends State<ParcelDeliveryPage> {
  openDrawerEndrawer(ParcelCategoriesModel selectedModel) {
    setState(() {
      parcelCategoriesModel = selectedModel;
    });
    _scaffoldEndrawer.currentState!.openEndDrawer();
  }

  final GlobalKey<ScaffoldState> _scaffoldEndrawer = GlobalKey<ScaffoldState>();
  ParcelCategoriesModel? parcelCategoriesModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldEndrawer,
      endDrawer: Drawer(
          shape: const ContinuousRectangleBorder(
              borderRadius: BorderRadius.all(Radius.zero)),
          width: MediaQuery.of(context).size.width >= 1100
              ? MediaQuery.of(context).size.width / 2
              : double.infinity,
          child: parcelCategoriesModel == null
              ? null
              : ParcelCart(
                  parcelCategoriesModel: parcelCategoriesModel!,
                )),
      endDrawerEnableOpenDragGesture: false,
      // appBar: AppBar(
      //   elevation: 50,
      //   shadowColor: const Color.fromARGB(255, 105, 101, 101),
      //   forceMaterialTransparency: true,
      //   // backgroundColor: appColor,
      //   toolbarHeight: MediaQuery.of(context).size.width >= 1100 ? 80 : 60,
      //   automaticallyImplyLeading: false,
      //   centerTitle: MediaQuery.of(context).size.width >= 1100 ? false : true,
      //   leadingWidth: MediaQuery.of(context).size.width >= 1100 ? 250 : 150,
      //   leading: MediaQuery.of(context).size.width >= 1100
      //       ? InkWell(
      //           hoverColor: Colors.transparent,
      //           onTap: () {
      //             context.go('/parcel-delivery');
      //           },
      //           child: Image.asset(
      //             logo,
      //             // color: Colors.white,
      //           ))
      //       : Padding(
      //           padding: const EdgeInsets.all(8.0),
      //           child: InkWell(
      //               hoverColor: Colors.transparent,
      //               onTap: () {
      //                 context.go('/parcel-delivery');
      //               },
      //               child: Image.asset(
      //                 logo,
      //                 height: 100,
      //                 width: 100,
      //               )),
      //         ),
      //   title: InkWell(
      //     onTap: () {
      //       context.go('/parcel-delivery');
      //     },
      //     child: Text(
      //       'Home',
      //       style: TextStyle(
      //           color: appColor, fontSize: 13.r, fontWeight: FontWeight.bold),
      //     ).tr(),
      //   ),
      //   actions: [
      //     IconButton(
      //         onPressed: () {
      //           if (MediaQuery.of(context).size.width >= 1100) {
      //             showDialog(
      //                 context: context,
      //                 builder: (context) {
      //                   return AlertDialog(
      //                     content: SizedBox(
      //                         width: MediaQuery.of(context).size.width >= 1100
      //                             ? MediaQuery.of(context).size.width / 3
      //                             : MediaQuery.of(context).size.width / 1.3,
      //                         height: MediaQuery.of(context).size.height / 1.5,
      //                         child: const LanguageWidget()),
      //                   );
      //                 });
      //           } else {
      //             modalsheet.showBarModalBottomSheet(
      //                 expand: true,
      //                 bounce: true,
      //                 context: context,
      //                 backgroundColor: Colors.transparent,
      //                 builder: (context) {
      //                   return const Scaffold(body: LanguageWidget());
      //                 });
      //           }
      //         },
      //         icon: const Icon(Icons.language)),
      //     const Gap(10),
      //     AdaptiveTheme.of(context).mode.isDark == true
      //         ? InkWell(
      //             onTap: () {
      //               AdaptiveTheme.of(context).setLight();
      //             },
      //             child: const Icon(
      //               Icons.light_mode,
      //             ))
      //         : InkWell(
      //             onTap: () {
      //               AdaptiveTheme.of(context).setDark();
      //             },
      //             child: const Icon(
      //               Icons.dark_mode,
      //             )),
      //     if (MediaQuery.of(context).size.width <= 1100) const Gap(10),
      //     if (MediaQuery.of(context).size.width >= 1100) const Gap(100)
      //   ],
      // ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              // fit: StackFit.passthrough,
              children: [
                SizedBox(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.width <= 1100
                        ? MediaQuery.of(context).size.height / 1.4
                        : MediaQuery.of(context).size.height / 1.2,
                    child: const ParcelNewSlider()),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    children: [
                      if (MediaQuery.of(context).size.width <= 1100)
                        const Gap(150),
                      if (MediaQuery.of(context).size.width >= 1100)
                        const Gap(100),
                      const ParcelTrackOrderFormWidget(),
                      const Gap(20),
                      Padding(
                        padding: MediaQuery.of(context).size.width <= 1100
                            ? const EdgeInsets.all(8.0)
                            : const EdgeInsets.only(left: 50, right: 50),
                        child: SizedBox(
                            height: 200,
                            // width: double.infinity,
                            child: ParcelCategoryWidget(
                              openDrawerEndrawer: openDrawerEndrawer,
                            )),
                      ),
                    ],
                  ),
                )
              ],
            ),
            const Gap(20),
            Padding(
              padding: MediaQuery.of(context).size.width <= 1100
                  ? const EdgeInsets.all(8.0)
                  : const EdgeInsets.only(left: 50, right: 50),
              child: const ParcelStaticWidgetOne(),
            ),
            const Gap(20),
            Padding(
              padding: MediaQuery.of(context).size.width <= 1100
                  ? const EdgeInsets.all(8.0)
                  : const EdgeInsets.only(left: 50, right: 50),
              child: TestimonialCarousel(),
            ),
            const Gap(20),
            const FooterWidget()
          ],
        ),
      ),
    );
  }
}

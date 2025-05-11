// ignore_for_file: avoid_print
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:user_web/model/menu_model.dart';
import 'package:user_web/providers/profile_provider.dart';
import 'package:user_web/widgets/mobile_menu.dart';
import 'package:user_web/constant.dart';

// ignore: library_prefixes
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart' as modalSheet;
import 'language_widget.dart';

class ScaffoldWidget extends ConsumerStatefulWidget {
  final Widget body;
  final String path;
  const ScaffoldWidget({super.key, required this.body, required this.path});

  @override
  ConsumerState<ScaffoldWidget> createState() => _ScaffoldWidgetState();
}

class _ScaffoldWidgetState extends ConsumerState<ScaffoldWidget> {
  String? selectedValue;

  openDrawerHome() {
    _scaffoldHome.currentState!.openDrawer();
  }

  final GlobalKey<ScaffoldState> _scaffoldHome = GlobalKey<ScaffoldState>();

  int currentIndex = 1;

  moveToOrder() {
    setState(() {
      context.go('/orders');
      currentIndex = 3;
      context.pop();
    });
  }

  routeName() {
    if (widget.path == '/about') {
      return 'About'.tr();
    } else if (widget.path == '/profile') {
      return 'Profile'.tr();
    } else if (widget.path == '/terms') {
      return 'Terms'.tr();
    } else if (widget.path == '/policy') {
      return 'Policy'.tr();
    } else if (widget.path == '/wallet') {
      return 'Wallet'.tr();
    } else if (widget.path == '/orders') {
      return "Orders".tr();
    } else if (widget.path == '/parcel-delivery/favorites') {
      return 'Favorites'.tr();
    } else if (widget.path == '/voucher') {
      return 'Vouchers'.tr();
    } else if (widget.path == '/inbox') {
      return 'Inbox'.tr();
    } else if (widget.path == '/delivery-addresses') {
      return 'Delivery Addresses'.tr();
    } else if (widget.path.contains('/order-detail') == true) {
      return 'Order Detail'.tr();
    } else if (widget.path.contains('/faq') == true) {
      return 'FAQ'.tr();
    }
  }

  @override
  Widget build(BuildContext context) {
    //print('Path is ${widget.path}');
    String hi = 'Hi'.tr();
    String account = 'Account'.tr();

    final getAuthListener = ref.watch(getAuthListenerProvider).value;
    final getFullName = getAuthListener == true
        ? ref.watch(getFullNameProvider).valueOrNull
        : '';
    return Scaffold(
      bottomNavigationBar: MediaQuery.of(context).size.width >= 1100 ||
              widget.path != '/parcel-delivery'
          ? null
          : BottomNavigationBar(
              selectedItemColor: appColor,
              type: BottomNavigationBarType.fixed,
              currentIndex: currentIndex,
              onTap: (index) {
                if (index == 0) {
                  // showBottomSheetTab();
                  openDrawerHome();
                } else if (index == 2) {
                  setState(() {
                    context.go('/orders');
                    // currentIndex = 2;
                  });
                } else if (index == 1) {
                  setState(() {
                    context.go('/parcel-delivery');
                    currentIndex = index;
                  });
                } else {}
              },
              items: [
                BottomNavigationBarItem(
                  icon: const Icon(Icons.sort),
                  label: 'Menu'.tr(),
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Icons.home_outlined),
                  label: 'Home'.tr(),
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Icons.list_alt),
                  label: 'Orders'.tr(),
                ),
              ],
            ),
      key: _scaffoldHome,
      // endDrawer: Drawer(
      //   shape: const ContinuousRectangleBorder(
      //       borderRadius: BorderRadius.all(Radius.zero)),
      //   width: MediaQuery.of(context).size.width >= 1100
      //       ? MediaQuery.of(context).size.width / 3
      //       : double.infinity,
      //   child: const EcommerceCartWidget(),
      // ),
      drawer: MediaQuery.of(context).size.width >= 1100
          ? null
          : Drawer(
              shape: const ContinuousRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.zero)),
              width: double.infinity,
              child: MobileMenuWidget(
                module: 'parcel-delivery',
                moveToOrder: moveToOrder,
                isLogged: getAuthListener!,
              )),
      appBar: AppBar(
        elevation: MediaQuery.of(context).size.width >= 1100 ? 0 : 10,
        forceMaterialTransparency: true,
        toolbarHeight: MediaQuery.of(context).size.width >= 1100 ? 60 : null,

        automaticallyImplyLeading: false,
        centerTitle: MediaQuery.of(context).size.width >= 1100 ? false : true,
        leadingWidth: MediaQuery.of(context).size.width >= 1100
            ? 250
            : (MediaQuery.of(context).size.width <= 1100 &&
                        widget.path == '/about') ||
                    (MediaQuery.of(context).size.width <= 1100 &&
                        widget.path == '/profile') ||
                    (MediaQuery.of(context).size.width <= 1100 &&
                        widget.path == '/terms') ||
                    (MediaQuery.of(context).size.width <= 1100 &&
                        widget.path == '/policy') ||
                    (MediaQuery.of(context).size.width <= 1100 &&
                        widget.path == '/wallet') ||
                    (MediaQuery.of(context).size.width <= 1100 &&
                        widget.path == '/orders') ||
                    (MediaQuery.of(context).size.width <= 1100 &&
                        widget.path == '/parcel-delivery/favorites') ||
                    (MediaQuery.of(context).size.width <= 1100 &&
                        widget.path == '/voucher') ||
                    (MediaQuery.of(context).size.width <= 1100 &&
                        widget.path == '/inbox') ||
                    (MediaQuery.of(context).size.width <= 1100 &&
                        widget.path == '/delivery-addresses') ||
                    (MediaQuery.of(context).size.width <= 1100 &&
                        widget.path.contains('/order-detail') == true) ||
                    (MediaQuery.of(context).size.width <= 1100 &&
                        widget.path.contains('/faq') == true) ||
                    widget.path.contains('/checkout') == true
                ? null
                : 150,
        leading: MediaQuery.of(context).size.width >= 1100
            ? InkWell(
                hoverColor: Colors.transparent,
                onTap: () {
                  context.go('/parcel-delivery');
                },
                child: Image.asset(
                  logo,
                ))
            // :
            // InkWell(
            //     onTap: () {
            //       openDrawerHome();
            //     },
            //     child: Icon(Icons.sort)),
            : (MediaQuery.of(context).size.width <= 1100 &&
                        widget.path == '/about') ||
                    (MediaQuery.of(context).size.width <= 1100 &&
                        widget.path == '/profile') ||
                    (MediaQuery.of(context).size.width <= 1100 &&
                        widget.path == '/terms') ||
                    (MediaQuery.of(context).size.width <= 1100 &&
                        widget.path == '/policy') ||
                    (MediaQuery.of(context).size.width <= 1100 &&
                        widget.path == '/wallet') ||
                    (MediaQuery.of(context).size.width <= 1100 &&
                        widget.path == '/orders') ||
                    (MediaQuery.of(context).size.width <= 1100 &&
                        widget.path == '/parcel-delivery/favorites') ||
                    (MediaQuery.of(context).size.width <= 1100 &&
                        widget.path == '/voucher') ||
                    (MediaQuery.of(context).size.width <= 1100 &&
                        widget.path == '/inbox') ||
                    (MediaQuery.of(context).size.width <= 1100 &&
                        widget.path == '/delivery-addresses') ||
                    (MediaQuery.of(context).size.width <= 1100 &&
                        widget.path.contains('/order-detail') == true) ||
                    (MediaQuery.of(context).size.width <= 1100 &&
                        widget.path.contains('/faq') == true) ||
                    widget.path.contains('/checkout') == true
                ? InkWell(
                    onTap: () {
                      if (widget.path.contains('/order-detail')) {
                        context.push('/orders');
                      } else {
                        context.push('/parcel-delivery');
                      }
                    },
                    child: const Icon(Icons.arrow_back))
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                        hoverColor: Colors.transparent,
                        onTap: () {
                          context.go('/parcel-delivery');
                        },
                        child: Image.asset(
                          logo,
                          height: 100,
                          width: 100,
                        )),
                  ),
        title: MediaQuery.of(context).size.width >= 1100
            ? SizedBox.shrink()
            : (MediaQuery.of(context).size.width <= 1100 &&
                        widget.path == '/about') ||
                    (MediaQuery.of(context).size.width <= 1100 &&
                        widget.path == '/profile') ||
                    (MediaQuery.of(context).size.width <= 1100 &&
                        widget.path == '/terms') ||
                    (MediaQuery.of(context).size.width <= 1100 &&
                        widget.path == '/policy') ||
                    (MediaQuery.of(context).size.width <= 1100 &&
                        widget.path == '/wallet') ||
                    (MediaQuery.of(context).size.width <= 1100 &&
                        widget.path == '/orders') ||
                    (MediaQuery.of(context).size.width <= 1100 &&
                        widget.path == '/parcel-delivery/favorites') ||
                    (MediaQuery.of(context).size.width <= 1100 &&
                        widget.path == '/voucher') ||
                    (MediaQuery.of(context).size.width <= 1100 &&
                        widget.path == '/inbox') ||
                    (MediaQuery.of(context).size.width <= 1100 &&
                        widget.path == '/delivery-addresses') ||
                    (MediaQuery.of(context).size.width <= 1100 &&
                        widget.path.contains('/order-detail') == true) ||
                    (MediaQuery.of(context).size.width <= 1100 &&
                        widget.path.contains('/faq') == true) ||
                    widget.path.contains('/checkout') == true
                ? Text(routeName())
                : null,
        // SizedBox(
        //     height: 40,
        //     child: const SearchWidget(
        //       autoFocus: false,
        //     ),
        //   ),
        actions: [
          IconButton(
              onPressed: () {
                if (MediaQuery.of(context).size.width >= 1100) {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          content: SizedBox(
                              width: MediaQuery.of(context).size.width >= 1100
                                  ? MediaQuery.of(context).size.width / 3
                                  : MediaQuery.of(context).size.width / 1.3,
                              height: MediaQuery.of(context).size.height / 1.5,
                              child: const LanguageWidget()),
                        );
                      });
                } else {
                  modalSheet.showBarModalBottomSheet(
                      expand: true,
                      bounce: true,
                      context: context,
                      backgroundColor: Colors.transparent,
                      builder: (context) {
                        return const Scaffold(body: LanguageWidget());
                      });
                }
              },
              icon: const Icon(Icons.language)),
          if (MediaQuery.of(context).size.width >= 1100) const Gap(10),
          MediaQuery.of(context).size.width >= 1100
              ? DropdownButtonHideUnderline(
                  child: DropdownButton2(
                    dropdownStyleData: const DropdownStyleData(width: 200),
                    isExpanded: true,
                    customButton: Row(
                      children: [
                        Badge(
                          largeSize: 13,
                          smallSize: 10,
                          // padding: EdgeInsets.all(10),
                          isLabelVisible:
                              getAuthListener == true ? true : false,
                          //   padding: EdgeInsets.only(top: 3),
                          backgroundColor: appColor,
                          alignment: Alignment.centerRight,
                          label: const Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 6,
                          ),
                          child: const Icon(
                            Icons.person_outline_outlined,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          getAuthListener == true
                              ? '$hi, ${getFullName ?? ''}'
                              : account,
                          style: TextStyle(
                              fontSize: 4.sp, fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        const Icon(
                          Icons.arrow_drop_down_outlined,
                          //  color: Color.fromRGBO(48, 30, 2, 1),
                        ),
                      ],
                    ),
                    items: [
                      ...MenuItems.firstItems.map(
                        (item) => DropdownMenuItem<MenuItem>(
                          value: item,
                          child: MenuItems.buildItem(item),
                        ),
                      ),
                      const DropdownMenuItem<Divider>(
                          enabled: false, child: Divider()),
                      if (getAuthListener == true)
                        ...MenuItems.secondItems.map(
                          (item) => DropdownMenuItem<MenuItem>(
                            value: item,
                            child: MenuItems.buildItem(item),
                          ),
                        ),
                      if (getAuthListener == false)
                        ...MenuItems.secondItems2.map(
                          (item) => DropdownMenuItem<MenuItem>(
                            value: item,
                            child: MenuItems.buildItem(item),
                          ),
                        ),
                    ],
                    value: selectedValue,
                    onChanged: (value) {
                      MenuItems.onChanged(
                          context, value! as MenuItem, '/parcel-delivery');
                    },
                  ),
                )
              : Badge(
                  isLabelVisible: getAuthListener == true ? true : false,
                  backgroundColor: appColor,
                  alignment: Alignment.centerRight,
                  label: const Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 8,
                  ),
                  child: IconButton(
                      onPressed: () {
                        if (getAuthListener == true) {
                          context.go('/profile');
                        } else {
                          context.go('/login');
                        }
                      },
                      icon: const Icon(Icons.person_outline)),
                ),
          const Gap(10),
        
          if (MediaQuery.of(context).size.width >= 1100)
            AdaptiveTheme.of(context).mode.isDark == true
                ? InkWell(
                    onTap: () {
                      AdaptiveTheme.of(context).setLight();
                    },
                    child: const Icon(Icons.light_mode))
                : InkWell(
                    onTap: () {
                      AdaptiveTheme.of(context).setDark();
                    },
                    child: const Icon(Icons.dark_mode)),
          if (MediaQuery.of(context).size.width >= 1100) const Gap(100)
        ],
        // bottom: MediaQuery.of(context).size.width >= 1100
        //     ? null
        //     : const PreferredSize(
        //         preferredSize: Size.fromHeight(50),
        //         child: Center(
        //           child: Padding(
        //             padding: EdgeInsets.only(left: 8, right: 8, bottom: 5),
        //             child: SizedBox(
        //                 height: 40, child: SearchWidget(autoFocus: false)),
        //           ),
        //         ))
      ),
      body: widget.body,
    );
  }
}

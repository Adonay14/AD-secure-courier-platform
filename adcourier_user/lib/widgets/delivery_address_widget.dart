import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:logger/logger.dart';
import 'package:shimmer/shimmer.dart';
import 'package:user_web/model/address.dart';
import 'package:user_web/constant.dart';
import 'package:user_web/providers/addresses_page_provider.dart';
import 'package:user_web/widgets/add_delivery_address.dart';

class DeliveryAddressWidget extends ConsumerStatefulWidget {
  const DeliveryAddressWidget({super.key});

  @override
  ConsumerState<DeliveryAddressWidget> createState() =>
      _DeliveryAddressWidgetState();
}

class _DeliveryAddressWidgetState extends ConsumerState<DeliveryAddressWidget> {
  @override
  void initState() {
    super.initState();
  }
var logger = Logger();
  @override
  Widget build(BuildContext context) {
    var addresses = ref.watch(getDeliveryAddressesProvider).value;
    logger.d(addresses);
    var addressID = ref.watch(getUserDeliveryAddressIDProvider).value;
    return SingleChildScrollView(
      child: Column(
        children: [
          const Gap(10),
          Padding(
            padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width >= 1100 ? 8 : 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Delivery Addresses',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize:
                          MediaQuery.of(context).size.width >= 1100 ? 15 : 15),
                ).tr(),
                TextButton.icon(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const AddDeliveryAddress();
                      }));
                    },
                    icon: const Icon(Icons.add),
                    label: const Text('Add New Address').tr())
              ],
            ),
          ),
          // if (MediaQuery.of(context).size.width >= 1100)
          const Divider(
            color: Color.fromARGB(255, 237, 235, 235),
            thickness: 1,
          ),
          const Gap(20),
          addresses != null
              ? addresses.isEmpty
                  ? Center(
                      child: Icon(
                        Icons.delivery_dining_outlined,
                        color: appColor,
                        size: MediaQuery.of(context).size.width >= 1100
                            ? MediaQuery.of(context).size.width / 5
                            : MediaQuery.of(context).size.width / 1.5,
                      ),
                    )
                  : GridView.builder(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: addresses.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio:
                            MediaQuery.of(context).size.width >= 1100
                                ? 1.7
                                : 1.6,
                        crossAxisCount:
                            MediaQuery.of(context).size.width >= 1100 ? 2 : 1,
                        crossAxisSpacing: 8.0,
                        mainAxisSpacing: 8.0,
                      ),
                      itemBuilder: (context, index) {
                        AddressModel addressModel = addresses[index];

                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey,
                                ),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(5))),
                            child: Column(children: [
                              const Gap(10),
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    addressID == addressModel.id
                                        ? Expanded(
                                            flex: 4,
                                            child: const Text('Default Address')
                                                .tr())
                                        : Expanded(
                                            flex: 4,
                                            child: InkWell(
                                                hoverColor: Colors.transparent,
                                                onTap: () {
                                                  final FirebaseAuth auth =
                                                      FirebaseAuth.instance;
                                                  User? user = auth.currentUser;
                                                  FirebaseFirestore.instance
                                                      .collection('users')
                                                      .doc(user!.uid)
                                                      .update({
                                                    'DeliveryAddress':
                                                        addressModel.address,
                                                    'HouseNumber': addressModel
                                                        .houseNumber,
                                                    'ClosestBustStop':
                                                        addressModel
                                                            .closestbusStop,
                                                    'DeliveryAddressID':
                                                        addressModel.id
                                                  });
                                                  Fluttertoast.showToast(
                                                      msg:
                                                          "Address has been added"
                                                              .tr(),
                                                      toastLength:
                                                          Toast.LENGTH_SHORT,
                                                      gravity: ToastGravity.TOP,
                                                      timeInSecForIosWeb: 1,
                                                      fontSize: 14.0);
                                                },
                                                child: const Text(
                                                    'Set As Default'))),
                                    Expanded(
                                      flex: 3,
                                      child: addressID == addressModel.id
                                          ? const SizedBox()
                                          : InkWell(
                                              hoverColor: Colors.transparent,
                                              // style: OutlinedButton.styleFrom(
                                              //   shape:
                                              //       const BeveledRectangleBorder(),
                                              // ),
                                              onTap: () {
                                                final FirebaseAuth auth =
                                                    FirebaseAuth.instance;
                                                User? user = auth.currentUser;
                                                FirebaseFirestore.instance
                                                    .collection('users')
                                                    .doc(user!.uid)
                                                    .collection(
                                                        'DeliveryAddress')
                                                    .doc(addressModel.uid)
                                                    .delete()
                                                    .then((value) {
                                                  Fluttertoast.showToast(
                                                      msg:
                                                          "Address has been deleted"
                                                              .tr(),
                                                      toastLength:
                                                          Toast.LENGTH_SHORT,
                                                      gravity: ToastGravity.TOP,
                                                      timeInSecForIosWeb: 1,
                                                      fontSize: 14.0);
                                                });
                                              },
                                              child: Align(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: const Text(
                                                  'Delete',
                                                  style: TextStyle(),
                                                ).tr(),
                                              )),
                                    ),
                                    const Gap(5)
                                  ],
                                ),
                              ),
                              ListTile(
                                dense: true,
                                visualDensity:
                                    const VisualDensity(vertical: -4),
                                leading: const Icon(Icons.room),
                                title: Text(
                                  addressModel.address,
                                  maxLines: 1,
                                  style: const TextStyle(fontSize: 12),
                                ),
                              ),
                              const Divider(
                                endIndent: 20,
                                indent: 20,
                              ),
                              ListTile(
                                dense: true,
                                visualDensity:
                                    const VisualDensity(vertical: -4),
                                leading: const Icon(Icons.home),
                                title: Text(addressModel.houseNumber,
                                    maxLines: 1,
                                    style: const TextStyle(fontSize: 12)),
                              ),
                              const Divider(
                                endIndent: 20,
                                indent: 20,
                              ),
                              ListTile(
                                dense: true,
                                visualDensity:
                                    const VisualDensity(vertical: -4),
                                title: Text(addressModel.closestbusStop,
                                    maxLines: 1,
                                    style: const TextStyle(fontSize: 12)),
                                leading: const Icon(Icons.bus_alert),
                              )
                            ]),
                          ),
                        );
                      })
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.builder(
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio:
                          MediaQuery.of(context).size.width >= 1100 ? 1.5 : 2,
                      crossAxisCount:
                          MediaQuery.of(context).size.width >= 1100 ? 2 : 1,
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 8.0,
                    ),
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          // height: 200,
                          // width: 300,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            color: Colors.white,
                          ),
                        ),
                      );
                    },
                  ),
                )
        ],
      ),
    );
  }
}

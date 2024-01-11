import 'dart:io';
import 'package:choosifoodi/core/utils/app_color_utils.dart';
import 'package:choosifoodi/core/utils/app_images_utils.dart';
import 'package:choosifoodi/core/widgets/widget_button.dart';
import 'package:choosifoodi/core/widgets/widget_text.dart';
import 'package:choosifoodi/screens/address/view/new_address_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/utils/app_constants.dart';
import '../../../core/utils/app_font_utils.dart';
import '../../../core/utils/app_preferences.dart';
import '../../../core/utils/app_strings_constants.dart';
import '../../../core/utils/networkManager.dart';
import '../../../core/widgets/widget_card.dart';
import '../../../core/widgets/widget_round_radio_button.dart';
import '../../cart/controller/menu_cart_controller.dart';
import '../../home/controller/user_home_controller.dart';
import '../../order_checkout/controller/payment_controller.dart';
import '../../order_checkout/view/online_card_screen.dart';
import '../controller/address_controller.dart';
import 'edit_address_screen.dart';

class AddressScreen extends StatefulWidget {
  var cartId, totalAmount, restaurantName, timeSlot;

  AddressScreen(this.cartId, this.totalAmount, this.restaurantName, this.timeSlot);

  @override
  _AddressScreenState createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final AddressController addressController = Get.put(AddressController());
  final PaymentController paymentController = Get.put(PaymentController());
  final MenuCartController menuCartController = Get.put(MenuCartController());
  final UserHomeController userHomeController = Get.put(UserHomeController());
  var addressId, deviceType;
  // create an instance
  final GetXNetworkManager _networkManager = Get.put(GetXNetworkManager());
  dynamic totalAmount;

  @override
  void initState() {
    if (_networkManager.connectionType != 0) {
      getDeviceType();
      print('widget.totalAmount: ${widget.totalAmount}');
      if(widget.totalAmount != null) {
        if (widget.totalAmount != "") {
          dynamic total = (widget.totalAmount * 100).toInt();
          print('total: $total');
          totalAmount = total;
          print('TotalAmount: $totalAmount');
          print('totalAmount: ${widget.totalAmount}');
        }
      }
      addressController.callGetAddressAPI();
      if(addressController.getAddressModel.data == null){
        addressController.checkAddressData();
        AppPreferences.setAddressId("");
        // checkAddressData();
      }
    }
    super.initState();
  }

  getDeviceType(){
    setState(() {
      if(Platform.isIOS){
        deviceType = 'ios' ;
        print('DeviceType: $deviceType');
      }else if(Platform.isAndroid){
        deviceType = 'android' ;
        print('DeviceType: $deviceType');
      }
    });
  }

  @override
  void dispose() {
    if(addressController.getAddressModel.data == null){
      AppPreferences.setAddressId("");
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(WHITE),
      appBar: WidgetAppbar.simpleAppBar(context, selDelAddress,true ),
      body: SafeArea(
          child: GetBuilder<GetXNetworkManager>(builder: (networkManager) {
        return networkManager.connectionType == 0
            ? Center(child: Text(check_internet))
            : Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: ListView(
                      physics: BouncingScrollPhysics(),
                      children: [
                        GetBuilder<AddressController>(builder: (logic) {
                          return logic.isLoaderVisible
                              ? Center(
                                  child: CircularProgressIndicator(
                                  color: Color(ORANGE),
                                ))
                              : addressController
                                          .getAddressModel.meta?.status ==
                                      false
                                  ? Center(
                                      child: Container(
                                      // margin: EdgeInsets.only(top: 20),
                                      // child: Text('Address not available'),
                                    ))
                                  : ListView.builder(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount:
                                          logic.getAddressModel.data?.length,
                                      itemBuilder: (context, index) {
                                        var addressline1,
                                            landmark,
                                            cityName,
                                            statename,
                                            pincode,
                                            totalAddress;
                                        if (logic.getAddressModel.data?[index]
                                                .addressLine1 !=
                                            null) {
                                          addressline1 = logic.getAddressModel
                                                  .data![index].addressLine1
                                                  .toString();
                                        } else {
                                          addressline1 = "";
                                        }

                                        if (logic.getAddressModel.data?[index]
                                                .landmark !=
                                            null) {
                                          landmark = logic.getAddressModel
                                                  .data![index].landmark
                                                  .toString() +
                                              ", ";
                                        } else {
                                          landmark = "";
                                        }

                                        if (logic.getAddressModel.data?[index]
                                                .cityName !=
                                            null) {
                                          cityName = logic.getAddressModel
                                                  .data![index].cityName
                                                  .toString() +
                                              ", ";
                                        } else {
                                          cityName = "";
                                        }

                                        if (logic.getAddressModel.data?[index]
                                                .stateName !=
                                            null) {
                                          statename = logic.getAddressModel
                                                  .data![index].stateName
                                                  .toString() +
                                              ", ";
                                        } else {
                                          statename = "";
                                        }

                                        if (logic.getAddressModel.data?[index]
                                                .stateName !=
                                            null) {
                                          pincode = logic.getAddressModel
                                              .data?[index].pincode
                                              .toString();
                                        } else {
                                          pincode = "";
                                        }

                                        totalAddress = addressline1 +
                                            landmark +
                                            cityName +
                                            statename +
                                            pincode;

                                        if (logic.getAddressModel.data?[index].isDefault == true) {
                                          if (logic.getAddressModel.data?[index].addressId != null) {

                                            print('Check emptyAddress : ${logic.emptyAddress}');
                                            print('Check DefaultAddressId : ${logic.getAddressModel.data?[index].isDefault}');
                                            addressId = logic.getAddressModel
                                                .data?[index].addressId
                                                .toString();
                                            AppPreferences.setAddressId(addressId!);
                                          }
                                        }

                                        return Container(
                                            padding: EdgeInsets.fromLTRB(
                                                15, 15, 15, 0),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                GestureDetector(
                                                  onTap: () async {
                                                    logic.isLoaderVisible =
                                                        true;
                                                    addressId = logic
                                                        .getAddressModel
                                                        .data?[index]
                                                        .addressId
                                                        .toString();
                                                    await logic
                                                        .callDefaultAddressAPI(addressId: addressId);
                                                    setState(() {
                                                      if (logic
                                                              .getAddressModel
                                                              .data?[index]
                                                              .isDefault ==
                                                          true) {
                                                        logic
                                                            .getAddressModel
                                                            .data?[index]
                                                            .setChecked = false;
                                                      } else {
                                                        logic
                                                            .getAddressModel
                                                            .data?[index]
                                                            .setChecked = true;
                                                      }

                                                      if (logic
                                                          .isAddressChanged) {
                                                        setState(() {
                                                          logic.isAddressChanged =
                                                              false;
                                                        });
                                                      }
                                                    });
                                                  },
                                                  child: logic
                                                              .getAddressModel
                                                              .data?[index]
                                                              .isDefault ==
                                                          true
                                                      ? WidgetRoundRadioButton
                                                          .selectRoundRadioButton(
                                                              "")
                                                      : WidgetRoundRadioButton
                                                          .unselectedRoundRadioButton(
                                                              ""),
                                                ),
                                                /* Radio(
                                           value: logic.getAddressModel.data?[index].addressId,
                                           groupValue:  logic.getAddressModel.data?[index].isDefault,
                                           activeColor: Colors.orange,
                                           toggleable: true,
                                           onChanged: (dynamic value){
                                             print('Value: $value');
                                           },
                                         ),*/
                                                SizedBox(
                                                  width: 15,
                                                ),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      logic
                                                                  .getAddressModel
                                                                  .data?[index]
                                                                  .name ==
                                                              null
                                                          ? Text('')
                                                          : WidgetText
                                                              .widgetPoppinsMediumText(
                                                              logic
                                                                  .getAddressModel.data?[index].name.toString() ?? "",
                                                              Color(BLACK),
                                                              14,
                                                            ),
                                                      logic
                                                                  .getAddressModel
                                                                  .data?[index]
                                                                  .mobile ==
                                                              null
                                                          ? Text('')
                                                          : WidgetText
                                                              .widgetPoppinsRegularText(
                                                              "+1 ${logic.getAddressModel
                                                                  .data?[index].mobile ?? ""}",
                                                              Color(BLACK4),
                                                              12,
                                                            ),
                                                      WidgetText
                                                          .widgetPoppinsRegularText(
                                                        totalAddress,
                                                        Color(BLACK4),
                                                        12,
                                                      ),
                                                      SizedBox(
                                                        height: 15,
                                                      ),
                                                      Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          InkWell(
                                                            onTap: () async {
                                                              final newValue =
                                                                  await Get.to(() =>
                                                                      EditAddressScreen(
                                                                        getAddressModel:
                                                                            logic.getAddressModel,
                                                                        index:
                                                                            index,
                                                                      ));
                                                              addressController.callGetAddressAPI();
                                                              // setState(() {
                                                              //   print(
                                                              //       'NewValue: $newValue');
                                                              //   addressController.callGetAddressAPI();
                                                              // });
                                                            },
                                                            child: Container(
                                                              width: 70,
                                                              height: 35,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Color(
                                                                    ORANGE),
                                                                shape: BoxShape
                                                                    .rectangle,
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            7)),
                                                              ),
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              child: WidgetText
                                                                  .widgetPoppinsRegularText(
                                                                "Edit",
                                                                Color(WHITE),
                                                                12,
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 15,
                                                          ),
                                                          logic.getAddressModel.data?[index].isAddressDelete ==
                                                                  false
                                                              ? InkWell(
                                                                  onTap: () async {
                                                                    setState(
                                                                        () {
                                                                      logic
                                                                          .getAddressModel
                                                                          .data?[index]
                                                                          .isAddressDelete = true;
                                                                    });
                                                                    await logic.deleteAddressAPI(
                                                                        addressId: logic
                                                                            .getAddressModel
                                                                            .data?[index]
                                                                            .addressId
                                                                            .toString() ?? "");
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    width: 70,
                                                                    height: 35,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: Color(
                                                                          0xffE0E0E0),
                                                                      shape: BoxShape
                                                                          .rectangle,
                                                                      borderRadius:
                                                                          BorderRadius.all(
                                                                              Radius.circular(7)),
                                                                    ),
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    child: WidgetText
                                                                        .widgetPoppinsRegularText(
                                                                      "Delete",
                                                                      Color(
                                                                          BLACK),
                                                                      12,
                                                                    ),
                                                                  ),
                                                                )
                                                              : Center(
                                                                  child: Container(
                                                                      height: 20,
                                                                      width: 20,
                                                                      child: CircularProgressIndicator(
                                                                        color: Color(
                                                                            ORANGE),
                                                                      )),
                                                                ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 15,
                                                      ),
                                                      Divider(
                                                          height: 1,
                                                          thickness: 1,
                                                          color: Color(
                                                              DIVIDERCOLOR)),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ));
                                      });
                        }),
                        SizedBox(
                          height: 15,
                        ),
                        InkWell(
                          onTap: onClickAddNewAddress,
                          child: Card(
                            elevation: 2,
                            color: Color(WHITE),
                            shadowColor: Color(GREY2),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0.0),
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color(WHITE),
                                borderRadius: BorderRadius.all(Radius.circular(5)),
                              ),
                              padding: EdgeInsets.all(15),
                              child: Row(
                                children: [
                                  Image.asset(
                                    ic_increase,
                                    color: Color(ORANGE),
                                    height: 15,
                                    width: 15,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: WidgetText.widgetPoppinsRegularText(
                                      addNewAddress,
                                      Color(BLACK3),
                                      16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                    flex: 1,
                    fit: FlexFit.tight,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(15, 10, 15, 0),
                    child: WidgetButton.widgetDefaultButton(
                        // "Proceed to checkout", onClickProcessToCheckOut),
                        "Proceed to checkout", () {
                      dynamic addressLen;
                      if(addressController.getAddressModel.meta?.status == true) {
                        if (addressController.getAddressModel.data!.isNotEmpty) {
                          if (addressController.getAddressModel.data != null) {
                          //   addressLen =
                          //       addressController.getAddressModel.data?.length;
                          // }
                          for (int i = 0; i < (addressController.getAddressModel.data?.length ?? 0); i++) {
                            if (addressController.getAddressModel.data?[i]
                                .isDefault == true) {
                              addressId =
                                  addressController.getAddressModel.data?[i]
                                      .addressId;
                              print('AddressId: $addressId');
                              dynamic date = DateTime
                                  .now()
                                  .millisecondsSinceEpoch;
                              print('date: $date');
                              if (addressId != null) {
                                showEditServeDialog(
                                    mContext: context,
                                    cartId: widget.cartId,
                                    date: date);
                              } else {
                                showToastMessage('Please Select Default Address');
                              }
                            }
                          }
                          }else {
                            showToastMessage('Please Add and select Default Address');
                          }
                        }else {
                          showToastMessage('Please Add and select Default Address');
                        }
                      }else {
                        showToastMessage('Please Add and select Default Address');
                      }
                    /*  if(addressLen != 0 || addressLen != null) {

                      }else {
                        showToastMessage('Please Add and select Default Address');
                      }*/
                    }),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                ],
              );
      })),
    );
  }

  onClickAddNewAddress() async {
    final newValue = await Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => NewAddressScreen()));
    print('NewValue: $newValue');
    addressController.callGetAddressAPI();
  }

  void showEditServeDialog(
      {required BuildContext mContext,
      required String cartId,
      required dynamic date}) {
    TextEditingController spReqController = TextEditingController();
    String radioButtonItem = 'Cash On Delivery';
    // int id = 1;

    showDialog(
        context: mContext,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, StateSetter setState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              child: Container(
                // height: 300,
                padding: EdgeInsets.all(10),
                child: ListView(
                  shrinkWrap: true,
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        WidgetText.widgetPoppinsMediumText(
                          'Choose Payment Method',
                          Color(BLACK),
                          16,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Card(
                            elevation: 5,
                            color: Color(WHITE),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Container(
                              padding: EdgeInsets.all(5),
                              child: Image.asset(
                                ic_cross,
                                height: 20,
                                width: 20,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Card(
                      margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
                      elevation: 5,
                      color: Color(WHITE),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Container(
                        padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                        child: TextFormField(
                          controller: spReqController,
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintStyle: TextStyle(
                              color: Color(0xff8C8989),
                              fontSize: 16,
                              fontFamily: FontPoppins,
                              fontWeight: PoppinsRegular,
                            ),
                            hintText: "Enter your special request",
                          ),
                          style: TextStyle(
                            color: Color(0xff3E4958),
                            fontSize: 16,
                            fontFamily: FontPoppins,
                            fontWeight: PoppinsRegular,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    GetBuilder<PaymentController>(builder: (logic) {
                      return Row(
                        children: [
                          Expanded(
                              child: WidgetButton.widgetDefaultButton(cancel, () {
                            Navigator.pop(context);
                          })),
                          SizedBox(
                            width: 10,
                          ),
                          logic.isPaymentPosted == false
                              ? Expanded(
                                  child: WidgetButton.widgetDefaultButton(
                                      "Submit", () async {
                                    if (cartId != "") {
                                        // showToastMessage('Please Select Cash on Delivery');
                                          await Get.to(() =>
                                              CardPaymentScreen(
                                                isGroupPayment: false,
                                                addressId: addressId,
                                                date: date.toString(),
                                                orderType: delivery,
                                                spReq: spReqController.text,
                                                amount: totalAmount,
                                                restaurantName: widget.restaurantName,
                                                timeSlot: widget.timeSlot,
                                              ));
                                    }else{
                                      showToastMessage('Please add food in the cart first');
                                    }
                                  }
                                  ))
                              : Center(
                                  child: CircularProgressIndicator(
                                  color: Color(ORANGE),
                                )),
                        ],
                      );
                    })
                  ],
                ),
              ),
            );
          });
        });
  }
}

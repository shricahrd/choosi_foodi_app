import 'package:choosifoodi/core/utils/app_color_utils.dart';
import 'package:choosifoodi/core/utils/app_images_utils.dart';
import 'package:choosifoodi/core/widgets/widget_text.dart';
import 'package:choosifoodi/screens/restaurants_panel/deals/view/add_edit_deals_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/utils/app_strings_constants.dart';
import '../../../../../core/utils/networkManager.dart';
import '../../../../core/widgets/widget_card.dart';
import '../controller/coupon_list_controller.dart';

class DealDetailsScreen extends StatefulWidget {
  dynamic serialNo;
  String couponId;

  DealDetailsScreen(this.serialNo, this.couponId);

  @override
  State<DealDetailsScreen> createState() => _DealScreenState(serialNo,couponId);
}

class _DealScreenState extends State<DealDetailsScreen> {
// create an instance
  final GetXNetworkManager _networkManager = Get.put(GetXNetworkManager());
  final CouponListController couponListController = Get.put(CouponListController());
  String couponId = "";
  dynamic couponType;
  bool isActive = false;
  dynamic serialNo;

  _DealScreenState(dynamic serialNo, String couponId) {
    this.serialNo = serialNo;
    this.couponId = couponId;
  }


  @override
  void initState() {
    print('couponId : $couponId');
    if (_networkManager.connectionType != 0) {
      print('Connection Type: ${_networkManager.connectionType}');
      callApi();
    }
    super.initState();
  }

  callApi(){
    setState(() {
      couponListController.isLoaderDetailsVisible = true;
    });
    if(couponId.isNotEmpty) {
      couponListController.getCouponDetails( couponId);
    }
  }

  // bool isChecked = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(WHITE),
      appBar: WidgetAppbar.simpleAppBar(context, details, true ),
      body: SafeArea(
          child: GetBuilder<GetXNetworkManager>(builder: (networkManager) {
        return networkManager.connectionType == 0
            ? Center(child: Text(check_internet))
            : GetBuilder<CouponListController>(builder: (logic) {
                return
                  logic.isLoaderDetailsVisible == true?
                  Center(
                    child: CircularProgressIndicator(
                      color: Color(ORANGE),
                    ),
                  ): logic.getCouponDetailsModel.meta?.status == false ?
                  Center(
                      child: Container(
                        child: Text('No Data Found'),
                      )):
                  ListView(
                  shrinkWrap: true,
                  children: [
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      // height: 210,
                      width: double.infinity,
                      child: InkWell(
                        child: Card(
                          margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                          color: Color(WHITE),
                          elevation: 5.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          shadowColor: Color(BLACK),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Color(WHITE),
                                borderRadius: BorderRadius.circular(10.0)),
                            padding: EdgeInsets.all(15),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    WidgetText.widgetPoppinsRegularText(
                                        sno + ": ", Color(GREY3), 14),
                                    WidgetText.widgetPoppinsRegularText(
                                        serialNo.toString(), Color(BLACK), 14),
                                    Spacer(),
                                    WidgetText.widgetPoppinsRegularText(
                                        coupon_name + ": ", Color(GREY3), 14),
                                    WidgetText.widgetPoppinsRegularText(
                                        // "Test8",
                                        logic.getCouponDetailsModel.data?.couponName.toString() ?? "",
                                        Color(BLACK), 14),
                                  ],
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                                  padding: EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                    color: Color(WHITE),
                                    shape: BoxShape.rectangle,
                                    border: Border.all(
                                        color: Color(ORANGE), width: 1),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(18.0),
                                        child: Container(
                                          width: double.infinity,
                                          height: 180,
                                          child:
                                          imageFromNetworkCache(logic.getCouponDetailsModel.data?.couponImg.toString() ?? "",
                                              height: 180),
                                        )
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              WidgetText
                                                  .widgetPoppinsRegularText(
                                                      coupon_type,
                                                      Color(GREY3),
                                                      14),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              WidgetText.widgetPoppinsMediumText(
                                                  // "Offer With Perodic & cart",
                                                  logic.couponType,
                                                  Color(BLACK2),
                                                  14),
                                            ],
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              WidgetText.widgetRobotoMediumText(
                                                  // '200',
                                                  // logic.getCouponDetailsModel.data?.discount.toString() ?? "",
                                                  logic.getCouponDetailsModel.data?.discountIn == "ABSOLUTE" ?
                                                  "\$${logic.getCouponDetailsModel.data?.discount.toString() ?? ""}":
                                                  "${logic.getCouponDetailsModel.data?.discount.toString() ?? ""}%",
                                                  Color(ORANGE), 16),
                                              WidgetText
                                                  .widgetPoppinsRegularText(
                                                      "(Discount)",
                                                      Color(GREY3),
                                                      12),
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      WidgetText.widgetPoppinsRegularText(
                                          audience, Color(GREY3), 14),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      WidgetText.widgetRobotoMediumText(
                                          // "For All Customers",
                                          logic.getCouponDetailsModel.data?.couponFor.toString() ?? "",
                                          Color(BLACK2),
                                          14),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      WidgetText.widgetPoppinsRegularText(
                                          discount_in, Color(GREY3), 14),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      WidgetText.widgetRobotoMediumText(
                                          // "ABSOLUTE",
                                          logic.getCouponDetailsModel.data?.discountIn ?? "",
                                          Color(BLACK2), 14),
                                      SizedBox(
                                        height: 15,
                                      ),
                               /*       WidgetText.widgetPoppinsRegularText(
                                          show_in_app, Color(GREY3), 14),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      WidgetText.widgetRobotoMediumText(
                                          logic.getCouponDetailsModel.data?.showInApp == true ?
                                          "Yes" : "No", Color(BLACK2), 14),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      WidgetText.widgetPoppinsRegularText(
                                          max_discount, Color(GREY3), 14),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      WidgetText.widgetRobotoMediumText(
                                          logic.getCouponDetailsModel.data?.maxDiscount.toString() ?? "",
                                          Color(BLACK2), 14),
                                      SizedBox(
                                        height: 15,
                                      ),*/
                                      WidgetText.widgetPoppinsRegularText(
                                          desc, Color(GREY3), 14),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      WidgetText.widgetRobotoMediumText(
                                          logic.getCouponDetailsModel.data?.description.toString().replaceAll(RegExp(r'<[^>]*>|&[^;]+;'), ' ') ?? "",
                                          Color(BLACK2), 14),
                                      SizedBox(
                                        height: 15,
                                      ),

                                      // couponType == "STATIC" ?
                                      logic.getCouponDetailsModel.data?.couponType == "STATIC" ||
                                          logic.getCouponDetailsModel.data?.couponType == "STATIC_CART" ||
                                              logic.getCouponDetailsModel.data?.couponType == "STATIC_PERIOD" ||
                                          logic.getCouponDetailsModel.data?.couponType == "STATIC_PERIOD_CART"
                                          ? Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                       /*       WidgetText.widgetPoppinsRegularText(
                                                  useCount, Color(GREY3), 14),
                                              SizedBox(
                                                height: 8,
                                              ),
                                              WidgetText.widgetRobotoMediumText(
                                                  logic.getCouponDetailsModel.data?.useCount.toString() ?? "",
                                                  Color(BLACK2), 14),
                                              SizedBox(
                                                height: 15,
                                              ),*/
                                              WidgetText.widgetPoppinsRegularText(
                                                  perUseCount, Color(GREY3), 14),
                                              SizedBox(
                                                height: 8,
                                              ),
                                              WidgetText.widgetRobotoMediumText(
                                                  logic.getCouponDetailsModel.data?.perUserUseCount.toString() ?? "",
                                                  Color(BLACK2), 14),
                                              SizedBox(
                                                height: 15,
                                              ),
                                            ],
                                          ) : Container(),

                                      logic.getCouponDetailsModel.data?.couponType == "STATIC_CART" ||
                                      logic.getCouponDetailsModel.data?.couponType == "STATIC_PERIOD_CART" ||
                                      logic.getCouponDetailsModel.data?.couponType == "OFFER_CART" ||
                                      logic.getCouponDetailsModel.data?.couponType == "OFFER_PERIOD_CART" ?
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          WidgetText.widgetPoppinsRegularText(
                                              min_spend, Color(GREY3), 14),
                                          SizedBox(
                                            height: 8,
                                          ),
                                          WidgetText.widgetRobotoMediumText(
                                              // "10",
                                              "\$${logic.getCouponDetailsModel.data?.minCartAmount.toString() ?? ""}",
                                              Color(BLACK2), 14),
                                          SizedBox(
                                            height: 15,
                                          ),
                                      /*    WidgetText.widgetPoppinsRegularText(
                                              max_cart_amount, Color(GREY3), 14),
                                          SizedBox(
                                            height: 8,
                                          ),
                                          WidgetText.widgetRobotoMediumText(
                                              // "100",
                                              logic.getCouponDetailsModel.data?.maxCartAmount.toString() ?? "",
                                              Color(BLACK2), 14),
                                          SizedBox(
                                            height: 15,
                                          ),*/
                                        ],
                                      ): Container(),

                      /*                logic.getCouponDetailsModel.data?.couponType == "OFFER" ||
                                      logic.getCouponDetailsModel.data?.couponType == "OFFER_CART" ||
                                      logic.getCouponDetailsModel.data?.couponType == "OFFER_PERIOD" ||
                                      logic.getCouponDetailsModel.data?.couponType == "OFFER_PERIOD_CART" ?
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          WidgetText.widgetPoppinsRegularText(
                                              total_coupon, Color(GREY3), 14),
                                          SizedBox(
                                            height: 8,
                                          ),
                                          WidgetText.widgetRobotoMediumText(
                                              // "10",
                                              logic.getCouponDetailsModel.data?.totalCoupon.toString() ?? "",
                                              Color(BLACK2), 14),
                                          SizedBox(
                                            height: 15,
                                          ),
                                        ],
                                      ): Container(),*/

                                      logic.getCouponDetailsModel.data?.couponType == "STATIC_PERIOD" ||
                                          logic.getCouponDetailsModel.data?.couponType == "STATIC_PERIOD_CART" ||
                                          logic.getCouponDetailsModel.data?.couponType == "OFFER_PERIOD" ||
                                          logic.getCouponDetailsModel.data?.couponType == "OFFER_PERIOD_CART" ?
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          WidgetText.widgetPoppinsRegularText(
                                              issue_date, Color(GREY3), 14),
                                          SizedBox(
                                            height: 8,
                                          ),
                                          WidgetText.widgetRobotoMediumText(
                                              // "Jul 12, 2022",
                                              logic.filterStartDate,
                                              Color(BLACK2), 14),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          WidgetText.widgetPoppinsRegularText(
                                              expiry_date, Color(GREY3), 14),
                                          SizedBox(
                                            height: 8,
                                          ),
                                          WidgetText.widgetRobotoMediumText(
                                              // "Aug 12, 2022",
                                              logic.filterExpireDate,
                                              Color(BLACK2), 14),
                                          SizedBox(
                                            height: 15,
                                          ),
                                        ],
                                      ): Container(),

                                      WidgetText.widgetPoppinsRegularText(
                                          created, Color(GREY3), 14),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      WidgetText.widgetRobotoMediumText(
                                          logic.createdAt, Color(BLACK2), 14),
                                      SizedBox(
                                        height: 15,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    SizedBox(
                                      width: 10,
                                    ),
                                    InkWell(
                                      onTap: () async {
                                       await Get.to(() => AddEditDealScreen(isEdit: true,couponId: couponId,));
                                       callApi();
                                      },
                                      child: Container(
                                        width: 150,
                                        padding:
                                            EdgeInsets.fromLTRB(0, 10, 0, 10),
                                        decoration: BoxDecoration(
                                          color: Color(WHITE),
                                          shape: BoxShape.rectangle,
                                          border: Border.all(
                                              color: Color(ORANGE), width: 1),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(7)),
                                        ),
                                        alignment: Alignment.center,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              ic_edit_undeline,
                                              height: 10,
                                              width: 20,
                                              color: Color(ORANGE),
                                            ),
                                            WidgetText.widgetPoppinsMediumText(
                                              edit,
                                              Color(ORANGE),
                                              12,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),

                                    isActive == false?
                                    InkWell(
                                      onTap: () async {
                                        setState(()  {
                                          isActive = true;
                                       /*   if (logic.getCouponDetailsModel.data?.status == active) {
                                            isActive = true;
                                          } else {
                                            isActive = true;
                                          }*/
                                          print('checked:this ${logic.getCouponDetailsModel.data?.status}');
                                        });

                                        if (logic.getCouponDetailsModel.data?.status == active) {
                                          await logic.callStatusUpdateAPI(
                                            couponId: logic.getCouponDetailsModel.data?.couponId.toString() ?? "", status: deActive, );
                                          print('addToCartBool timer => ${logic.isStatusChanged}');
                                          if (logic.isStatusChanged == true) {
                                            var result = true;
                                            print('Result => $result');
                                            if (result) {
                                              setState(() {
                                                logic.getCouponDetails( couponId);
                                                isActive = false;
                                              });
                                            }
                                          }
                                        } else {
                                          await logic.callStatusUpdateAPI(
                                              couponId: logic.getCouponDetailsModel.data?.couponId.toString() ?? "", status: active);
                                          print('addToCartBool timer => ${logic.isStatusChanged}');
                                          if (logic.isStatusChanged == true) {
                                            var result = true;
                                            print('Result => $result');
                                            if (result) {
                                              setState(() {
                                                logic.getCouponDetails(couponId);
                                                isActive = false;
                                              });
                                            }
                                          }
                                        }

                                      },
                                      child: Container(
                                          height: 40,
                                          width: 70,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.rectangle,
                                              color: CupertinoColors.white,
                                              border: Border.all(
                                                  color:
                                                  logic.getCouponDetailsModel.data?.status == active ?
                                                  Color(GREENCOLORICON) : Color(LIGHTERGREYCOLORICON),
                                                  style: BorderStyle.solid,
                                                  width: 1),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5))),
                                          child:
                                          logic.getCouponDetailsModel.data?.status == active ?
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment
                                                .spaceAround,
                                            children: [
                                              Icon(
                                                  CupertinoIcons
                                                      .check_mark,
                                                  color: Color(
                                                      GREENCOLORICON)),
                                              Container(
                                                decoration: BoxDecoration(
                                                    shape: BoxShape
                                                        .rectangle,
                                                    color: Color(
                                                        GREENCOLORICON),
                                                    borderRadius:
                                                    BorderRadius.all(
                                                        Radius
                                                            .circular(
                                                            5))),
                                                height: 30,
                                                width: 30,
                                              ),
                                              // SizedBox(width: 5,)
                                            ],
                                          ):
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment
                                                .spaceAround,
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.rectangle,
                                                    border: Border.all(color: Color(LIGHTERGREYCOLORICON), style: BorderStyle.solid, width: 1),
                                                    borderRadius: BorderRadius.all(Radius.circular(5))),
                                                height:
                                                30,
                                                width:
                                                30,
                                              ),
                                              Icon(
                                                  CupertinoIcons
                                                      .clear,
                                                  color:
                                                  Color(LIGHTERGREYCOLORICON)),
                                            ],
                                          ),),
                                    ) : Center(
                                      child:
                                      CircularProgressIndicator(
                                        color:
                                        Color(ORANGE),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              });
      })),
    );
  }
}

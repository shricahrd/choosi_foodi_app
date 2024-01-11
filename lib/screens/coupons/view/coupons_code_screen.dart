import 'package:choosifoodi/core/utils/app_color_utils.dart';
import 'package:choosifoodi/core/utils/app_font_utils.dart';
import 'package:choosifoodi/core/utils/app_images_utils.dart';
import 'package:choosifoodi/core/widgets/widget_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/utils/app_constants.dart';
import '../../../core/utils/app_strings_constants.dart';
import '../../../core/utils/networkManager.dart';
import '../../../core/widgets/widget_card.dart';
import '../../cart/controller/menu_cart_controller.dart';
import '../controller/coupon_controller.dart';

class CouponsCodeScreen extends StatefulWidget {
  dynamic restaurantId;


  CouponsCodeScreen(this.restaurantId);

  @override
  _CouponsCodeScreenState createState() => _CouponsCodeScreenState();
}

class _CouponsCodeScreenState extends State<CouponsCodeScreen> {
  TextEditingController applyCouponController = TextEditingController();
  final CouponController _couponController = Get.put(CouponController());
  final MenuCartController _menuCartController = Get.put(MenuCartController());
  final _networkController = Get.find<GetXNetworkManager>();

  @override
  void initState() {
    applyCouponController.clear();
    _couponController.callCouponListAPI();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(WHITE),
      appBar: WidgetAppbar.simpleAppBar(context, applyDeals, false ),
      body: SafeArea(
          child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 15,
            ),
            Card(
              margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
              elevation: 5,
              child: Container(
                decoration: BoxDecoration(
                  color: Color(WHITE),
                  borderRadius: BorderRadius.all(Radius.circular(12.0)),
                ),
                padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: applyCouponController,
                        textAlign: TextAlign.start,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                            color: Color(0xff8C8989),
                            fontSize: 14,
                            fontFamily: FontPoppins,
                            fontWeight: PoppinsRegular,
                          ),
                          hintText: "Enter Coupon Code",
                        ),
                        style: TextStyle(
                          color: Color(0xff3E4958),
                          fontSize: 16,
                          fontFamily: FontPoppins,
                          fontWeight: PoppinsRegular,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    _menuCartController.couponApply == false
                        ? InkWell(
                            onTap: () async {
                              if (_networkController.connectionType != 0) {
                                FocusManager.instance.primaryFocus?.unfocus();
                                if (applyCouponController.text.isNotEmpty) {
                                  for (int i = 0;i < _couponController.getCouponList.data!.length; i++) {
                                    if (applyCouponController.text ==
                                        _couponController.getCouponList.data?[i].couponName) {
                                      await _menuCartController
                                          .applyCouponApi(
                                           restaurantId: widget.restaurantId,
                                          couponName: applyCouponController.text);
                                      if (_menuCartController.deleteCartModel.meta?.status == true) {
                                        Get.back(result: true);
                                      }
                                    }
                                  }
                                } else {
                                  showToastMessage('Please Enter Coupon Code');
                                }
                              } else {
                                showToastMessage(check_internet);
                              }
                            },
                            child: WidgetText.widgetPoppinsMediumText(
                              "APPLY",
                              Color(ORANGE),
                              14,
                            ),
                          )
                        : Container(
                            height: 20,
                            width: 20,
                            child: Center(
                              child: CircularProgressIndicator(
                                color: Color(ORANGE),
                              ),
                            )),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: WidgetText.widgetPoppinsMediumText(
                "Available Deals",
                Color(BLACK),
                16,
              ),
            ),
            Flexible(
              child: GetBuilder<CouponController>(builder: (logic) {
                return logic.isLoaderVisible
                    ? Center(
                        child: CircularProgressIndicator(
                        color: Color(ORANGE),
                      ))
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        itemCount: logic.getCouponList.data?.length,
                        itemBuilder: (context, index) {
                          return Card(
                            margin: EdgeInsets.fromLTRB(15, 10, 15, 0),
                            elevation: 5,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color(WHITE),
                                borderRadius: BorderRadius.all(Radius.circular(12.0)),
                              ),
                              padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Stack(
                                        alignment: AlignmentDirectional
                                            .centerStart,
                                        children: [
                                          Image.asset(
                                            img_offer_bg,
                                            height: 50,
                                            width: 200,
                                          ),
                                          // logic.getCouponList.data?[index].discount
                                          Positioned(
                                            height: 50,
                                            left: 5,
                                            child: logic
                                                .getCouponList
                                                .data?[index]
                                                .couponImg
                                                .isEmpty == true
                                                ? Image.asset(
                                              tmp_img_offer,
                                              height: 30,
                                              width: 35,
                                            )
                                                : Image.network(
                                              logic
                                                  .getCouponList
                                                  .data![index]
                                                  .couponImg
                                                  .toString(),
                                              height: 30,
                                              width: 35,
                                              errorBuilder:
                                                  (context, error,
                                                  stackTrace) {
                                                return Image.asset(
                                                  tmp_img_offer,
                                                  height: 30,
                                                  width: 35,
                                                );
                                              },
                                            ),
                                          ),
                                          Positioned(
                                            height: 50,
                                            left: 70,
                                            child: Container(
                                              height: 50,
                                              alignment: Alignment.center,
                                              child: WidgetText
                                                  .widgetPoppinsRegularText(
                                                // applyCouponController
                                                //     .text = logic
                                                logic.getCouponList
                                                    .data?[index]
                                                    .couponName ??
                                                    "",
                                                // "PAYTMSAVE",
                                                Color(BLACK),
                                                16,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      InkWell(
                                        onTap: () async {
                                          await _menuCartController
                                              .applyCouponApi(
                                              restaurantId: widget.restaurantId,
                                              couponName: logic.getCouponList.data?[index].couponName ?? "");
                                          if (_menuCartController
                                              .deleteCartModel
                                              .meta
                                              ?.status ==
                                              true) {
                                            Get.back(result: true);
                                          }
                                        },
                                        child: WidgetText
                                            .widgetPoppinsMediumText(
                                          "APPLY",
                                          Color(ORANGE),
                                          18,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  WidgetText.widgetPoppinsRegularMaxOverflowText(
                                    logic.getCouponList.data?[index]
                                        .description
                                        .toString()
                                        .replaceAll(
                                        RegExp(
                                            r'<[^>]*>|&[^;]+;'),
                                        ' ') ??
                                        "",
                                    // "Get assured cashback up to INR 100/- using paytm",
                                    Color(LIGHTTEXTCOLOR),
                                    12,
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                ],
                              ),
                            ),
                          );
                        });
              }),
              flex: 1,
              fit: FlexFit.tight,
            ),
            SizedBox(
              height: 15,
            ),
          ],
        ),
      )),
    );
  }

}

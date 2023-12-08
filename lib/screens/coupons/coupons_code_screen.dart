import 'package:choosifoodi/core/utils/app_color_utils.dart';
import 'package:choosifoodi/core/utils/app_font_utils.dart';
import 'package:choosifoodi/core/utils/app_images_utils.dart';
import 'package:choosifoodi/core/widgets/widget_text.dart';
import 'package:choosifoodi/screens/group_orders/create_group_screen.dart';
import 'package:choosifoodi/screens/order_checkout/checkout_payment_screen.dart';
import 'package:flutter/material.dart';

class CouponsCodeScreen extends StatefulWidget {
  @override
  _CouponsCodeScreenState createState() => _CouponsCodeScreenState();
}

class _CouponsCodeScreenState extends State<CouponsCodeScreen> {
  int _orderTypeValue = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(WHITE),
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.transparent, //change your color here
        ),
        toolbarHeight: 60,
        shadowColor: Colors.transparent,
        backgroundColor: Color(WHITE),
        flexibleSpace: Container(
          height: double.infinity,
          padding: EdgeInsets.fromLTRB(15, 0, 15, 15),
          alignment: Alignment.bottomCenter,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {},
                child: Image.asset(
                  ic_back,
                  width: 25,
                  height: 20,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Flexible(
                child: WidgetText.widgetPoppinsRegularText(
                  "Apply Coupons",
                  Color(BLACK),
                  18,
                ),
                flex: 1,
                fit: FlexFit.tight,
              ),
            ],
          ),
        ),
      ),
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
                color: Color(WHITE),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Container(
                  padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          textAlign: TextAlign.start,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintStyle: TextStyle(
                              color: Color(0xff8C8989),
                              fontSize: 16,
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
                      WidgetText.widgetPoppinsMediumText(
                        "APPLY",
                        Color(ORANGE),
                        14,
                      ),
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
                  "Available coupons",
                  Color(BLACK),
                  18,
                ),
              ),
              Flexible(
                child: ListView.builder(
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    itemCount: 20,
                    itemBuilder: (context, index) {
                      return Card(
                        margin: EdgeInsets.fromLTRB(15, 10, 15, 0),
                        elevation: 5,
                        color: Color(WHITE),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Container(
                          padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Stack(
                                    alignment: AlignmentDirectional.centerStart,
                                    children: [
                                      Image.asset(
                                        img_offer_bg,
                                        height: 50,
                                        width: 200,
                                      ),
                                      Positioned(
                                        height: 50,
                                        left: 5,
                                        child: Image.asset(
                                          tmp_img_offer,
                                          height: 45,
                                          width: 40,
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
                                            "PAYTMSAVE",
                                            Color(BLACK),
                                            18,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  WidgetText.widgetPoppinsMediumText(
                                    "APPLY",
                                    Color(ORANGE),
                                    18,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              WidgetText.widgetPoppinsRegularText(
                                "Get assured cashback up to INR 100/- using paytm",
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
                    }),
                flex: 1,
                fit: FlexFit.tight,
              ),
              SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }

  onClickChangeAddress() {}

  onClickApplyCoupon() {}

  onClickContinue() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => CheckoutPaymentScreen()));
  }

  onClickGroupOrder() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => CreateGroupScreen()));
  }
}

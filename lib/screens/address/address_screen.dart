import 'package:choosifoodi/core/utils/app_color_utils.dart';
import 'package:choosifoodi/core/utils/app_images_utils.dart';
import 'package:choosifoodi/core/widgets/widget_button.dart';
import 'package:choosifoodi/core/widgets/widget_text.dart';
import 'package:choosifoodi/screens/address/new_address_screen.dart';
import 'package:choosifoodi/screens/base_application/base_application.dart';
import 'package:flutter/material.dart';

class AddressScreen extends StatefulWidget {
  @override
  _AddressScreenState createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
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
        elevation: 3,
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
                  "Select a delivery address",
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: ListView(
                physics: BouncingScrollPhysics(),
                children: [
                  ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: 1,
                      itemBuilder: (context, index) {
                        return Container(
                            padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset(
                                  ic_select_round_radio,
                                  height: 25,
                                  width: 25,
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      WidgetText.widgetPoppinsMediumText(
                                        "Mr. Rajesh Verma",
                                        Color(BLACK),
                                        16,
                                      ),
                                      WidgetText.widgetPoppinsRegularText(
                                        "9988776655",
                                        Color(BLACK),
                                        14,
                                      ),
                                      WidgetText.widgetPoppinsRegularText(
                                        "H.No. 524, 2nd Floor, Nehru Place, New Delhi, Delhi - 110019",
                                        Color(LIGHTTEXTCOLOR),
                                        14,
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          InkWell(
                                            onTap: () {},
                                            child: Container(
                                              width: 70,
                                              height: 35,
                                              decoration: BoxDecoration(
                                                color: Color(ORANGE),
                                                shape: BoxShape.rectangle,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(7)),
                                              ),
                                              alignment: Alignment.center,
                                              child: WidgetText
                                                  .widgetPoppinsRegularText(
                                                "Edit",
                                                Color(WHITE),
                                                14,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 15,
                                          ),
                                          InkWell(
                                            onTap: () {},
                                            child: Container(
                                              width: 70,
                                              height: 35,
                                              decoration: BoxDecoration(
                                                color: Color(0xffE0E0E0),
                                                shape: BoxShape.rectangle,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(7)),
                                              ),
                                              alignment: Alignment.center,
                                              child: WidgetText
                                                  .widgetPoppinsRegularText(
                                                "Delete",
                                                Color(BLACK),
                                                14,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ));
                      }),
                  SizedBox(
                    height: 15,
                  ),
                  InkWell(
                    onTap: onClickAddNewAddress,
                    child: Card(
                      elevation: 5,
                      color: Color(WHITE),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0.0),
                      ),
                      child: Container(
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
                                "Add New Address",
                                Color(SUBTEXT),
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
                  "Proceed to checkout", onClickProcessToCheckOut),
            ),
            SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }

  onClickAddNewAddress() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => NewAddressScreen()));
  }

  onClickProcessToCheckOut() {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => BaseApplication()),
        (r) => false);
  }
}

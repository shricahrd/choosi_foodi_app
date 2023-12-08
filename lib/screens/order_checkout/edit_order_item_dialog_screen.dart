import 'package:choosifoodi/core/utils/app_color_utils.dart';
import 'package:choosifoodi/core/utils/app_images_utils.dart';
import 'package:choosifoodi/core/widgets/widget_button.dart';
import 'package:choosifoodi/core/widgets/widget_round_radio_button.dart';
import 'package:choosifoodi/core/widgets/widget_text.dart';
import 'package:choosifoodi/screens/group_orders/create_group_screen.dart';
import 'package:choosifoodi/screens/order_checkout/checkout_payment_screen.dart';
import 'package:flutter/material.dart';

class EditOrderItemDialogScreen extends StatefulWidget {
  @override
  _EditOrderItemDialogScreenState createState() =>
      _EditOrderItemDialogScreenState();
}

class _EditOrderItemDialogScreenState extends State<EditOrderItemDialogScreen> {
  int _proteinValue = 0;
  int _sauceChoices = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: double.infinity,
          decoration: BoxDecoration(
            color: Color(0xff10000000),
          ),
          child: Container(
            margin: EdgeInsets.fromLTRB(0, 60, 0, 0),
            padding: EdgeInsets.fromLTRB(15, 15, 0, 15),
            decoration: BoxDecoration(
              color: Color(WHITE),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  child: Image.asset(
                    ic_sheet_divider,
                    width: 200,
                    height: 5,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        WidgetText.widgetRobotoMediumText(
                          "Food Item Title",
                          Color(BLACK),
                          25,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
                          child: WidgetText.widgetRobotoRegularText(
                            "Lorem ipsum dolor sit amet, consectetur adipiscing elit ut aliquam, purus sit amet luctus venenatis",
                            Color(SUBTEXT),
                            14,
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Divider(
                            height: 1,
                            thickness: 1,
                            color: Color(DIVIDERCOLOR)),
                        SizedBox(
                          height: 15,
                        ),
                        WidgetText.widgetRobotoMediumText(
                          "Protein Option",
                          Color(BLACK),
                          18,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        WidgetText.widgetRobotoRegularText(
                          "Select 1",
                          Color(SUBTEXT),
                          16,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _proteinValue = 0;
                            });
                          },
                          child: _proteinValue == 0
                              ? WidgetRoundRadioButton.selectedRoundRadioButton(
                                  "Veggie")
                              : WidgetRoundRadioButton
                                  .unselectedRoundRadioButton("Veggie"),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _proteinValue = 1;
                            });
                          },
                          child: _proteinValue == 1
                              ? WidgetRoundRadioButton.selectedRoundRadioButton(
                                  "Soy")
                              : WidgetRoundRadioButton
                                  .unselectedRoundRadioButton("Soy"),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _proteinValue = 2;
                            });
                          },
                          child: _proteinValue == 2
                              ? WidgetRoundRadioButton.selectedRoundRadioButton(
                                  "Lentill")
                              : WidgetRoundRadioButton
                                  .unselectedRoundRadioButton("Lentill"),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Divider(
                            height: 1,
                            thickness: 1,
                            color: Color(DIVIDERCOLOR)),
                        SizedBox(
                          height: 15,
                        ),
                        WidgetText.widgetRobotoMediumText(
                          "Sauce Choices",
                          Color(BLACK),
                          18,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        WidgetText.widgetRobotoRegularText(
                          "Not Required",
                          Color(SUBTEXT),
                          16,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _sauceChoices = 0;
                            });
                          },
                          child: _sauceChoices == 0
                              ? WidgetRoundRadioButton.selectedRoundRadioButton(
                                  "None")
                              : WidgetRoundRadioButton
                                  .unselectedRoundRadioButton("None"),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _sauceChoices = 1;
                                    });
                                  },
                                  child: _sauceChoices == 1
                                      ? WidgetRoundRadioButton
                                          .selectedRoundRadioButton("Sauce 1")
                                      : WidgetRoundRadioButton
                                          .unselectedRoundRadioButton(
                                              "Sauce 1"),
                                ),
                              ),
                              WidgetText.widgetRobotoRegularText(
                                "+0.99",
                                Color(BLACK),
                                16,
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _sauceChoices = 2;
                                    });
                                  },
                                  child: _sauceChoices == 2
                                      ? WidgetRoundRadioButton
                                          .selectedRoundRadioButton("Sauce 2")
                                      : WidgetRoundRadioButton
                                          .unselectedRoundRadioButton(
                                              "Sauce 2"),
                                ),
                              ),
                              WidgetText.widgetRobotoRegularText(
                                "+0.99",
                                Color(BLACK),
                                16,
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _sauceChoices = 3;
                                    });
                                  },
                                  child: _sauceChoices == 3
                                      ? WidgetRoundRadioButton
                                          .selectedRoundRadioButton("Sauce 3")
                                      : WidgetRoundRadioButton
                                          .unselectedRoundRadioButton(
                                              "Sauce 3"),
                                ),
                              ),
                              WidgetText.widgetRobotoRegularText(
                                "+0.99",
                                Color(BLACK),
                                16,
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Divider(
                            height: 1,
                            thickness: 1,
                            color: Color(DIVIDERCOLOR)),
                        SizedBox(
                          height: 15,
                        ),
                        WidgetText.widgetRobotoRegularText(
                          "Add Special Instructions",
                          Color(BLACK),
                          18,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        WidgetText.widgetRobotoRegularText(
                          "Add any instructions for your order here...",
                          Color(HINTCOLOR),
                          16,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Divider(
                            height: 1,
                            thickness: 1,
                            color: Color(DIVIDERCOLOR)),
                        SizedBox(
                          height: 15,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: WidgetText.widgetRobotoRegularText(
                            "Add to order",
                            Color(BLACK),
                            18,
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              ic_remove,
                              height: 40,
                              width: 40,
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            WidgetText.widgetRobotoRegularText(
                              "1",
                              Color(BLACK),
                              18,
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Image.asset(
                              ic_add,
                              height: 40,
                              width: 40,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          alignment: Alignment.center,
                          child: InkWell(
                            onTap: () {},
                            child: WidgetText.widgetRobotoRegularText(
                              "Remove Item",
                              Color(RED),
                              16,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(0, 0, 15, 15),
                  child: WidgetButton.widgetDefaultButton(
                      "Update Order", onClickUpdateOrder),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  onClickUpdateOrder() {
    Navigator.of(context).pop(true);
  }

  onClickContinue() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => CheckoutPaymentScreen()));
  }

  onClickGroupOrder() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => CreateGroupScreen()));
  }
}

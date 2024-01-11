import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../../../../core/utils/app_color_utils.dart';
import '../../../../../../core/utils/app_font_utils.dart';
import '../../../../../../core/utils/app_strings_constants.dart';
import '../../../../../../core/utils/networkManager.dart';
import '../../../../../../core/widgets/widget_text.dart';
import '../../../../core/utils/app_images_utils.dart';
import '../../../../core/widgets/widget_card.dart';
import '../controller/delivery_controller.dart';

class DeliveryChargesScreen extends StatefulWidget {
  DeliveryChargesScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<DeliveryChargesScreen> createState() => _DeliveryChargesScreenState();
}

class _DeliveryChargesScreenState extends State<DeliveryChargesScreen> {
  TextEditingController minDeliveryCtl = TextEditingController();
  TextEditingController deliveryChargeCtl = TextEditingController();
  final DeliveryController _deliveryController = Get.put(DeliveryController());

  @override
  void initState() {
    callApi();
    super.initState();
  }

  callApi() async {
    await _deliveryController.callGetContactInfoAPI();
    minDeliveryCtl.text = _deliveryController
            .getDeliveryChargeModel.data?.minimumOrderValue
            .toString() ??
        "";
    deliveryChargeCtl.text = _deliveryController
            .getDeliveryChargeModel.data?.deliveryCharges
            .toString() ??
        "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(WHITE),
      appBar: WidgetAppbar.simpleAppBar(context, "Delivery Charges", true ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child:
                    GetBuilder<GetXNetworkManager>(builder: (networkManager) {
                  return networkManager.connectionType == 0
                      ? Center(child: Text(check_internet))
                      :
                      // DeliveryController
                      GetBuilder<DeliveryController>(builder: (logic) {
                          return logic.isLoaderVisible == true
                              ? Center(
                                  child: CircularProgressIndicator(
                                    color: Color(ORANGE),
                                  ),
                                )
                              : Container(
                                  padding: EdgeInsets.all(25),
                                  width: double.infinity,
                                  child: Stack(
                                    children: [
                                      Column(
                                        children: [
                                          customTextInputField(
                                            minDeliveryCtl,
                                            "Enter Minimum order value for delivery",
                                            minimum_order,
                                            TextInputType.number,
                                            TextInputAction.next,
                                          ),
                                          Divider(
                                              height: 1,
                                              thickness: 1,
                                              color: Color(DIVIDERCOLOR)),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          customTextInputField(
                                            deliveryChargeCtl,
                                            "Enter Delivery Fee",
                                            delivery_fee,
                                            TextInputType.number,
                                            TextInputAction.done,
                                          ),
                                          Divider(
                                              height: 1,
                                              thickness: 1,
                                              color: Color(DIVIDERCOLOR)),
                                          SizedBox(
                                            height: 20,
                                          ),
                                        ],
                                      ),
                                      logic.isDelivered == false
                                          ? Align(
                                              alignment: Alignment.bottomCenter,
                                              child: InkWell(
                                                onTap: () async {
                                                  setState(() {
                                                    logic.isDelivered =
                                                        !logic.isDelivered;
                                                    print(
                                                        'bool : ${logic.isDelivered}');
                                                  });
                                                  await logic.addDeliveryApi(
                                                      delCharge: int.parse(
                                                          deliveryChargeCtl
                                                              .text),
                                                      minOrderVal: int.parse(
                                                          minDeliveryCtl.text));
                                                  setState(() {
                                                    logic.isDelivered =
                                                        !logic.isDelivered;
                                                    print(
                                                        'bool : ${logic.isDelivered}');
                                                    if (logic.metaModel
                                                            .meta?.status ==
                                                        true) {
                                                      Navigator.of(context).pop();
                                                    }
                                                  });
                                                },
                                                child: Container(
                                                  width: double.infinity,
                                                  height: 45,
                                                  padding: EdgeInsets.fromLTRB(
                                                      0, 10, 0, 10),
                                                  decoration: BoxDecoration(
                                                    color: Color(ORANGE),
                                                    shape: BoxShape.rectangle,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(7)),
                                                  ),
                                                  alignment: Alignment.center,
                                                  child: WidgetText
                                                      .widgetPoppinsRegularText(
                                                    submit,
                                                    Color(WHITE),
                                                    16,
                                                  ),
                                                ),
                                              ),
                                            )
                                          : Center(
                                              child: CircularProgressIndicator(
                                                color: Color(ORANGE),
                                              ),
                                            ),
                                    ],
                                  ),
                                  decoration: BoxDecoration(
                                    color: Color(WHITE),
                                  ),
                                );
                        });
                })),
          ],
        ),
      ),
    );
  }

  Widget customTextInputField(
    TextEditingController editingController,
    String hintText,
    String lableText,
    TextInputType? keyboardType,
    TextInputAction? textInputAction,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            margin: EdgeInsets.fromLTRB(0, 10, 0, 2),
            child: WidgetText.widgetPoppinsText(lableText)),
        Container(
          margin: EdgeInsets.fromLTRB(0, 2, 0, 0),
          decoration: BoxDecoration(
            color: Color(WHITE),
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
          padding: EdgeInsets.fromLTRB(0, 3, 0, 3),
          child: TextFormField(
            controller: editingController,
            textAlign: TextAlign.start,
            keyboardType: keyboardType,
            textInputAction: textInputAction,
            textCapitalization: TextCapitalization.sentences,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            decoration: InputDecoration(
              border: InputBorder.none,
              hintStyle: TextStyle(
                color: Color(HINTCOLOR),
                fontSize: 16,
                fontFamily: FontPoppins,
                fontWeight: RobotoRegular,
              ),
              hintText: hintText,
              prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
              prefixIcon: Text("\$",
                  style: TextStyle(
                    color: Color(BLACK),
                    fontSize: 16,
                    fontFamily: FontRoboto,
                    fontWeight: RobotoMedium,
                  )),
            ),
            style: TextStyle(
              color: Color(BLACK),
              fontSize: 16,
              fontFamily: FontPoppins,
              fontWeight: RobotoMedium,
            ),
          ),
        )
      ],
    );
  }
}

import 'package:choosifoodi/core/utils/app_color_utils.dart';
import 'package:choosifoodi/core/utils/app_images_utils.dart';
import 'package:choosifoodi/core/widgets/widget_button.dart';
import 'package:choosifoodi/core/widgets/widget_text.dart';
import 'package:choosifoodi/screens/order_checkout/view/order_checkout_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/utils/app_strings_constants.dart';
import '../../../core/utils/networkManager.dart';
import '../controller/menu_cart_controller.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}
bool _isDecrimentEnable = true;
class _CartScreenState extends State<CartScreen> {
  final MenuCartController menuCartController = Get.put(MenuCartController());

  // create an instance
  final GetXNetworkManager _networkManager = Get.put(GetXNetworkManager());

  @override
  void initState() {
    debugPrint('Cart In');
    _isDecrimentEnable = true;
    debugPrint('_isDecrimentEnable: $_isDecrimentEnable');
    if (_networkManager.connectionType != 0) {
      debugPrint('Connection Type: ${_networkManager.connectionType}');
      menuCartController.callGetCartAPI();
    }
    super.initState();
  }

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
                onTap: () {
                  Navigator.of(context).pop(true);
                },
                child: Image.asset(
                  ic_right_side_arrow,
                  width: 25,
                  color: Color(ORANGE),
                  height: 20,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Flexible(
                child: WidgetText.widgetPoppinsRegularText(
                  "Cart",
                  Color(BLACK),
                  16,
                ),
                flex: 1,
                fit: FlexFit.tight,
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
          child: GetBuilder<GetXNetworkManager>(builder: (networkManager) {
        return networkManager.connectionType == 0
            ? Center(child: Text(check_internet))
            : GetBuilder<MenuCartController>(builder: (logic) {
                return logic.isLoaderVisible
                    ? Center(
                        child: CircularProgressIndicator(
                          color: Color(ORANGE),
                        ),
                      )
                    : logic.getMenuCartModel.meta?.status == false
                        ?
                Center(
                    child: Container(
                        color: Color(WHITE),
                        child: WidgetText.widgetPoppinsMediumText(
                            'Your Cart is Empty!',
                            Color(BLACK),
                            16)))
                        : Container(
                            padding: EdgeInsets.fromLTRB(15, 10, 15, 0),
                            child: ListView(
                              physics: BouncingScrollPhysics(),
                              children: [
                                ListView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: logic.getMenuCartModel.data
                                        ?.cartMenu?.length,
                                    itemBuilder: (context, index) {
                                      return Column(
                                        children: [
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Stack(
                                            children: [
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    width: 110,
                                                    height: 95,
                                                    child: logic.getMenuCartModel.data
                                                                        ?.cartMenu?[
                                                                    index] ==
                                                                null ||
                                                            logic
                                                                .getMenuCartModel.data?.cartMenu?[index].menuImg?.isEmpty == true
                                                        ? Image.asset(
                                                            ic_no_image,
                                                            fit: BoxFit.fill,
                                                          )
                                                        : ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                            child:
                                                                Image.network(
                                                              logic
                                                                  .getMenuCartModel.data?.cartMenu?[index].menuImg?.first.toString() ?? "",
                                                              fit: BoxFit.fill,
                                                              loadingBuilder:
                                                                  (BuildContext
                                                                          context,
                                                                      Widget
                                                                          child,
                                                                      ImageChunkEvent?
                                                                          loadingProgress) {
                                                                if (loadingProgress ==
                                                                    null)
                                                                  return child;
                                                                return Center(
                                                                  child:
                                                                      CircularProgressIndicator(
                                                                    color: Color(
                                                                        ORANGE),
                                                                    value: loadingProgress.expectedTotalBytes !=
                                                                            null
                                                                        ? loadingProgress.cumulativeBytesLoaded /
                                                                            loadingProgress.expectedTotalBytes!
                                                                        : null,
                                                                  ),
                                                                );
                                                              },
                                                              errorBuilder:
                                                                  (context,
                                                                      error,
                                                                      stackTrace) {
                                                                return Image
                                                                    .asset(
                                                                  ic_no_image,
                                                                  fit: BoxFit
                                                                      .fill,
                                                                );
                                                              },
                                                            ),
                                                          ),
                                                  ),
                                                  SizedBox(
                                                    width: 15,
                                                  ),
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                       WidgetText
                                                                .widgetPoppinsMediumText(
                                                                logic
                                                                    .getMenuCartModel
                                                                    .data?.cartMenu?[index].dishName.toString() ?? "",
                                                                Color(BLACK),
                                                                16,
                                                              ),
                                                        SizedBox(
                                                          height: 3,
                                                        ),
                                                        logic
                                                                    .getMenuCartModel
                                                                    .data
                                                                    ?.cartMenu?[
                                                                        index]
                                                                    .calclulatePrice ==
                                                                null
                                                            ? Text('')
                                                            : WidgetText
                                                                .widgetPoppinsMediumText(
                                                                "\$" +
                                                                    "${logic.getMenuCartModel.data?.cartMenu?[index].calclulatePrice}",
                                                                Color(ORANGE),
                                                                14,
                                                              )
                                                      ],
                                                    ),
                                                  ),
                                                  logic
                                                              .getMenuCartModel
                                                              .data
                                                              ?.cartMenu?[index]
                                                              .itemDelete ==
                                                          false
                                                      ?
                                                      // logic.getMenuCartModel.data?.cartMenu?[index].cartId != null ?

                                                      InkWell(
                                                          child: Image.asset(
                                                            ic_delete,
                                                            width: 20,
                                                            height: 20,
                                                            fit: BoxFit.fill,
                                                          ),
                                                          onTap: () async {
                                                            setState(() {
                                                              logic
                                                                  .getMenuCartModel
                                                                  .data
                                                                  ?.cartMenu?[
                                                                      index]
                                                                  .itemDelete = true;
                                                            });
                                                            if (logic
                                                                    .getMenuCartModel
                                                                    .data
                                                                    ?.cartMenu![
                                                                        index]
                                                                    .cartId !=
                                                                null) {
                                                              logic.deleteCartAPI(
                                                                  cartId: logic
                                                                      .getMenuCartModel
                                                                      .data?.cartMenu?[index].cartId.toString() ?? "",
                                                                  menuId: logic
                                                                      .getMenuCartModel.data?.cartMenu?[index]
                                                                      .menuId
                                                                      .toString() ?? "");
                                                              /* if(logic.deleteCartModel.meta?.status == true){
                                                                logic.getSPList(logic
                                                                    .getMenuCartModel
                                                                    .data!
                                                                    .cartMenu![
                                                                index]
                                                                    .menuId.toString());
                                                              }*/
                                                            }
                                                          },
                                                        )
                                                      : Center(
                                                          child: Container(
                                                              height: 20,
                                                              width: 20,
                                                              child:
                                                                  CircularProgressIndicator(
                                                                color: Color(
                                                                    ORANGE),
                                                              )),
                                                        ),
                                                ],
                                              ),
                                              Positioned(
                                                right: 0,
                                                bottom: 5,
                                                child: Container(
                                                  padding: EdgeInsets.fromLTRB(
                                                      10, 3, 10, 3),
                                                  decoration: BoxDecoration(
                                                    color: Color(WHITE),
                                                    shape: BoxShape.rectangle,
                                                    border: Border.all(
                                                        color:
                                                            Color(BORDERCOLOR),
                                                        width: 1),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                20)),
                                                  ),
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      InkWell(
                                                        child: Image.asset(
                                                          ic_descrease,
                                                          width: 15,
                                                          height: 15,
                                                        ),
                                                        onTap: () async {
                                                          int selectedQty = logic.getMenuCartModel.data?.cartMenu?[index].selectQuantity ?? 0;
                                                          debugPrint("selectedQty  $selectedQty");
                                                          String restaurantId = logic.getMenuCartModel.data?.restaurantId??"";
                                                          String menuId = logic.getMenuCartModel.data?.cartMenu?[index].menuId??"";
                                                          if(selectedQty > 1){
                                                            callDecAPI(restaurantId,menuId,logic);
                                                          }
                                                        },
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      logic.getMenuCartModel.data == null
                                                          ? Text('1')
                                                          : WidgetText
                                                              .widgetPoppinsMediumText(
                                                              logic
                                                                      .getMenuCartModel
                                                                      .data
                                                                      ?.cartMenu?[
                                                                          index]
                                                                      .selectQuantity
                                                                      .toString() ??
                                                                  "",
                                                              Color(BLACK),
                                                              14,
                                                            ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      InkWell(
                                                          child: Image.asset(
                                                            ic_increase,
                                                            width: 15,
                                                            height: 15,
                                                          ),
                                                          onTap: () async {
                                                            int selectedQty = logic.getMenuCartModel.data?.cartMenu?[index].selectQuantity ?? 0;
                                                            debugPrint("selectedQty  $selectedQty");
                                                            String restaurantId = logic.getMenuCartModel.data?.restaurantId??"";
                                                            String menuId = logic.getMenuCartModel.data?.cartMenu?[index].menuId??"";
                                                            debugPrint("restaurantId: $restaurantId,menuId: $menuId ");
                                                            await logic.incrementQtyApi(
                                                                restaurantId: restaurantId,
                                                                menuId: menuId,
                                                                selectQty: 1);

                                                            if(logic.getQtyUpdateModel.meta?.status ==true) {
                                                              await logic
                                                                  .callGetCartAPI();
                                                            }
                                                          }),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                child: Container(
                                                  padding: EdgeInsets.fromLTRB(
                                                      0, 15, 0, 15),
                                                  decoration: BoxDecoration(
                                                    color: Color(0xffF9F7F8),
                                                    shape: BoxShape.rectangle,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10)),
                                                  ),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      WidgetText
                                                          .widgetPoppinsRegularText(
                                                        "Calories",
                                                        Color(BLACK),
                                                        13,
                                                      ),
                                                      logic
                                                                  .getMenuCartModel
                                                                  .data
                                                                  ?.cartMenu?[
                                                                      index]
                                                                  .calclulateCalary ==
                                                              null
                                                          ? Text("0.0")
                                                          : WidgetText
                                                              .widgetPoppinsMediumText(
                                                              logic.getMenuCartModel.data?.cartMenu?[index]
                                                                  .calclulateCalary
                                                                  .toString() ?? "",
                                                              Color(BLACK),
                                                              14,
                                                            ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 15,
                                              ),
                                              Expanded(
                                                child: Container(
                                                  padding: EdgeInsets.fromLTRB(
                                                      0, 15, 0, 15),
                                                  decoration: BoxDecoration(
                                                    color: Color(0xffF9F7F8),
                                                    shape: BoxShape.rectangle,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10)),
                                                  ),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      WidgetText
                                                          .widgetPoppinsRegularText(
                                                        "Fat",
                                                        Color(BLACK),
                                                        13,
                                                      ),
                                                      logic
                                                                  .getMenuCartModel
                                                                  .data
                                                                  ?.cartMenu?[
                                                                      index]
                                                                  .calclulateFat ==
                                                              null
                                                          ? Text("0.0")
                                                          : WidgetText
                                                              .widgetPoppinsMediumText(
                                                             ( logic.getMenuCartModel.data?.cartMenu?[index]
                                                                      .calclulateFat
                                                                      .toString()  ?? "")+
                                                                  "g",
                                                              Color(BLACK),
                                                              14,
                                                            ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 15,
                                              ),
                                              Expanded(
                                                child: Container(
                                                  padding: EdgeInsets.fromLTRB(
                                                      0, 15, 0, 15),
                                                  decoration: BoxDecoration(
                                                    color: Color(0xffF9F7F8),
                                                    shape: BoxShape.rectangle,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10)),
                                                  ),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      WidgetText
                                                          .widgetPoppinsRegularText(
                                                        "Carbs",
                                                        Color(BLACK),
                                                        13,
                                                      ),
                                                      logic
                                                                  .getMenuCartModel
                                                                  .data
                                                                  ?.cartMenu?[
                                                                      index]
                                                                  .calclulateCarbs ==
                                                              null
                                                          ? Text("0.0")
                                                          : WidgetText
                                                              .widgetPoppinsMediumText(
                                                              (logic.getMenuCartModel.data?.cartMenu?[index]
                                                                      .calclulateCarbs
                                                                      .toString() ?? "") +
                                                                  "g",
                                                              Color(BLACK),
                                                              14,
                                                            ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 15,
                                              ),
                                              Expanded(
                                                child: Container(
                                                  padding: EdgeInsets.fromLTRB(
                                                      0, 15, 0, 15),
                                                  decoration: BoxDecoration(
                                                    color: Color(0xffF9F7F8),
                                                    shape: BoxShape.rectangle,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10)),
                                                  ),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      WidgetText
                                                          .widgetPoppinsRegularText(
                                                        "Protein",
                                                        Color(BLACK),
                                                        13,
                                                      ),
                                                      logic
                                                                  .getMenuCartModel
                                                                  .data
                                                                  ?.cartMenu?[
                                                                      index]
                                                                  .calclulateProtein ==
                                                              null
                                                          ? Text("0.0")
                                                          : WidgetText
                                                              .widgetPoppinsMediumText(
                                                             (logic.getMenuCartModel.data?.cartMenu?[index]
                                                                      .calclulateProtein
                                                                      .toString() ?? "") +
                                                                  "g",
                                                              Color(BLACK),
                                                              14,
                                                            ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Divider(
                                              height: 1,
                                              thickness: 1,
                                              color: Color(DIVIDERCOLOR)),
                                        ],
                                      );
                                    }),
                                SizedBox(
                                  height: 10,
                                ),
                                WidgetText.widgetPoppinsMediumText(
                                  "Total",
                                  Color(BLACK),
                                  16,
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        padding:
                                            EdgeInsets.fromLTRB(0, 15, 0, 15),
                                        decoration: BoxDecoration(
                                          color: Color(WHITE),
                                          shape: BoxShape.rectangle,
                                          border: Border.all(
                                              color: Color(ORANGE), width: 1),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            WidgetText.widgetPoppinsRegularText(
                                              "Calories",
                                              Color(BLACK),
                                              13,
                                            ),
                                            WidgetText.widgetPoppinsMediumText(
                                              logic.caloriesTotal.toString(),
                                              Color(BLACK),
                                              14,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Expanded(
                                      child: Container(
                                        padding:
                                            EdgeInsets.fromLTRB(0, 15, 0, 15),
                                        decoration: BoxDecoration(
                                          color: Color(WHITE),
                                          shape: BoxShape.rectangle,
                                          border: Border.all(
                                              color: Color(ORANGE), width: 1),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            WidgetText.widgetPoppinsRegularText(
                                              "Fat",
                                              Color(BLACK),
                                              13,
                                            ),
                                            WidgetText.widgetPoppinsMediumText(
                                              logic.fatTotal.toString() + "g",
                                              Color(BLACK),
                                              14,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Expanded(
                                      child: Container(
                                        padding:
                                            EdgeInsets.fromLTRB(0, 15, 0, 15),
                                        decoration: BoxDecoration(
                                          color: Color(WHITE),
                                          shape: BoxShape.rectangle,
                                          border: Border.all(
                                              color: Color(ORANGE), width: 1),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            WidgetText.widgetPoppinsRegularText(
                                              "Carbs",
                                              Color(BLACK),
                                              13,
                                            ),
                                            WidgetText.widgetPoppinsMediumText(
                                              logic.carbsTotal.toString() + "g",
                                              Color(BLACK),
                                              14,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Expanded(
                                      child: Container(
                                        padding:
                                            EdgeInsets.fromLTRB(0, 15, 0, 15),
                                        decoration: BoxDecoration(
                                          color: Color(WHITE),
                                          shape: BoxShape.rectangle,
                                          border: Border.all(
                                              color: Color(ORANGE), width: 1),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            WidgetText.widgetPoppinsRegularText(
                                              "Protein",
                                              Color(BLACK),
                                              13,
                                            ),
                                            WidgetText.widgetPoppinsMediumText(
                                              logic.proteinTotal.toString() +
                                                  "g",
                                              Color(BLACK),
                                              14,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 15,
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
                                    children: [
                                      WidgetText.widgetPoppinsMediumText(
                                        "Price Details",
                                        Color(BLACK),
                                        18,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Expanded(
                                            child: Align(
                                              alignment: Alignment.topLeft,
                                              child: logic.getMenuCartModel.data
                                                          ?.cartMenu ==
                                                      null
                                                  ? Text('')
                                                  : WidgetText
                                                      .widgetPoppinsMediumText(
                                                "Amount",
                                                      Color(BLACK),
                                                      14,
                                                    ),
                                            ),
                                          ),

                                          // logic.getMenuCartModel
                                          //             .subTotal ==
                                          //         0
                                          //     ? Text('0') :
                                          WidgetText.widgetPoppinsMediumText(
                                            logic.getMenuCartModel.subTotal == 0
                                                ? "\$0"
                                                : "\$" +
                                                    (logic.getMenuCartModel
                                                            .subTotal
                                                            ?.toStringAsFixed(
                                                                2) ??
                                                        ""),
                                            Color(ORANGE),
                                            14,
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Expanded(
                                            child: Align(
                                              alignment: Alignment.topLeft,
                                              child: WidgetText
                                                  .widgetPoppinsMediumText(
                                                "Tax",
                                                Color(BLACK),
                                                14,
                                              ),
                                            ),
                                          ),
                                          logic.getMenuCartModel.taxAmount ==
                                                  null
                                              ? Text("\$")
                                              : WidgetText
                                                  .widgetPoppinsMediumText(
                                                  "\$" +
                                                      "${logic.getMenuCartModel.taxAmount.toStringAsFixed(2)}",
                                                  Color(ORANGE),
                                                  14,
                                                )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Expanded(
                                            child: Align(
                                              alignment: Alignment.topLeft,
                                              child: WidgetText
                                                  .widgetPoppinsMediumText(
                                                "Discount",
                                                Color(BLACK),
                                                14,
                                              ),
                                            ),
                                          ),
                                          logic.getMenuCartModel.discount ==
                                                  null
                                              ? Text("\$")
                                              : WidgetText
                                                  .widgetPoppinsMediumText(
                                                  "\$" +
                                                      (logic.getMenuCartModel
                                                              .discount
                                                              ?.toStringAsFixed(
                                                                  2) ??
                                                          ""),
                                                  Color(ORANGE),
                                                  14,
                                                )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Expanded(
                                            child: Align(
                                              alignment: Alignment.topLeft,
                                              child: WidgetText
                                                  .widgetPoppinsMediumText(
                                                "Delivery charges",
                                                Color(BLACK),
                                                14,
                                              ),
                                            ),
                                          ),
                                          logic.getMenuCartModel
                                                      .deliveryCharges ==
                                                  null
                                              ? Text("\$")
                                              : WidgetText
                                                  .widgetPoppinsMediumText(
                                                  "\$" +
                                                      "${(logic.getMenuCartModel.deliveryCharges?.toStringAsFixed(2) ?? "")}",
                                                  Color(ORANGE),
                                                  14,
                                                )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Divider(
                                        color: Color(LIGHTDIVIDERCOLOR),
                                        height: 1,
                                        thickness: 1,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Expanded(
                                            child: Align(
                                              alignment: Alignment.topLeft,
                                              child: WidgetText
                                                  .widgetPoppinsMediumText(
                                                "Total",
                                                Color(BLACK),
                                                16,
                                              ),
                                            ),
                                          ),
                                          logic.getMenuCartModel.total == null
                                              ? Text("\$")
                                              : WidgetText
                                                  .widgetPoppinsMediumText(
                                                  "\$" +
                                                      "${(logic.getMenuCartModel.total?.toStringAsFixed(2) ?? "")}",
                                                  // "${logic.getMenuCartModel.calculateSubTotal + logic.getMenuCartModel.tax + logic.getMenuCartModel.deliveryCharges - int.parse(logic.getMenuCartModel.discount.toString())}",
                                                  Color(ORANGE),
                                                  16,
                                                )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                WidgetButton.widgetDefaultButton(
                                    "Proceed to checkout",
                                    onClickOrderCheckOut),
                                SizedBox(
                                  height: 15,
                                ),
                              ],
                            ),
                          );
              });
      })),
    );
  }

  callDecAPI(String restaurantId, String menuId, MenuCartController logic) async {
    debugPrint("_isDecrimentEnable  $_isDecrimentEnable");
    debugPrint("restaurantId  $restaurantId, menuId: $menuId");
    if(_isDecrimentEnable){
      _isDecrimentEnable=false;
      await logic.decrementQtyApi(restaurantId: restaurantId,
          menuId: menuId,
          selectQty: 1);

      if(logic.getQtyUpdateModel.meta?.status ==true) {
        await logic.callGetCartAPI();
        if(logic.getMenuCartModel.meta?.status == true) {
          setState(() {
            _isDecrimentEnable=true;
          });
        }
      }
    }
  }


  onClickOrderCheckOut() async {
    await Get.to(() => OrderCheckoutScreen(
          caloriesTotal: menuCartController.caloriesTotal,
          carbsTotal: menuCartController.carbsTotal,
          fatTotal: menuCartController.fatTotal,
          proteinTotal: menuCartController.proteinTotal,
        ));
    /* if(menuCartController.getCustomModelList.length == 0) {
      final prefs = await SharedPreferences.getInstance();
      debugPrint('Remove');
      setState(() {
      menuCartController.getCustomModelList.clear();
      prefs.setString(PREF_CUSTOMCARTLIST, jsonEncode(menuCartController.getCustomModelList));
      debugPrint('getCustomModelList clear Len => ${menuCartController.getCustomModelList.length} ');
      prefs.remove(PREF_CUSTOMCARTLIST);
        menuCartController.callGetCartAPI();
      });
    }*/
  }
}

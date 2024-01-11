import 'package:choosifoodi/core/utils/app_color_utils.dart';
import 'package:choosifoodi/core/utils/app_images_utils.dart';
import 'package:choosifoodi/core/widgets/widget_button.dart';
import 'package:choosifoodi/core/widgets/widget_text.dart';
import 'package:choosifoodi/screens/restaurants_panel/ledger/controller/get_sales_controller.dart';
import 'package:choosifoodi/screens/restaurants_panel/ledger/leger_filter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import '../../../../core/utils/app_constants.dart';
import '../../../../core/utils/app_font_utils.dart';
import '../../../../core/utils/app_strings_constants.dart';
import '../../../../core/utils/networkManager.dart';
import '../../../../core/widgets/widget_card.dart';
import '../../../../core/widgets/widget_webview.dart';
import '../../../../routes/general_path.dart';
import '../../order/model/normal_rest_order_model.dart';

class SaleHistoryScreen extends StatefulWidget {
  dynamic commission;

  SaleHistoryScreen({this.commission});

  @override
  _SaleHistoryScreenState createState() => _SaleHistoryScreenState(commission);
}

class _SaleHistoryScreenState extends State<SaleHistoryScreen> {
  dynamic commission;

  _SaleHistoryScreenState(dynamic commission) {
    this.commission = commission;
  }

  final GetSalesController _getSalesController = Get.put(GetSalesController());
  final GetXNetworkManager _networkManager = Get.put(GetXNetworkManager());
  TextEditingController _searchCtr = TextEditingController();
  bool isChecked = true;
  var startSearch, endSearch;
  var finalUri = GeneralPath.API_REST_SALES_LIST;

  @override
  void initState() {
    debugPrint('commission :==> $commission');
    if (_networkManager.connectionType != 0) {
      debugPrint('Connection Type: ${_networkManager.connectionType}');
      startSearch = "";
      endSearch = "";
      _getSalesController.callGetSalesHistoryAPI(finalUri);
    }
    super.initState();
  }

  DateRangePickerController _dateRangePickerController =
      DateRangePickerController();
  String _startDate = "", _endDate = "";

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    debugPrint('args: =>${args.value.toString()}');
    if (args.value.startDate != null && args.value.endDate != null) {
      setState(() {
        _startDate =
            formatterMonth.format(args.value.startDate).toString();
        _endDate = formatterMonth
            .format(args.value.endDate ?? args.value.endDate)
            .toString();
        print('StartDate: $_startDate : EndDate: $_endDate');
        // calculateMiliSecond(args);
        startSearch = DateTime.parse(args.value.startDate.toString())
            .millisecondsSinceEpoch;
        endSearch = DateTime.parse(args.value.endDate.toString())
            .add(Duration(hours: 23, minutes: 59))
            .millisecondsSinceEpoch;
        print('Start: $startSearch, end: $endSearch');
      });
    }
  }

  String deliveryDate = "";

  String parseTimeCreated(int value) {
    var date = DateTime.fromMicrosecondsSinceEpoch(value * 1000);
    var d12 = formatterMonthWithTime.format(date);
    deliveryDate = d12;
    print('deliveryDate: $deliveryDate');
    return d12;
  }

  void getDateRangePicker() {
    showDialog(
        context: context,
        builder: (BuildContext context) => Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              child: new Container(
                  height: MediaQuery.of(context).size.height / 2,
                  padding: EdgeInsets.all(10),
                  child: SfDateRangePicker(
                    view: DateRangePickerView.month,
                    monthViewSettings:
                        DateRangePickerMonthViewSettings(firstDayOfWeek: 6),
                    showActionButtons: true,
                    controller: _dateRangePickerController,
                    onSubmit: (val) {
                      Navigator.pop(context);
                    },
                    onCancel: () {
                      _dateRangePickerController.selectedRanges = null;
                      Navigator.pop(context);
                    },
                    selectionMode: DateRangePickerSelectionMode.range,
                    onSelectionChanged: _onSelectionChanged,
                  )),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(WHITE),
      appBar: WidgetAppbar.simpleAppBar(context, saleHistoryTxt, true),
      body: SafeArea(
          child: GetBuilder<GetXNetworkManager>(builder: (networkManager) {
        return networkManager.connectionType == 0
            ? Center(child: Text(check_internet))
            : Column(
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  /*      Container(
                    margin: EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      children: [
                        Flexible(
                          child: Card(
                            // margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
                            elevation: 5,
                            color: Color(WHITE),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: Container(
                              child: TextFormField(
                                textAlign: TextAlign.start,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  prefixIcon: Icon(Icons.search),
                                  hintStyle: TextStyle(
                                    color: Color(0xff8C8989),
                                    fontSize: 13,
                                    fontFamily: FontPoppins,
                                    fontWeight: PoppinsRegular,
                                  ),
                                  hintText: "Order ID",
                                ),
                                style: TextStyle(
                                  color: Color(0xff3E4958),
                                  fontSize: 13,
                                  fontFamily: FontPoppins,
                                  fontWeight: PoppinsRegular,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        InkWell(
                          onTap: onClickFilter,
                          child: Image.asset(
                            ic_filter,
                            width: 30,
                            color: Color(BLACK),
                            height: 30,
                          ),
                        ),
                      ],
                    ),
                  ),*/
                  Container(
                      margin: EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        children: [
                          Expanded(
                            child: Card(
                              // margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
                              elevation: 5,
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Color(WHITE),
                                    borderRadius: BorderRadius.circular(12.0)),
                                child: TextFormField(
                                  controller: _searchCtr,
                                  textAlign: TextAlign.start,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    prefixIcon: Icon(Icons.search),
                                    hintStyle: TextStyle(
                                      color: Color(0xff8C8989),
                                      fontSize: 13,
                                      fontFamily: FontPoppins,
                                      fontWeight: PoppinsRegular,
                                    ),
                                    hintText: orderId,
                                  ),
                                  onFieldSubmitted: (val){
                                    _getSalesController.callGetSalesHistoryAPI(
                                        finalUri +
                                            "&searchKey=${val}");
                                  },
                                  onChanged: (val){
                                    if(val.isEmpty){
                                      _getSalesController.callGetSalesHistoryAPI(finalUri);
                                    }
                                  },
                                  style: TextStyle(
                                    color: Color(0xff3E4958),
                                    fontSize: 13,
                                    fontFamily: FontPoppins,
                                    fontWeight: PoppinsRegular,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Card(
                              elevation: 2,
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Color(WHITE),
                                    borderRadius: BorderRadius.circular(12.0)),
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(15, 0, 6, 0),
                                  child: InkWell(
                                    onTap: getDateRangePicker,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 5,
                                          child: Container(
                                              color: Colors.white,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 15),
                                                child: WidgetText
                                                    .widgetPoppinsRegularOverflowText(
                                                  _startDate == ""
                                                      ? choose_date_range
                                                      : _startDate +
                                                          ' - ' +
                                                          _endDate,
                                                  _startDate == ""
                                                      ? Color(GREY2)
                                                      : Color(BLACK),
                                                  13,
                                                ),
                                              )),
                                        ),
                                        Expanded(
                                          flex: 3,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                              right: 10.0,
                                            ),
                                            child: SizedBox(
                                                height: 20.0,
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: Image.asset(
                                                    ic_calender,
                                                    height: 17,
                                                    fit: BoxFit.fill,
                                                  ),
                                                )),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        Expanded(
                          // flex: 5,
                          child: Container(
                            // margin: EdgeInsets.symmetric(horizontal: 15),
                            child: WidgetButton.widgetDefaultButton(
                                export_excel, () {
                              onClickExport(
                                  normalRestOrderModel:
                                      _getSalesController.saleHistoryModel);
                            }),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          // flex: 3,
                          child: InkWell(
                            onTap: () {
                              print('Searchkey: ${_searchCtr.text}');
                              print('startSearch: ${startSearch}');
                              if (startSearch.toString().isNotEmpty &&
                                  _searchCtr.text.isEmpty) {
                                print("if");
                                _getSalesController.callGetSalesHistoryAPI(
                                    finalUri +
                                        "&startDate=$startSearch&&endDate=$endSearch");
                              } else if (_searchCtr.text.isNotEmpty &&
                                  startSearch.toString().isEmpty) {
                                print(" else if 1");
                                _getSalesController.callGetSalesHistoryAPI(
                                    finalUri + "&searchKey=${_searchCtr.text}");
                              } else if (startSearch.toString().isNotEmpty &&
                                  _searchCtr.text.isNotEmpty) {
                                print(" else if 2");
                                _getSalesController.callGetSalesHistoryAPI(
                                    finalUri +
                                        "&searchKey=${_searchCtr.text}&&startDate=$startSearch&&endDate=$endSearch");
                              } else {
                                print(" else");
                                _getSalesController.callGetSalesHistoryAPI(
                                    GeneralPath.API_REST_SALES_LIST);
                              }
                              // _getSalesController.callGetSalesHistoryAPI(finalUri + "&startDate=$startSearch&&endDate=$endSearch" );
                            },
                            child: Container(
                              padding: EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Color(ORANGE),
                                shape: BoxShape.rectangle,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(7)),
                              ),
                              alignment: Alignment.center,
                              child: WidgetText.widgetPoppinsMediumText(
                                filter,
                                Color(WHITE),
                                16,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  GetBuilder<GetSalesController>(builder: (logic) {
                    return logic.isLoaderVisible
                        ? Center(
                            child: CircularProgressIndicator(
                              color: Color(ORANGE),
                            ),
                          )
                        : logic.saleHistoryModel.meta?.status == false
                            ? Container(
                                margin: EdgeInsets.symmetric(vertical: 20),
                                child: Text('No Sales Found'),
                              )
                            : Expanded(
                                child: ListView.builder(
                                    physics: BouncingScrollPhysics(),
                                    itemCount:
                                        logic.saleHistoryModel.data?.length,
                                    itemBuilder: (context, index) {
                                      dynamic total, youEarned, commissionAmt;
                                      if (logic.saleHistoryModel.data?[index]
                                                  .deliveryDate ==
                                              0 ||
                                          logic.saleHistoryModel.data?[index]
                                                  .deliveryDate ==
                                              null) {
                                        deliveryDate = "";
                                      } else {
                                        parseTimeCreated(int.parse(logic
                                            .saleHistoryModel
                                            .data![index]
                                            .deliveryDate
                                            .toString()));
                                      }

                                      if (logic.saleHistoryModel.data?[index]
                                              .total !=
                                          null) {
                                        total = logic
                                            .saleHistoryModel.data?[index].total
                                            .toString();
                                        // print('total: $total');
                                        commissionAmt = (double.parse(total) *
                                            commission /
                                            100);
                                        youEarned = (double.parse(total) -
                                            commissionAmt);
                                      } else {
                                        youEarned = 0;
                                      }
                                      // print('commissionAmt: $commissionAmt');
                                      // print('youEarned: $youEarned');

                                      return InkWell(
                                        // onTap: onClickFoodDetail,
                                        child: Container(
                                          margin: EdgeInsets.all(15),
                                          width: 280,
                                          child: Container(
                                            padding: EdgeInsets.all(10),
                                            margin: EdgeInsets.only(bottom: 20),
                                            decoration: BoxDecoration(
                                              color: Color(WHITE),
                                              shape: BoxShape.rectangle,
                                              border: Border.all(
                                                  color: Color(ORANGE),
                                                  width: 1),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)),
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    logic
                                                                .saleHistoryModel
                                                                .data?[index]
                                                                .restaurantData
                                                                .restaurantImg
                                                                .first ==
                                                            null
                                                        ? Image.asset(
                                                            ic_no_image,
                                                            width: 80,
                                                            height: 70,
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
                                                                  .saleHistoryModel
                                                                  .data![index]
                                                                  .restaurantData
                                                                  .restaurantImg
                                                                  .first
                                                                  .toString(),
                                                              width: 80,
                                                              height: 70,
                                                              fit: BoxFit.fill,
                                                              errorBuilder:
                                                                  (context,
                                                                      error,
                                                                      stackTrace) {
                                                                return Image
                                                                    .asset(
                                                                  ic_no_image,
                                                                  width: 80,
                                                                  height: 70,
                                                                  fit: BoxFit
                                                                      .fill,
                                                                );
                                                              },
                                                            ),
                                                          ),
                                                    SizedBox(
                                                      width: 7,
                                                    ),
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          WidgetText
                                                              .widgetPoppinsRegularText(
                                                            'Restaurant Name:',
                                                            Color(SUBTEXT),
                                                            16,
                                                          ),
                                                          logic
                                                                      .saleHistoryModel
                                                                      .data?[
                                                                          index]
                                                                      .restaurantData
                                                                      .restaurantName ==
                                                                  null
                                                              ? Text('')
                                                              : WidgetText
                                                                  .widgetPoppinsMediumText(
                                                                  logic
                                                                          .saleHistoryModel
                                                                          .data?[
                                                                              index]
                                                                          .restaurantData
                                                                          .restaurantName
                                                                          .toString() ??
                                                                      "",
                                                                  Color(BLACK),
                                                                  16,
                                                                ),
                                                          /* Row(
                                                  children: [
                                                    WidgetText.widgetPoppinsRegularText(
                                                      'Quantity:',
                                                      Color(SUBTEXT),
                                                      16,
                                                    ),
                                                    SizedBox(width: 5,),
                                                    WidgetText.widgetPoppinsRegularText(
                                                      logic.saleHistoryModel.data?[index].productDetails[0].selectQuantity.toString() ?? "",
                                                      Color(BLACK),
                                                      16,
                                                    ),
                                                  ],
                                                )*/
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 15,
                                                ),
                                                WidgetText
                                                    .widgetPoppinsRegularText(
                                                        "Order ID",
                                                        Color(SUBTEXT),
                                                        14),
                                                WidgetText
                                                    .widgetPoppinsMediumText(
                                                        logic
                                                                .saleHistoryModel
                                                                .data?[index]
                                                                .menuOrderID ??
                                                            "",
                                                        Color(BLACK),
                                                        14),
                                                SizedBox(
                                                  height: 15,
                                                ),
                                                WidgetText
                                                    .widgetPoppinsRegularText(
                                                        "Order Type",
                                                        Color(SUBTEXT),
                                                        14),
                                                WidgetText
                                                    .widgetPoppinsMediumText(
                                                        logic
                                                                .saleHistoryModel
                                                                .data?[index]
                                                                .orderType ??
                                                            "",
                                                        Color(BLACK),
                                                        14),
                                                SizedBox(
                                                  height: 15,
                                                ),
                                                WidgetText
                                                    .widgetPoppinsRegularText(
                                                        "Sale Amount",
                                                        Color(SUBTEXT),
                                                        14),
                                                logic
                                                            .saleHistoryModel
                                                            .data?[index]
                                                            .total !=
                                                        null
                                                    ? WidgetText
                                                        .widgetPoppinsMediumText(
                                                            // "\$1000",
                                                            "\$" +
                                                                '${logic.saleHistoryModel.data?[index].total.toStringAsFixed(2) ?? ""}',
                                                            Color(BLACK),
                                                            14)
                                                    : Container(),
                                                SizedBox(
                                                  height: 15,
                                                ),
                                                WidgetText
                                                    .widgetPoppinsRegularText(
                                                        "You Earned",
                                                        Color(SUBTEXT),
                                                        14),
                                                youEarned == null
                                                    ? Text('')
                                                    : WidgetText
                                                        .widgetPoppinsMediumText(
                                                            "\$" +
                                                                youEarned
                                                                    .toStringAsFixed(
                                                                        2),
                                                            Color(BLACK),
                                                            14),
                                                SizedBox(
                                                  height: 15,
                                                ),
                                                WidgetText
                                                    .widgetPoppinsRegularText(
                                                        "Commission Amount",
                                                        Color(SUBTEXT),
                                                        14),
                                                commissionAmt == null
                                                    ? Text('')
                                                    : WidgetText
                                                        .widgetPoppinsMediumText(
                                                            "\$" +
                                                                commissionAmt
                                                                    .toStringAsFixed(
                                                                        2),
                                                            Color(BLACK),
                                                            14),
                                                SizedBox(
                                                  height: 15,
                                                ),
                                                WidgetText
                                                    .widgetPoppinsRegularText(
                                                        "Customer Name",
                                                        Color(SUBTEXT),
                                                        14),
                                                logic
                                                            .saleHistoryModel
                                                            .data?[index]
                                                            .userData
                                                            .firstName ==
                                                        null
                                                    ? Container()
                                                    : WidgetText
                                                        .widgetPoppinsMediumText(
                                                            logic
                                                                    .saleHistoryModel
                                                                    .data![
                                                                        index]
                                                                    .userData
                                                                    .firstName
                                                                    .toString() +
                                                                " " +
                                                                logic
                                                                    .saleHistoryModel
                                                                    .data![
                                                                        index]
                                                                    .userData
                                                                    .lastName
                                                                    .toString(),
                                                            // "Rahul Singh"
                                                            Color(BLACK),
                                                            14),
                                                SizedBox(
                                                  height: 15,
                                                ),
                                                WidgetText
                                                    .widgetPoppinsRegularText(
                                                        "Completion Date",
                                                        Color(SUBTEXT),
                                                        14),
                                                WidgetText
                                                    .widgetPoppinsMediumText(
                                                        deliveryDate,
                                                        Color(BLACK),
                                                        14),
                                                SizedBox(
                                                  height: 15,
                                                ),
                                                /*    SizedBox(
                                        height: 15,
                                      ),
                                      WidgetText.widgetPoppinsRegularText(
                                          "City Name/Zip Code",
                                          Color(SUBTEXT),
                                          14),
                                      WidgetText.widgetPoppinsMediumText(
                                          "Bhopal/460003", Color(BLACK), 14),
                                    SizedBox(
                                        height: 15,
                                      ),
                                      Card(
                                        elevation: 0,
                                        color: Color(ITEMBGCOLOR),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        child: Container(
                                          padding: EdgeInsets.all(15),
                                          child: Column(
                                            children: [
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        WidgetText
                                                            .widgetPoppinsRegularText(
                                                                "Menu items",
                                                                Color(SUBTEXT),
                                                                13),
                                                        WidgetText
                                                            .widgetPoppinsMediumText(
                                                                "Veg Biryani",
                                                                Color(BLACK),
                                                                13),
                                                      ],
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        WidgetText
                                                            .widgetPoppinsRegularText(
                                                                "Dish codes",
                                                                Color(SUBTEXT),
                                                                13),
                                                        WidgetText
                                                            .widgetPoppinsMediumText(
                                                                "#1",
                                                                Color(BLACK),
                                                                13),
                                                      ],
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
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        WidgetText
                                                            .widgetPoppinsRegularText(
                                                                "Price",
                                                                Color(SUBTEXT),
                                                                13),
                                                        WidgetText
                                                            .widgetPoppinsMediumText(
                                                                "\$200",
                                                                Color(BLACK),
                                                                13),
                                                      ],
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        WidgetText
                                                            .widgetPoppinsRegularText(
                                                                "Total quantity",
                                                                Color(SUBTEXT),
                                                                13),
                                                        WidgetText
                                                            .widgetPoppinsMediumText(
                                                                "5",
                                                                Color(BLACK),
                                                                13),
                                                      ],
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
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        WidgetText
                                                            .widgetPoppinsRegularText(
                                                                "Sale amount",
                                                                Color(SUBTEXT),
                                                                13),
                                                        WidgetText
                                                            .widgetPoppinsMediumText(
                                                                "#1x5=\$1000",
                                                                Color(BLACK),
                                                                13),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Card(
                                        elevation: 0,
                                        color: Color(ITEMBGCOLOR),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        child: Container(
                                          padding: EdgeInsets.all(15),
                                          child: Column(
                                            children: [
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        WidgetText
                                                            .widgetPoppinsRegularText(
                                                                "Menu items",
                                                                Color(SUBTEXT),
                                                                13),
                                                        WidgetText
                                                            .widgetPoppinsMediumText(
                                                                "Burger",
                                                                Color(BLACK),
                                                                13),
                                                      ],
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        WidgetText
                                                            .widgetPoppinsRegularText(
                                                                "Dish codes",
                                                                Color(SUBTEXT),
                                                                13),
                                                        WidgetText
                                                            .widgetPoppinsMediumText(
                                                                "#2",
                                                                Color(BLACK),
                                                                13),
                                                      ],
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
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        WidgetText
                                                            .widgetPoppinsRegularText(
                                                                "Price",
                                                                Color(SUBTEXT),
                                                                13),
                                                        WidgetText
                                                            .widgetPoppinsMediumText(
                                                                "\$100",
                                                                Color(BLACK),
                                                                13),
                                                      ],
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        WidgetText
                                                            .widgetPoppinsRegularText(
                                                                "Total quantity",
                                                                Color(SUBTEXT),
                                                                13),
                                                        WidgetText
                                                            .widgetPoppinsMediumText(
                                                                "5",
                                                                Color(BLACK),
                                                                13),
                                                      ],
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
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        WidgetText
                                                            .widgetPoppinsRegularText(
                                                                "Sale amount",
                                                                Color(SUBTEXT),
                                                                13),
                                                        WidgetText
                                                            .widgetPoppinsMediumText(
                                                                "#2x5=\$500",
                                                                Color(BLACK),
                                                                13),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),*/
                                                SizedBox(
                                                  height: 15,
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    if (logic
                                                            .saleHistoryModel
                                                            .data?[index]
                                                            .menuOrderId
                                                            .isNotEmpty ==
                                                        true) {
                                                      if (logic
                                                              .saleHistoryModel
                                                              .data?[index]
                                                              .menuOrderId !=
                                                          null) {
                                                        Get.to(
                                                            () => WidgetWebview(
                                                                  url: GeneralPath.BASE_URI +
                                                                      GeneralPath
                                                                          .API_INVOICE +
                                                                      (logic.saleHistoryModel.data?[index]
                                                                              .menuOrderId
                                                                              .toString() ??
                                                                          ""), appbarName: viewReceipt,
                                                                ));
                                                      } else {
                                                        showToastMessage(
                                                            "Not Found");
                                                      }
                                                    } else {
                                                      showToastMessage(
                                                          "Not Found");
                                                    }
                                                  },
                                                  child: Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Container(
                                                      width: 120,
                                                      padding:
                                                          EdgeInsets.fromLTRB(
                                                              10, 10, 10, 10),
                                                      decoration: BoxDecoration(
                                                        color: Color(ORANGE),
                                                        shape:
                                                            BoxShape.rectangle,
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    7)),
                                                      ),
                                                      alignment:
                                                          Alignment.center,
                                                      child: WidgetText
                                                          .widgetPoppinsMediumText(
                                                        viewReceipt,
                                                        Color(WHITE),
                                                        13,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 25,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                              );
                  })
                ],
              );
      })),
    );
  }

  onClickExport({required NormalRestOrderModel normalRestOrderModel}) {
    // createExcel
    _getSalesController.createExcel(
        normalRestOrderModel: normalRestOrderModel, commission: commission);
  }

  onClickFilter() {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (BuildContext context) => LegerFilter()));
  }
}

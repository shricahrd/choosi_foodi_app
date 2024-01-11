import 'package:choosifoodi/core/utils/app_color_utils.dart';
import 'package:choosifoodi/core/utils/app_images_utils.dart';
import 'package:choosifoodi/core/widgets/widget_button.dart';
import 'package:choosifoodi/core/widgets/widget_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:intl/intl.dart';
import '../../../../core/utils/app_constants.dart';
import '../../../../core/utils/app_strings_constants.dart';
import '../../../../core/utils/networkManager.dart';
import '../../../../core/widgets/widget_card.dart';
import '../controller/get_payment_controller.dart';
import '../leger_filter.dart';
import '../model/get_payment_history_model.dart.dart';

class PaymentHistoryScreen extends StatefulWidget {
  @override
  _PaymentHistoryScreenState createState() => _PaymentHistoryScreenState();
}

class _PaymentHistoryScreenState extends State<PaymentHistoryScreen> {
  final GetPaymentController _getPaymentController =
      Get.put(GetPaymentController());
  final GetXNetworkManager _networkManager = Get.put(GetXNetworkManager());

  DateRangePickerController _dateRangePickerController =
      DateRangePickerController();
  String createdDate = "";
  String _startDate = "", _endDate = "";

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      _startDate =
          DateFormat('dd-MM-yy').format(args.value.startDate).toString();
      _endDate = DateFormat('dd-MM-yy')
          .format(args.value.endDate ?? args.value.startDate)
          .toString();
    });
  }

  String parseTimeCreated(int value) {
    var date = DateTime.fromMicrosecondsSinceEpoch(value * 1000);
    var d12 = formatterMonth.format(date);
    createdDate = d12;
    print('createdDate: $createdDate');
    return d12;
  }

  void getDateRangePicker() {
    print('In Dialog');
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
                      print('Val: $val');
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
  void initState() {
    if (_networkManager.connectionType != 0) {
      print('Connection Type: ${_networkManager.connectionType}');
      _getPaymentController.callGetPaymentHistoryAPI();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(WHITE),
      appBar: WidgetAppbar.simpleAppBar(context, "Payment History", true),
      body: SafeArea(
          child: GetBuilder<GetXNetworkManager>(builder: (networkManager) {
        return networkManager.connectionType == 0
            ? Center(child: Text(check_internet))
            : Column(
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  /*     Container(
                    margin: EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 8,
                          child: Card(
                            elevation: 2,
                            color: Color(WHITE),
                            shape: RoundedRectangleBorder(
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
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 15),
                                            child: WidgetText
                                                .widgetPoppinsRegularOverflowText(
                                              _startDate == ""
                                                  ? 'Choose Date Range'
                                                  : _startDate +
                                                      ' to ' +
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
                                              alignment: Alignment.centerRight,
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
                        SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          flex: 2,
                          child: InkWell(
                            onTap: onClickFilter,
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
                                "Filter",
                                Color(WHITE),
                                13,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),*/
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 15),
                    child:
                        WidgetButton.widgetDefaultButton("Export To Excel", () {
                      onClickExport(
                          dataList:
                              _getPaymentController.getPaymentHistoryModel);
                    }),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  GetBuilder<GetPaymentController>(builder: (logic) {
                    return logic.isLoaderVisible == false
                        ? logic.getPaymentHistoryModel.meta?.status == false
                            ? Container(
                                margin: EdgeInsets.symmetric(vertical: 20),
                                child: Text('No Payment Found'),
                              )
                            : Expanded(
                                child: ListView.builder(
                                    physics: BouncingScrollPhysics(),
                                    itemCount: logic.getPaymentHistoryModel.data
                                            ?.length ??
                                        2,
                                    itemBuilder: (context, index) {
                                      if (logic.getPaymentHistoryModel
                                              .data?[index].createdAt ==
                                          0) {
                                        createdDate = "";
                                      } else {
                                        parseTimeCreated(int.parse(logic
                                            .getPaymentHistoryModel
                                            .data![index]
                                            .createdAt
                                            .toString()));
                                      }

                                      return InkWell(
                                        // onTap: onClickFoodDetail,
                                        child: Container(
                                          padding: EdgeInsets.all(15),
                                          width: 280,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                margin: EdgeInsets.fromLTRB(
                                                    0, 5, 0, 0),
                                                padding: EdgeInsets.all(15),
                                                decoration: BoxDecoration(
                                                  color: Color(WHITE),
                                                  shape: BoxShape.rectangle,
                                                  border: Border.all(
                                                      color: Color(ORANGE),
                                                      width: 1),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(10)),
                                                ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            WidgetText
                                                                .widgetPoppinsRegularText(
                                                                    "Amount Received",
                                                                    Color(
                                                                        GREY3),
                                                                    14),
                                                            WidgetText
                                                                .widgetPoppinsRegularText(
                                                                    "\$${logic.getPaymentHistoryModel.data?[index].paidAmount.toString() ?? "0"}",
                                                                    Color(
                                                                        BLACK2),
                                                                    14),
                                                          ],
                                                        ),
                                                        Spacer(),
                                                        Row(
                                                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .end,
                                                          children: [
                                                            WidgetText
                                                                .widgetPoppinsRegularText(
                                                                    'S.No. : ',
                                                                    Color(
                                                                        SUBTEXT),
                                                                    14),
                                                            WidgetText
                                                                .widgetPoppinsRegularText(
                                                                    "${index + 1}",
                                                                    Color(
                                                                        BLACK),
                                                                    14),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 15,
                                                    ),
                                                    WidgetText
                                                        .widgetPoppinsRegularText(
                                                            "Bank",
                                                            Color(SUBTEXT),
                                                            14),
                                                    WidgetText.widgetPoppinsRegularText(
                                                        logic
                                                                .getPaymentHistoryModel
                                                                .data?[index]
                                                                .restaurantData
                                                                .bankInformation
                                                                .bankName ??
                                                            "",
                                                        Color(BLACK),
                                                        14),
                                                    SizedBox(
                                                      height: 15,
                                                    ),
                                                    WidgetText
                                                        .widgetPoppinsRegularText(
                                                            "Account Number",
                                                            Color(SUBTEXT),
                                                            14),
                                                    WidgetText.widgetPoppinsRegularText(
                                                        logic
                                                                .getPaymentHistoryModel
                                                                .data?[index]
                                                                .restaurantData
                                                                .bankInformation
                                                                .accountNumber ??
                                                            "",
                                                        Color(BLACK),
                                                        14),
                                                    SizedBox(
                                                      height: 15,
                                                    ),
                                                    WidgetText
                                                        .widgetPoppinsRegularText(
                                                            "Routing Number",
                                                            Color(SUBTEXT),
                                                            14),
                                                    WidgetText.widgetPoppinsRegularText(
                                                        logic
                                                                .getPaymentHistoryModel
                                                                .data?[index]
                                                                .restaurantData
                                                                .bankInformation
                                                                .routingNumber ??
                                                            "",
                                                        Color(BLACK),
                                                        14),
                                                    SizedBox(
                                                      height: 15,
                                                    ),
                                                    WidgetText
                                                        .widgetPoppinsRegularText(
                                                            "Payment Date",
                                                            Color(SUBTEXT),
                                                            14),
                                                    WidgetText
                                                        .widgetPoppinsRegularText(
                                                            createdDate,
                                                            Color(BLACK),
                                                            14),
                                                    SizedBox(
                                                      height: 15,
                                                    ),
                                                    WidgetText
                                                        .widgetPoppinsRegularText(
                                                            "Payment Method",
                                                            Color(SUBTEXT),
                                                            14),
                                                    WidgetText.widgetPoppinsRegularText(
                                                        logic
                                                                .getPaymentHistoryModel
                                                                .data?[index]
                                                                .paymentMode ??
                                                            "",
                                                        Color(BLACK),
                                                        14),
                                                    SizedBox(
                                                      height: 15,
                                                    ),
                                                    WidgetText
                                                        .widgetPoppinsRegularText(
                                                            "Transaction ID",
                                                            Color(SUBTEXT),
                                                            14),
                                                    WidgetText.widgetPoppinsRegularText(
                                                        logic
                                                                .getPaymentHistoryModel
                                                                .data?[index]
                                                                .transactionId ??
                                                            "#",
                                                        Color(BLACK),
                                                        14),
                                                    SizedBox(
                                                      height: 15,
                                                    ),
                                                    WidgetText
                                                        .widgetPoppinsRegularText(
                                                            "Payment ID",
                                                            Color(SUBTEXT),
                                                            14),
                                                    WidgetText
                                                        .widgetPoppinsRegularText(
                                                            logic
                                                                    .getPaymentHistoryModel
                                                                    .data?[
                                                                        index]
                                                                    .paymentId ??
                                                                "#",
                                                            Color(BLACK),
                                                            14),
                                                    SizedBox(
                                                      height: 15,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    }),
                              )
                        : Center(
                            child: CircularProgressIndicator(
                              color: Color(ORANGE),
                            ),
                          );
                  })
                ],
              );
      })),
    );
  }

  onClickExport({required GetPaymentHistoryModel dataList}) {
    _getPaymentController.createExcel(getPaymentHistoryModel: dataList);
  }

  onClickFilter() {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (BuildContext context) => LegerFilter()));
  }
}

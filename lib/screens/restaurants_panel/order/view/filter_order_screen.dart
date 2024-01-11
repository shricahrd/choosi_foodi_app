import 'package:choosifoodi/core/utils/app_color_utils.dart';
import 'package:choosifoodi/core/utils/app_images_utils.dart';
import 'package:choosifoodi/core/widgets/widget_button.dart';
import 'package:choosifoodi/core/widgets/widget_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import '../../../../core/utils/app_constants.dart';
import '../../../../core/utils/app_font_utils.dart';
import '../../../../core/utils/app_strings_constants.dart';
import '../../../../core/widgets/widget_card.dart';

class FilterOrdersScreen extends StatefulWidget {
  int orderType;
  FilterOrdersScreen({required this.orderType});
  @override
  _FilterOrdersScreenState createState() => _FilterOrdersScreenState();
}

class _FilterOrdersScreenState extends State<FilterOrdersScreen> {
  int selectedOrderIndex = 0;
  int selectedDeliveryIndex = 0;
  int orderStatusIndex = 0;
  int deliveryTypeIndex = 0;
  DateRangePickerController _dateRangePickerController = DateRangePickerController();
  TextEditingController textInputField = TextEditingController();
  late String _startDate, _endDate;
  // String? selectStatus = "Order Status";
  String? selectOrderType = selOrderType;
  // String? selectDeliveryType = "Pickup";
  var startDateSearch, endDateSearch;
  List statusList = ['Order Status', 'Accepted', 'Pending',];
  List deliveryList = [selOrderType, 'Pickup', 'Delivery','Scheduled'];

  @override
  void initState() {
    _startDate = "";
    _endDate = "";
    super.initState();
  }

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      // _startDate = DateFormat('dd, MMMM yyyy').format(args.value.startDate).toString();
      // _endDate = DateFormat('dd, MMMM yyyy').format(args.value.endDate ?? args.value.startDate).toString();
      if(args.value.startDate != null && args.value.endDate != null) {
        _startDate = formatterMonth.format(args.value.startDate);
        _endDate = formatterMonth.format(args.value.endDate);
        startDateSearch = args.value.startDate.millisecondsSinceEpoch;
        endDateSearch = args.value.endDate.add(Duration(hours: 23, minutes: 59)).millisecondsSinceEpoch;
        debugPrint('Start: $startDateSearch, end: $endDateSearch');
      }
    });
  }

  void getDateRangePicker() {
    debugPrint('In Dialog');
    showDialog(
        context: context,
        builder: (BuildContext context) =>
            Dialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
          child: Container(
              height: MediaQuery.of(context).size.height / 2,
              // width: MediaQuery.of(context).size.width / 1,
              child: SfDateRangePicker(
                view: DateRangePickerView.month,
                monthViewSettings: DateRangePickerMonthViewSettings(firstDayOfWeek: 6),
                showActionButtons: true,
                controller: _dateRangePickerController,
                onSubmit: (val){
                  debugPrint('Val: $val');
                  Navigator.pop(context);
                },
                onCancel: (){
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
      appBar: WidgetAppbar.simpleAppBar(context,  "Filter", true),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Container(
                height: 70,
                // padding: const EdgeInsets.symmetric(horizontal: 5,),

                child: Card(
                  elevation: 3,
                  margin: EdgeInsets.symmetric(
                      horizontal: 15, vertical: 10),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(WHITE),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: InkWell(
                      onTap: (){
                        getDateRangePicker();
                      },
                      child: Row(
                        children: [
                          Expanded(
                            flex: 8,
                            child: Container(
                                // color: Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: WidgetText.widgetPoppinsMaxLineOverflowText(
                                    _startDate == "" ? 'Date Range' : _startDate + ' to ' + _endDate,
                                    _startDate == "" ? Color(GREY1) : Color(BLACK),
                                    14,
                                    maxline: 1
                                  ),
                                )),
                          ),
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 10.0,),
                              child: SizedBox(
                                  height: 20.0,
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Image.asset(
                                      ic_calender,
                                      height: 20,
                                      // width: double.infinity,
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
              /*SizedBox(
                height: 10,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Card(
                  // margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                  margin: EdgeInsets.symmetric(
                      horizontal: 15, vertical: 10),
                  color: Color(WHITE),
                  elevation: 3.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  shadowColor: Color(BLACK),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: DropdownButton(
                      underline: Container(),
                      borderRadius: BorderRadius.circular(10),
                      icon: Visibility(
                        visible: true,
                        child: Image.asset(
                          ic_down_arrow,
                          height: 10,
                          width: 20,
                          color: Color(DARKGREY),
                        ),
                      ),
                      isExpanded: true,
                      value: selectStatus == "Order Status"
                          ? statusList[0].toString()
                          : selectStatus,
                      style: TextStyle(
                        color: Color(BLACK),
                        fontSize: 14,
                        fontFamily: FontPoppins,
                        fontWeight: PoppinsRegular,
                      ),
                      onChanged: (value) {
                        setState(() {
                          selectStatus = value.toString();
                          // controller.text = value.toString();
                          debugPrint('selectStatus : ${selectStatus}');
                        });
                      },
                      items: statusList.map((dynamic value) {
                        return DropdownMenuItem<String>(
                          child: Text(
                            value,
                            style: TextStyle(
                              color:
                              selectStatus == "Order Status" ? Color(GREY1) : Color(BLACK),
                              fontSize: 14,
                              fontFamily: FontRoboto,
                              fontWeight: RobotoRegular,
                            ),
                          ),
                          value: value,
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),*/
              SizedBox(
                height: 15,
              ),
              Card(
                margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
                elevation: 3,
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(WHITE),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  padding: EdgeInsets.only(left: 10),
                  child: TextFormField(
                    controller: textInputField,
                    textAlign: TextAlign.start,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintStyle: TextStyle(
                        color: Color(GREY1),
                        fontSize: 14,
                        fontFamily: FontPoppins,
                        fontWeight: PoppinsRegular,
                      ),
                      hintText: "Order Id or Name",
                    ),
                    style: TextStyle(
                      color: Color(BLACK),
                      fontSize: 14,
                      fontFamily: FontPoppins,
                      fontWeight: PoppinsRegular,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Card(
                  // margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                  margin: EdgeInsets.symmetric(
                      horizontal: 15, vertical: 10),
                  elevation: 3.0,
                  shadowColor: Color(BLACK),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(WHITE),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: DropdownButton(
                      underline: Container(),
                      borderRadius: BorderRadius.circular(10),
                      icon: Visibility(
                        visible: true,
                        child: Image.asset(
                          ic_down_arrow,
                          height: 10,
                          width: 20,
                          color: Color(DARKGREY),
                        ),
                      ),
                      isExpanded: true,
                      value: selectOrderType == selOrderType
                          ? deliveryList[0].toString()
                          : selectOrderType,
                      style: TextStyle(
                        color: Color(BLACK),
                        fontSize: 14,
                        fontFamily: FontPoppins,
                        fontWeight: PoppinsRegular,
                      ),
                      onChanged: (value) {
                        setState(() {
                          selectOrderType = value.toString();
                          debugPrint('selectDeliveryType : $selectOrderType');
                        });
                      },
                      items: deliveryList.map((dynamic value) {
                        return DropdownMenuItem<String>(
                          child: Text(
                            value,
                            style: TextStyle(
                                color: selectOrderType == selOrderType ? Color(GREY1) : Color(BLACK),
                              // color: Color(BLACK),
                              fontSize: 14,
                              fontFamily: FontPoppins,
                              fontWeight: RobotoRegular,
                            ),
                          ),
                          value: value,
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child:
                      WidgetButton.widgetDefaultButton("Filter", onClickExport)),
            ],
          ),
        ),
      ),
    );
  }

  onClickExport() {
    // debugPrint("selectOrderType: ${selectOrderType},widget.orderType: ${widget.orderType} ");
    final data = {
      'orderType': widget.orderType,
      'startDateSearch': startDateSearch ?? "",
      'endDateSearch': endDateSearch ?? "",
      'selectOrderType': selectOrderType,
      'searchKey': textInputField.text,
    };
    debugPrint("data: $data");
    Get.back(canPop: true, result: data);
    // Navigator.of(context).pushReplacement(MaterialPageRoute(
    //     builder: (BuildContext context) =>
    //         NormalRestOrderScreen(orderType: widget.orderType, startDate: '$startDateSearch', endDate: '$endDateSearch', orderTypeData: '$selectOrderType', searchKey: '${textInputField.text}',)));
  }
}


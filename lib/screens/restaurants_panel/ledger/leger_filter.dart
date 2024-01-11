import 'package:choosifoodi/core/utils/app_color_utils.dart';
import 'package:choosifoodi/core/utils/app_font_utils.dart';
import 'package:choosifoodi/core/utils/app_images_utils.dart';
import 'package:choosifoodi/core/widgets/widget_button.dart';
import 'package:choosifoodi/core/widgets/widget_text.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:intl/intl.dart';

class LegerFilter extends StatefulWidget {
  LegerFilter({Key? key}) : super(key: key);

  @override
  State<LegerFilter> createState() => _LegerFilterState();
}

class _LegerFilterState extends State<LegerFilter> {

  DateRangePickerController _dateRangePickerController = DateRangePickerController();
  String _startDate = "", _endDate = "";
  String? selectDeliveryType = "Delivery Type";
  List deliveryList = ['Delivery Type', 'Pickup', 'Delivery','Scheduled'];

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      _startDate =
          DateFormat('dd, MMMM yyyy').format(args.value.startDate).toString();
      _endDate = DateFormat('dd, MMMM yyyy').format(args.value.endDate ?? args.value.startDate).toString();
    });
  }

  void getDateRangePicker() {
    print('In Dialog');
    showDialog(
        context: context,
        builder: (BuildContext context) =>
            Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              child: new  Container(
                  height: MediaQuery.of(context).size.height / 2,
                  padding: EdgeInsets.all(0),
                  child: SfDateRangePicker(
                    view: DateRangePickerView.month,
                    monthViewSettings: DateRangePickerMonthViewSettings(firstDayOfWeek: 6),
                    showActionButtons: true,
                    controller: _dateRangePickerController,
                    onSubmit: (val){
                      print('Val: $val');
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
    String date = "";

    return Scaffold(
        backgroundColor: Color(WHITE),
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.transparent, //change your color here
          ),
          toolbarHeight: 60,
          shadowColor: Color(HINTCOLOR),
          backgroundColor: Color(WHITE),
          flexibleSpace: Container(
            height: double.infinity,
            padding: EdgeInsets.fromLTRB(15, 0, 15, 15),
            alignment: Alignment.bottomCenter,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
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
                WidgetText.widgetPoppinsRegularText(
                  "Filter",
                  Color(BLACK),
                  16,
                )
              ],
            ),
          ),
        ),
        body: SafeArea(
          child: Container(
            margin: EdgeInsets.only(top: 20, left: 20, right: 20),
            child: Column(
              children: [
                Card(
                  elevation: 5,
                  color: Color(WHITE),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  child: InkWell(
                    onTap: (){
                      getDateRangePicker();
                    },
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(15, 0, 6, 0),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 5,
                            child: Container(
                                color: Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 15),
                                  child: WidgetText.widgetPoppinsRegularOverflowText(
                                    _startDate == "" ? 'Date Range' : _startDate + ' to ' + _endDate,
                                    _startDate == "" ? Color(GREYCOLORICON) : Color(BLACK),
                                    13,
                                  ),
                                )),
                          ),
                          Expanded(
                            flex: 3,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 10.0,),
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

                SizedBox(height: 20,),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Card(
                    color: Color(WHITE),
                    elevation: 5.0,
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
                            color: Color(BLACK),
                          ),
                        ),
                        isExpanded: true,
                        value: selectDeliveryType == "Delivery Type"
                            ? deliveryList[0].toString()
                            : selectDeliveryType,
                        style: TextStyle(
                          color: Color(BLACK),
                          fontSize: 16,
                          fontFamily: FontPoppins,
                          fontWeight: PoppinsRegular,
                        ),
                        onChanged: (value) {
                          setState(() {
                            selectDeliveryType = value.toString();
                            // controller.text = value.toString();
                            debugPrint('Select Delivery Type : $selectDeliveryType');
                          });
                        },
                        items: deliveryList.map((dynamic value) {
                          return DropdownMenuItem<String>(
                            child: Text(
                              value,
                              style: TextStyle(
                                color: selectDeliveryType == "Delivery Type" ? Color(SUBTEXT) : Color(BLACK),
                                // color: Color(BLACK),
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
                ),
                SizedBox(height: 20,),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 3, vertical: 10),
                  child: WidgetButton.widgetDefaultButton(
                      "Filter", (){}),
                ),
              ],
            ),
          ),
        ));
  }
}

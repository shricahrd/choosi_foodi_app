import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../../core/utils/app_color_utils.dart';
import '../../../../core/utils/app_constants.dart';
import '../../../../core/utils/app_images_utils.dart';
import '../../../../core/utils/app_strings_constants.dart';
import '../../../../core/utils/networkManager.dart';
import '../../../../core/widgets/widget_card.dart';
import '../../../../core/widgets/widget_text.dart';
import '../controller/rest_review_controller.dart';

class ReviewRestScreen extends StatefulWidget {
  dynamic totalRating;
  dynamic totalReview;

  ReviewRestScreen({
    Key? key, this.totalRating, this.totalReview}) : super(key: key);

  @override
  State<ReviewRestScreen> createState() => _ReviewRestScreenState();
}

class _ReviewRestScreenState extends State<ReviewRestScreen> {
  final RestReviewController _testimonialsController =
      Get.put(RestReviewController());
  late String _startDate = "", _endDate = "";
  DateRangePickerController _dateRangePickerController = DateRangePickerController();
  var startDateSearch, endDateSearch;

  @override
  void initState() {
    debugPrint("get data ======>totalReview  ${widget.totalReview},totalRating  ${widget.totalRating}, ");
    callApi("", "");
    super.initState();
  }

  callApi(String startDate, endDate){
    _testimonialsController.callRestaurantReviewListAPI(startDate, endDate);
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
        debugPrint('startDateSearch: $startDateSearch, endDateSearch: $endDateSearch');
        debugPrint('_startDate: $_startDate, _endDate: $_endDate');
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
                    showNavigationArrow: true,
                    showTodayButton: true,
                    controller: _dateRangePickerController,
                    onSubmit: (val){
                      debugPrint('Val: $val');
                      Navigator.pop(context);
                      if(startDateSearch != "" && endDateSearch != "") {
                        callApi(startDateSearch.toString(), endDateSearch.toString());
                      }
                    },
                    onCancel: (){
                      _dateRangePickerController.selectedRanges = null;
                      _startDate = "";
                      _endDate = "";
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
        appBar: WidgetAppbar.simpleAppBar(context, "Restaurant Reviews",true ),
        body: SafeArea(
          child: GetBuilder<GetXNetworkManager>(builder: (networkManager) {
            return networkManager.connectionType == 0
                ? Center(child: Text(check_internet))
                : GetBuilder<RestReviewController>(builder: (logic) {
                    return Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 70,
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
                                                _startDate == "" ? 'Choose Date Range' : _startDate + ' to ' + _endDate,
                                                _startDate == "" ? Color(GREY1) : Color(BLACK),
                                                14,
                                                maxline: 1
                                            ),
                                          )),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: GestureDetector(
                                        onTap: (){
                                          _dateRangePickerController.selectedRanges = null;
                                          _startDate = "";
                                          _endDate = "";
                                          callApi("", "");
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.only(right: 10.0,),
                                          child: SizedBox(
                                              height: 20.0,
                                              child: Align(
                                                alignment: Alignment.centerRight,
                                                child: Icon(
                                                  Icons.clear,
                                                ),
                                              )),
                                        ),
                                      ),
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
                        widget.totalRating == "" ? Container():
                        Container(
                          margin: EdgeInsets.fromLTRB(10, 20, 10, 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              WidgetText.widgetPoppinsMediumText(
                                  "Ratings & Reviews", Color(BLACK) , 18),
                              Row(
                                children: [
                                  WidgetText.widgetPoppinsMediumText(
                                      "${widget.totalRating}/5 (${widget.totalReview} reviews)", Color(BLACK) , 16),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  RatingStars(
                                    value: widget.totalRating,
                                    onValueChanged: (v) {},
                                    starBuilder: (index, color) =>
                                        Icon(
                                          Icons.star_rounded,
                                          color: color,
                                        ),
                                    maxValueVisibility: false,
                                    valueLabelVisibility: false,
                                    starCount: 5,
                                    starSpacing: 2,
                                    starSize: 20,
                                    starColor: Color(0xffFFD633),
                                    starOffColor: Color(0xffC1C1C1),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Expanded(child:
                        logic.isReviewVisible
                            ? Center(
                            child: CircularProgressIndicator(
                              color: Color(ORANGE),
                            ))
                            // : logic.reviewListModel.data?.length == 0 || logic.reviewListModel.data?.isEmpty == true?
                            : logic.reviewListModel.meta?.status == false || logic.reviewListModel.data?.isEmpty == true?
                        Center(
                          child: Container(
                            child: Text('Review List Not Found'),
                          ),
                        )
                            : ListView.builder(
                            shrinkWrap: true,
                            // physics: NeverScrollableScrollPhysics(),
                            itemCount: logic.reviewListModel.data?.length,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) {

                              logic.reviewListModel.data?.sort((a, b)=> b.updatedAt.toString().compareTo(a.updatedAt.toString()));

                              var reviewDate;
                              String parseTimeStampReport(int value) {
                                // value.compareTo(value);
                                var date =
                                DateTime.fromMicrosecondsSinceEpoch(
                                    value * 1000);
                                var d12 = formatterMonth.format(date);
                                reviewDate = d12;
                                return d12;
                              }

                              if (logic.reviewListModel.data?[index].updatedAt != null) {

                                reviewDate = parseTimeStampReport(int.parse(
                                    logic.reviewListModel.data?[index].updatedAt.toString() ?? ""));
                              }

                              return Padding(
                                padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    logic.reviewListModel.data?[index].restaurantName ==
                                        null
                                        ? Text('')
                                        : WidgetText
                                        .widgetPoppinsRegularText(
                                        logic
                                            .reviewListModel
                                            .data?[index]
                                            .userName
                                            .toString() ?? "",
                                        Color(BLACK),
                                        16),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    logic.reviewListModel.data?[index]
                                        .rating !=
                                        null
                                        ? RatingStars(
                                      value: double.parse(logic
                                          .reviewListModel
                                          .data![index]
                                          .rating
                                          .toString()),
                                      onValueChanged: (v) {},
                                      starBuilder: (index, color) =>
                                          Icon(
                                            Icons.star_rounded,
                                            color: color,
                                          ),
                                      maxValueVisibility: false,
                                      valueLabelVisibility: false,
                                      starCount: 5,
                                      starSpacing: 2,
                                      starSize: 20,
                                      starColor: Color(0xffFFD633),
                                      starOffColor: Color(0xffC1C1C1),
                                    )
                                        : Container(),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    logic.reviewListModel.data?[index]
                                        .review ==
                                        null
                                        ? Text('')
                                        : WidgetText
                                        .widgetPoppinsRegularText(
                                        logic.reviewListModel
                                            .data![index].review
                                            .toString(),
                                        Color(SUBTEXT),
                                        14),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    WidgetText.widgetPoppinsRegularText(
                                        reviewDate ?? "",
                                        // "14th Feb, 2022",
                                        Color(LIGHTGREYCOLORICON),
                                        12),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Divider(
                                        height: 1,
                                        thickness: 1,
                                        color: Color(DIVIDERCOLOR)),
                                  ],
                                ),
                              );
                            }))
                      ],
                    );



                  });
          }),
        ));
  }
}

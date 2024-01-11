import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:get/get.dart';
import '../../../core/utils/app_color_utils.dart';
import '../../../core/utils/app_constants.dart';
import '../../../core/utils/app_strings_constants.dart';
import '../../../core/utils/networkManager.dart';
import '../../../core/widgets/widget_card.dart';
import '../../../core/widgets/widget_text.dart';
import '../controller/testimonials_controller.dart';

class TestimonialScreen extends StatefulWidget {
  bool isHome;
  String? restId;
  TestimonialScreen({
    Key? key, required this.isHome, this.restId
  }) : super(key: key);

  @override
  State<TestimonialScreen> createState() => _TestimonialScreenState();
}

class _TestimonialScreenState extends State<TestimonialScreen> {
  final TestimonialsController _testimonialsController =
      Get.put(TestimonialsController());

  @override
  void initState() {
    if(widget.isHome) {
      _testimonialsController.callReviewListAPI(widget.restId);
    }else{
      _testimonialsController.callRestaurantReviewListAPI(widget.restId);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(WHITE),
        appBar: WidgetAppbar.simpleAppBar(context, reviews,true ),
        body: SafeArea(
          child: GetBuilder<GetXNetworkManager>(builder: (networkManager) {
            return networkManager.connectionType == 0
                ? Center(child: Text(check_internet))
                : GetBuilder<TestimonialsController>(builder: (logic) {
                    return logic.isReviewVisible
                        ? Center(
                            child: CircularProgressIndicator(
                            color: Color(ORANGE),
                          ))
                        : logic.reviewListModel.data?.length == 0
                            ? Container(
                                child: Text('Review List Not Found'),
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
                                                        .data![index]
                                                        .restaurantName
                                                        .toString(),
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
                                            reviewDate,
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
                                });
                  });
          }),
        ));
  }
}

import 'package:choosifoodi/core/utils/app_color_utils.dart';
import 'package:choosifoodi/core/widgets/widget_text.dart';
import 'package:choosifoodi/screens/profile/view/change_password_screen.dart';
import 'package:choosifoodi/screens/profile/view/edit_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../core/utils/app_images_utils.dart';
import '../../../core/utils/app_strings_constants.dart';
import '../../../core/utils/networkManager.dart';
import '../../../core/widgets/widget_card.dart';
import '../../address/view/address_screen.dart';
import '../Controller/profile_controller.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final UserProfileGetController userOTPVerifyController = Get.put(UserProfileGetController());
  // create an instance
  final GetXNetworkManager _networkManager = Get.put(GetXNetworkManager());

  var mobile = "";
  var email = "";
  var profile = "";
  var fName = "";
  var lName = "";

  @override
  void initState() {
    if (_networkManager.connectionType != 0) {
      print('Connection Type: ${_networkManager.connectionType}');
      getDatafromAPI();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(WHITE),
      appBar: WidgetAppbar.simpleAppBar(context, "My Profile", false ),
      body: GetBuilder<UserProfileGetController>(builder: (logic) {
        mobile = logic.mobileNumber;
        email = logic.email;
        profile = logic.profile;
        fName = logic.fName;
        lName = logic.lName;

        return
          GetBuilder<GetXNetworkManager>(builder: (networkManager) {
          return networkManager.connectionType == 0
              ? Center(child: Text(check_internet))
              : logic.isLoaderVisible
              ? SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      child: logic.profile != ""
                          ? CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(logic.profile),
                      )
                          : Image.asset(
                        ic_profile_place_holder,
                        height: 110,
                        width: 110,
                      ),
                    ),
                    Positioned(
                      child: InkWell(
                        onTap: onClickEditProfile,
                        child: Image.asset(
                          ic_edit,
                          height: 40,
                          width: 40,
                        ),
                      ),
                      bottom: 0,
                      right: 15,
                    )
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Divider(
                  color: Color(LIGHTDIVIDERCOLOR),
                  height: 2,
                  thickness: 2,
                ),
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: Container(
                    padding: EdgeInsets.all(25),
                    width: double.infinity,
                    child: ListView(
                      physics: BouncingScrollPhysics(),
                      children: [
                        _profileFieldWidget("Name", logic.fName + " " + logic.lName),
                        SizedBox(
                          height: 10,
                        ),
                        _profileFieldWidget("Mobile", "+1 ${logic.mobileNumber}"),
                        SizedBox(
                          height: 10,
                        ),
                        _profileFieldWidget("Email", logic.email),
                        SizedBox(
                          height: 10,
                        ),
                        _profileFieldWidget(
                            "Member since", logic.memberSince),
                        SizedBox(
                          height: 10,
                        ),
                        _profileFieldWidget(
                            "Total orders placed", logic.totalMenuOrder),
                        SizedBox(
                          height: 25,
                        ),
                        InkWell(
                          onTap: onClickChangePassword,
                          child: Container(
                            padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                            decoration: BoxDecoration(
                              color: Color(WHITE),
                              shape: BoxShape.rectangle,
                              border: Border.all(
                                  color: Color(ORANGE), width: 1),
                              borderRadius:
                              BorderRadius.all(Radius.circular(10)),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child:
                                  WidgetText.widgetPoppinsRegularText(
                                      change_password,
                                      Color(BLACK),
                                      14),
                                ),
                                Image.asset(
                                  ic_left_side_arrow,
                                  height: 15,
                                  color: Color(BLACK),
                                  width: 15,
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        InkWell(
                          onTap: onClickChangeAddress,
                          child: Container(
                            padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                            decoration: BoxDecoration(
                              color: Color(WHITE),
                              shape: BoxShape.rectangle,
                              border: Border.all(
                                  color: Color(ORANGE), width: 1),
                              borderRadius:
                              BorderRadius.all(Radius.circular(10)),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child:
                                  WidgetText.widgetPoppinsRegularText(
                                      changeAddress,
                                      Color(BLACK),
                                      14),
                                ),
                                Image.asset(
                                  ic_left_side_arrow,
                                  height: 15,
                                  color: Color(BLACK),
                                  width: 15,
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                    decoration: BoxDecoration(
                      color: Color(WHITE),
                    ),
                  ),
                ),
              ],
            ),
          )
              : Center(
            child: CircularProgressIndicator(
              color: Color(ORANGE),
            ),
          );
        });
      }),
    );
  }

  Widget _profileFieldWidget(String title, String value) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          WidgetText.widgetPoppinsRegularText(
            title,
            Color(0xff848383),
            14,
          ),
          SizedBox(
            height: 5,
          ),
          WidgetText.widgetPoppinsMediumText(
            value,
            Color(0xff3E4958),
            16,
          ),
          SizedBox(
            height: 10,
          ),
          Divider(height: 1, thickness: 1, color: Color(DIVIDERCOLOR)),
        ],
      ),
    );
  }

  onClickEditProfile() async{
    await Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) =>
            EditProfileScreen(mobile, email, profile, fName, lName )));
    setState((){
      getDatafromAPI();
    });
  }

  onClickChangePassword() {
    Get.to(()=> ChangePasswordScreen());
  }

  onClickChangeAddress() {
    Get.to(()=>  AddressScreen('', '', '', ''));
  }

  void getDatafromAPI() {
    setState(() {
      userOTPVerifyController.getUserProfile();
      print("API calling");
    });
  }
}

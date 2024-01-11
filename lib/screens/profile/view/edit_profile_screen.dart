import 'dart:convert';
import 'package:choosifoodi/core/utils/app_color_utils.dart';
import 'package:choosifoodi/core/utils/app_font_utils.dart';
import 'package:choosifoodi/core/utils/app_images_utils.dart';
import 'package:choosifoodi/core/widgets/widget_button.dart';
import 'package:choosifoodi/core/widgets/widget_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../core/http_utils/http_constants.dart';
import '../../../core/utils/app_constants.dart';
import '../../../core/utils/app_strings_constants.dart';
import '../../../core/utils/networkManager.dart';
import '../../../core/widgets/widget_card.dart';
import '../Controller/update_profile_controller.dart';

class EditProfileScreen extends StatefulWidget {
  var mobile = "";
  var email = "";
  var profile = "";
  var fName = "";
  var lName = "";

  EditProfileScreen(
    this.mobile,
    this.email,
    this.profile,
    this.fName,
    this.lName,
  );

  @override
  _EditProfileScreenState createState() =>
      _EditProfileScreenState(email: email, mobile: mobile, profile: profile, fName: fName, lName: lName);
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final EditUserProfileGetController userOTPVerifyController =
      Get.put(EditUserProfileGetController());
  final _networkController = Get.find<GetXNetworkManager>();
  TextEditingController emailController = new TextEditingController();
  TextEditingController mobileController = new TextEditingController();
  TextEditingController fNameController = new TextEditingController();
  TextEditingController lNameController = new TextEditingController();

  _EditProfileScreenState(
      {required this.email, required this.mobile, required this.profile, required this.fName, required this.lName});

  var mobile = "";
  var email = "";
  var profile = "";
  var fName = "";
  var lName = "";

  @override
  void initState() {
    userOTPVerifyController.isLoaderVisible = false;
    super.initState();
    fNameController.text = fName;
    lNameController.text = lName;
    mobileController.text = mobile;
    emailController.text = email;
  }

  onAttachFile() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0)), //this right here
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                InkWell(
                  onTap: () {
                    debugPrint('tap on gallery');
                    //choose photo from gallery
                    userOTPVerifyController.getFromGallery();
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Icon(Icons.image, size: 20, color: Color(ORANGE),),
                        SizedBox(
                          width: 10,
                        ),
                        WidgetText.widgetPoppinsRegularText(
                            chooseGallary, Color(BLACK3), 14,
                            align: TextAlign.center),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 2,
                ),
                Divider(
                  height: 0.5,
                  thickness: 0.5,
                  color:Color(DIVIDERCOLOR),
                ),
                SizedBox(
                  height: 2,
                ),
                InkWell(
                  onTap: () {
                    //choose photo from camera
                    userOTPVerifyController.getFromCamera();
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Icon(Icons.camera_alt, size: 20, color: Color(ORANGE),),
                        SizedBox(
                          width: 10,
                        ),
                        WidgetText.widgetPoppinsRegularText(
                            takePhoto, Color(BLACK3), 14,
                            align: TextAlign.center),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                      padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        border:
                        Border.all(width: 1, color: Color(GREY)),
                      ),
                      child: WidgetText.widgetPoppinsRegularText(
                          cancel, Color(BLACK3), 14,
                          align: TextAlign.center),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(WHITE),
        appBar: WidgetAppbar.simpleAppBar(context, "Edit Profile", false ),
        body: GetBuilder<EditUserProfileGetController>(
          builder: (logic) {
            bool emailValid =
                RegExp(r'\S+@\S+\.\S+').hasMatch(emailController.text);

            return appLoader(
                widget: SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        child: logic.loadImage == true
                            ? InkWell(
                                onTap: () async {
                                  // await logic.onAttechFile();
                                  onAttachFile();
                                },
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: Image.file(
                                    logic.imagefile,
                                    height: 110,
                                    width: 110,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                            )
                            : profile != ""
                                      ? InkWell(
                                  onTap: () async {
                                    // await logic.onAttechFile();
                                    onAttachFile();
                                  },
                                  child: CircleAvatar(
                                      radius: 50,
                                      backgroundImage: NetworkImage(profile),
                                    ),
                                )
                                : InkWell(
                                    onTap: () async {
                                      // await logic.onAttechFile();
                                      onAttachFile();
                                    },
                                    child: Image.asset(
                                      ic_profile_place_holder,
                                      height: 110,
                                      width: 110,
                                    ),
                                  ),
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
                              customTextInputField(fNameController, fName,
                                  "First Name", TextInputType.text),
                              SizedBox(
                                height: 15,
                              ),
                              customTextInputField(lNameController, lName,
                                  "Last Name", TextInputType.text),
                              SizedBox(
                                height: 15,
                              ),
                              customTextInputField(mobileController, mobile,
                                  "Mobile", TextInputType.phone, true, true),
                              SizedBox(
                                height: 15,
                              ),
                              customTextInputField(emailController, email,
                                  "Email", TextInputType.emailAddress),
                              SizedBox(
                                height: 25,
                              ),

                              WidgetButton.widgetDefaultButton("Save Changes",
                                  () async {
                                if (_networkController.connectionType != 0) {
                                  if (emailValid == true) {
                                    if (logic.loadImage == true) {
                                      Map<String, String> params =
                                          <String, String>{
                                        HttpConstants.PARAMS_FIRSTNAME: fNameController.text,
                                        HttpConstants.PARAMS_LASTNAME: lNameController.text,
                                        HttpConstants.PARAMS_EMAIL: email,
                                        HttpConstants.PARAMS_MOBILE: mobile,
                                      };
                                      await logic.updateProfileApi(
                                          imageKey1:
                                              HttpConstants.PARAMS_PROFILEPIC,
                                          params: params);
                                    } else {
                                      final params = jsonEncode({
                                        HttpConstants.PARAMS_FIRSTNAME: fNameController.text,
                                        HttpConstants.PARAMS_LASTNAME: lNameController.text,
                                        HttpConstants.PARAMS_EMAIL: emailController.text,
                                        HttpConstants.PARAMS_MOBILE: mobileController.text
                                      });
                                      await logic.updateProfileApi(
                                          imageKey1:
                                              HttpConstants.PARAMS_PROFILEPIC,
                                          params: params);
                                    }

                                    if (logic.userProfileModel.meta?.status == true) {
                                      print('isLoaderVisible if: ${logic.isLoaderVisible}');
                                      setState(() {
                                        // logic.isLoaderVisible = true;
                                        Navigator.of(context).pop(true);
                                      });
                                    }/* else {
                                      print(
                                          'isLoaderVisible else: ${logic.isLoaderVisible}');
                                      setState(() {
                                        logic.isLoaderVisible = true;
                                      });
                                    }*/
                                  } else {
                                    showToastMessage(
                                        plzEnterProperEmailMsg);
                                  }
                                } else {
                                  showToastMessage(check_internet);
                                }
                              }),
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
                ),
                isLoading: logic.isLoaderVisible);
          },
        ));
  }

/*
* */
  Widget customTextInputField(
    TextEditingController editingController,
    String hintText,
    String lableText,
    TextInputType? keyboardType, [
    bool isMobile = false,
    bool? isReadOnly = false,
  ]) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        WidgetText.widgetPoppinsMediumText(
          lableText,
          Color(0xff3E4958),
          16,
          align: TextAlign.end,
        ),
        Card(
          elevation: 5,
          color: Color(WHITE),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Color(WHITE),
              borderRadius: BorderRadius.circular(12.0),
            ),
            padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
            child: TextFormField(
              controller: editingController,
              textAlign: TextAlign.start,
              keyboardType: keyboardType,
              readOnly: isReadOnly ?? false,
              inputFormatters: isMobile
                  ? [
                      LengthLimitingTextInputFormatter(15),
                    ]
                  : [],
              decoration: InputDecoration(
                border: InputBorder.none,
                hintStyle: TextStyle(
                  color: Color(0xff8C8989),
                  fontSize: 16,
                  fontFamily: FontPoppins,
                  fontWeight: PoppinsRegular,
                ),
                hintText: hintText,
              ),
              onChanged: (value) {
                setState(() {});
              },
              style: TextStyle(
                color: Color(0xff3E4958),
                fontSize: 16,
                fontFamily: FontPoppins,
                fontWeight: PoppinsRegular,
              ),
            ),
          ),
        )
      ],
    );
  }
}

import 'dart:convert';
import 'package:choosifoodi/core/utils/app_color_utils.dart';
import 'package:choosifoodi/core/utils/app_constants.dart';
import 'package:choosifoodi/core/utils/app_font_utils.dart';
import 'package:choosifoodi/core/utils/app_images_utils.dart';
import 'package:choosifoodi/core/widgets/widget_button.dart';
import 'package:choosifoodi/core/widgets/widget_check_box.dart';
import 'package:choosifoodi/core/widgets/widget_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/http_utils/http_constants.dart';
import '../../../core/utils/app_preferences.dart';
import '../../../core/utils/app_strings_constants.dart';
import '../../../core/utils/networkManager.dart';
import '../../../core/widgets/widget_card.dart';
import '../../restaurant_details/view/restaurant_details_screen.dart';
import '../controller/add_group_controller.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import '../models/get_user_list_model.dart';
import '../models/invite_member_model.dart';

class AddGroupScreen extends StatefulWidget {
  dynamic groupName, groupId, restaurantId;
  bool isViewGroup;

  AddGroupScreen(
      {required this.groupName,
      required this.groupId,
      required this.restaurantId,
      required this.isViewGroup});

  @override
  _AddGroupScreenState createState() => _AddGroupScreenState();
}

class _AddGroupScreenState extends State<AddGroupScreen> {
  TextEditingController contactController = TextEditingController();
  final AddGroupController addGroupController = Get.put(AddGroupController());
  List<Contact>? contacts;
  bool getContactsBool = true;
  List contactList = [];
  List<InviteMemberModel> inviteMemberModelList = [];
  dynamic groupID, groupName;
  final _networkController = Get.find<GetXNetworkManager>();
  dynamic joinGroupName;

  @override
  void initState() {
    groupName = widget.groupName;
    debugPrint('Group name: $groupName');
    groupID = widget.groupId;
    debugPrint('Group ID: $groupID');
    if (_networkController.connectionType != 0) {
      debugPrint('Connection Type: ${_networkController.connectionType}');
      getContact();
    }
    joinGroupName =  "Join" + widget.groupName + "'s Group Order";
    // getGroupList();
    super.initState();
  }

  getContact() async {
    debugPrint('Contact: $contacts');
    if (await FlutterContacts.requestPermission()) {
      contacts = await FlutterContacts.getContacts(
        withProperties: true,
      );
      debugPrint(contacts.toString());
      for (int i = 0; i < contacts!.length; i++) {
        if (contacts![i].phones.isNotEmpty) {
          String phoneNumber = contacts![i].phones.first.number;
          // List<String> modifiedList = [];
          String modifiedNumber = phoneNumber.replaceAll(RegExp(r'[()\s-]'), '');
          // contactList.add(contacts?[i].phones.first.number);
          contactList.add(modifiedNumber);
        }
      }
      setState(() {
        if (contactList != [] || contactList.isNotEmpty) {
          getContactsBool = true;
          final params = jsonEncode({
            "mobileList": contactList,
          });
          addGroupController.callUserListApi(params: params);
        } else {
          showToastMessage('Contact Not Found');
        }
      });
    }
  }

  /* getGroupList() async {
    debugPrint('getGroupList:');
    await addGroupController.callGroupOrderListAPI();
    if(addGroupController.isGroupListVisible == true){
      setState(() {
        debugPrint('isGroupListVisible: ${addGroupController.isGroupListVisible}');
        for(int i=0; i< addGroupController.groupListModel.data!.length; i++){
          if(groupName == addGroupController.groupListModel.data?[i].groupName){
            debugPrint('groupName: ${addGroupController.groupListModel.data?[i].groupName}');
            groupID = addGroupController.groupListModel.data?[i].groupId;
            debugPrint('groupID: $groupID');
          }
        }
      });
    }
  }*/

  // This function is called whenever the text field changes
  void _runFilter(String enteredKeyword) {
    // List results = [];
    List<GetUserDataList>? results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = addGroupController.getUserListModel.data;
    } else {
      results = addGroupController.getUserListModel.data!
          .where((user) => user.firstName!
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
      if (results.length == 0) {
        showToastMessage('No data found');
        results.clear();
      } else {
        debugPrint('Results: ${results[0].firstName}');
      }
    }

    // Refresh the UI
    setState(() {
      addGroupController.foundUsersList = results!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(WHITE),
      appBar: WidgetAppbar.simpleAppBar(context, groupName.toString() + "'s Group Order",false ),
      body: SafeArea(
          child: GetBuilder<GetXNetworkManager>(builder: (networkManager) {
        return networkManager.connectionType == 0
            ? Center(child: Text(check_internet))
            : GetBuilder<AddGroupController>(builder: (logic) {
                return Container(
                  height: double.infinity,
                  child: Card(
                    margin: EdgeInsets.all(20),
                    color: Color(WHITE),
                    elevation: 5.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: logic.isUserGroupListVisible == true
                        ? Container(
                            decoration: BoxDecoration(
                              color: Color(WHITE),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Container(
                              padding: EdgeInsets.all(15),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  WidgetText.widgetPoppinsMediumOverflowText(
                                 "Join " + groupName + "'s Group Order",
                                    Color(BLACK),
                                    20,
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: WidgetText.widgetPoppinsRegularText(
                                      "Add group participants",
                                      Color(BLACK),
                                      16,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  customTextInputField(
                                      contactController,
                                      "Type contact name",
                                      "",
                                      TextInputType.text),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Flexible(
                                    child: ListView.builder(
                                      physics: BouncingScrollPhysics(),
                                      itemCount: logic.foundUsersList.length,
                                      itemBuilder: (context, index) {
                                        return Column(
                                          children: [
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                logic.foundUsersList[index]
                                                            .profilePic ==
                                                        null
                                                    ? Image.asset(
                                                        ic_no_image,
                                                        height: 44.0,
                                                        width: 44.0,
                                                        fit: BoxFit.fill,
                                                      )
                                                    : ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(22.0),
                                                        child: Image.network(
                                                          logic
                                                              .foundUsersList[
                                                                  index]
                                                              .profilePic
                                                              .toString(),
                                                          height: 44.0,
                                                          width: 44.0,
                                                          fit: BoxFit.fill,
                                                          errorBuilder:
                                                              (context, error,
                                                                  stackTrace) {
                                                            return Image.asset(
                                                              ic_no_image,
                                                              height: 44.0,
                                                              width: 44.0,
                                                              fit: BoxFit.fill,
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Flexible(
                                                  child: logic
                                                              .foundUsersList[
                                                                  index]
                                                              .firstName !=
                                                          null
                                                      ? WidgetText
                                                          .widgetPoppinsRegularText(
                                                          logic
                                                              .foundUsersList[
                                                                  index]
                                                              .firstName
                                                              .toString(),
                                                          Color(BLACK),
                                                          16,
                                                        )
                                                      : Text(''),
                                                  flex: 1,
                                                  fit: FlexFit.tight,
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    debugPrint('CheckBox');
                                                    debugPrint('number: ${logic
                                                        .foundUsersList[index].mobile}');

                                                    setState(() {
                                                      if (logic
                                                              .foundUsersList[
                                                                  index]
                                                              .isChecked ==
                                                          false) {
                                                        logic
                                                            .foundUsersList[index]
                                                            .setChecked = true;
                                                        inviteMemberModelList
                                                            .clear();
                                                        debugPrint('index: $index');
                                                      } else {
                                                        logic
                                                            .foundUsersList[
                                                                index]
                                                            .setChecked = false;
                                                        inviteMemberModelList
                                                            .clear();
                                                        debugPrint('index: $index');
                                                      }
                                                    });
                                                  },
                                                  child: WidgetCheckBox
                                                      .widgetCheckBox(
                                                          // index == 0 || index == 3
                                                          logic.foundUsersList[index]
                                                                      .isChecked ==
                                                                  true
                                                              ? true
                                                              : false),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Divider(
                                              height: 1,
                                              thickness: 1,
                                              color: Color(DIVIDERCOLOR),
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                    flex: 1,
                                    fit: FlexFit.tight,
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  logic.isGroupInvitedVisible
                                      ? Center(
                                          child: CircularProgressIndicator(
                                          color: Color(ORANGE),
                                        ))
                                      : Container(
                                          decoration: BoxDecoration(
                                            color: Color(WHITE),
                                          ),
                                          padding:
                                              EdgeInsets.fromLTRB(60, 0, 60, 0),
                                          child:
                                              WidgetButton.widgetDefaultButton(
                                                  "Invite", () async {
                                            for (int i = 0;
                                                i < logic.foundUsersList.length;
                                                i++) {
                                              if (logic.foundUsersList[i]
                                                      .isChecked ==
                                                  true) {
                                                debugPrint(
                                                    'index $i: ${logic.foundUsersList[i].isChecked}');
                                                inviteMemberModelList
                                                    .add(InviteMemberModel(
                                                  name: logic.foundUsersList[i]
                                                      .firstName
                                                      .toString(),
                                                  userId: logic
                                                      .foundUsersList[i].userId
                                                      .toString(),
                                                  mobile: logic
                                                      .foundUsersList[i].mobile
                                                      .toString(),
                                                ));
                                              }
                                              setState(() {

                                              });
                                              if (inviteMemberModelList.length > 0) {
                                                var restId;
                                                final params = jsonEncode({
                                                  HttpConstants.PARAMS_GROUPID:
                                                      groupID,
                                                  HttpConstants
                                                          .PARAMS_INVITED_MEMBER:
                                                      inviteMemberModelList
                                                          .map((player) =>
                                                              player.toMap())
                                                          .toList(),
                                                });
                                                debugPrint('Params: $params');
                                                await logic.callInviteUserApi(
                                                    params: params);
                                                if (logic
                                                        .isGroupInvitedVisible ==
                                                    false) {
                                                  if (logic.inviteGroupModel
                                                          .meta?.status ==
                                                      true) {
                                                    restId = logic
                                                        .inviteGroupModel
                                                        .data
                                                        ?.restaurantId
                                                        .toString();
                                                    debugPrint('RestId: $restId');

                                                    if(mounted) {
                                                      setState(() {
                                                        logic
                                                            .isGroupInvitedVisible =
                                                        false;
                                                      });
                                                    }
                                                    // Get.to(() => JoinGroupOrderScreen(groupID));
                                                    if (widget.isViewGroup ==
                                                        false) {
                                                      RestaurantDetailsScreen
                                                          .setIsGroupOrder(
                                                              true);
                                                      AppPreferences.setGroupId(
                                                          groupID);
                                                      Get.offAll(() =>
                                                          RestaurantDetailsScreen(
                                                            restaurantid:
                                                                restId,
                                                          ));
                                                    }else{
                                                      Get.back(result: true);
                                                    }
                                                  }
                                                }
                                              } else {
                                                showToastMessage('Please Add Participants in group');
                                              }
                                            }
                                            debugPrint(
                                                'Invitelist : ${jsonEncode(inviteMemberModelList.map((player) => player.toMap()).toList())}');
                                          }),
                                        ),
                                ],
                              ),
                            ),
                          )
                        : logic.getUserListModel.meta?.status == false
                            ? Center(
                                child: Container(
                                child: Text(contactNotFound),
                              ))
                            : Center(
                                child: CircularProgressIndicator(
                                color: Color(ORANGE),
                              )),
                  ),
                );
              });
      })),
    );
  }

  Widget customTextInputField(TextEditingController controller, String hintText,
      String lableText, TextInputType? keyboardType) {
    return Container(
      decoration: BoxDecoration(
        color: Color(WHITE),
        shape: BoxShape.rectangle,
        border: Border.all(color: Color(BLACK), width: 0.5),
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      padding: EdgeInsets.fromLTRB(15, 3, 15, 3),
      child: TextFormField(
        controller: controller,
        textAlign: TextAlign.start,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintStyle: TextStyle(
            color: Color(LIGHTERHINTCOLOR),
            fontSize: 16,
            fontFamily: FontPoppins,
            fontWeight: PoppinsRegular,
          ),
          hintText: hintText,
        ),
        onChanged: (val) {
          _runFilter(val);
        },
        style: TextStyle(
          color: Color(BLACK),
          fontSize: 16,
          fontFamily: FontPoppins,
          fontWeight: PoppinsRegular,
        ),
      ),
    );
  }
}

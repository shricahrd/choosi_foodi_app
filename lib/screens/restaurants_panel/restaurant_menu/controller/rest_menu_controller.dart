import 'dart:convert';
import 'package:choosifoodi/core/utils/app_constants.dart';
import 'package:choosifoodi/routes/general_path.dart';
import 'package:choosifoodi/screens/restaurants_panel/restaurant_menu/model/rest_menu_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../../../../core/http_utils/http_constants.dart';
import '../../../../core/http_utils/http_get_util.dart';
import '../../../../core/http_utils/http_post_util.dart';
import '../../../cart/model/delete_cart_model.dart';

class RestMenuController extends GetxController {
  bool isLoaderVisible = true;
  bool isStatusChanged = false;
  late RestMenuModel restMenuModel = RestMenuModel();
  String createdDate = "";
  DeleteCartModel deleteCartModel = DeleteCartModel();
  // At the beginning, we fetch the first 20 posts
  int page = 1;
  // you can change this value to fetch more or less posts per page (10, 15, 5, etc)
  final int limit = 20;

  // There is next page or not
  bool hasNextPage = true;

  // Used to display loading indicators when _firstLoad function is running
  bool isFirstLoadRunning = false;

  // Used to display loading indicators when _loadMore function is running
  bool isLoadMoreRunning = false;

  // The controller for the ListView
  late ScrollController controller;

  List<RestMenuList> restMenuList = [];

  @override
  void onInit() {
    isLoaderVisible = true;
    super.onInit();
  }

  @override
  void dispose() {
    isLoaderVisible = true;
    super.dispose();
  }

  // This function will be called when the app launches (see the initState function)
  void firstLoad({required String status, required String search}) async {
    isFirstLoadRunning = true;
    update();
    try {
      getMenuList1Api(status: status, search: search);
      update();
    } catch (err) {
      if (kDebugMode) {
        debugPrint('Something went wrong');
      }
    }
    isFirstLoadRunning = false;
    update();
  }

  // This function will be triggered whenver the user scroll
  // to near the bottom of the list view
  void loadMore() async {
    if (hasNextPage == true &&
        isFirstLoadRunning == false &&
        isLoadMoreRunning == false &&
        controller.position.extentAfter < 300) {
      isLoadMoreRunning = true; // Display a progress indicator at the bottom
      update();
      page += 1; // Increase page by 1
      debugPrint('page: $page');
      try {
        debugPrint('Call Api');

        Map<String, String> queryParams = {
          HttpConstants.PARAMS_CONTENTPERPAGE: limit.toString(),
          HttpConstants.PARAMS_PAGE: page.toString(),
          HttpConstants.PARAMS_STATUS: "",
          HttpConstants.PARAMS_SEARCH: "",
        };

        getRequestWithRequest(GeneralPath.API_REST_MENU, queryParams).then((response) {
          if (response.statusCode == 200) {
            restMenuModel = RestMenuModel.fromJson(json.decode(response.body));
            if (restMenuModel.meta?.status == true) {
              debugPrint('status : ${restMenuModel.meta?.status}');
              debugPrint('Response menu Data: ${restMenuModel.data}');
              restMenuList = restMenuModel.data!;
              debugPrint('Response menu Data List: ${restMenuList.first.status}');
              if(restMenuList.isNotEmpty){
                restMenuList.addAll(restMenuList);
                debugPrint('Call Api: ${restMenuList.last}');
              }else{
                hasNextPage = false;
                update();
              }
              isLoaderVisible = false;
              update();
            }else{
              if (restMenuModel.meta!.msg != "") {
                isLoaderVisible = false;
                update();
              }
            }
          } else {
            if (restMenuModel.meta!.msg != "") {
              showToastMessage(restMenuModel.meta!.msg!);
              isLoaderVisible = true;
              update();
            }
          }
          update();
        });
      } catch (err) {
        if (kDebugMode) {
          debugPrint('Something went wrong!');
        }
      }
      isLoadMoreRunning = false;
      update();
    }
  }

  getMenuList1Api({required String status, required String search}) {

    Map<String, String> queryParams = {
      HttpConstants.PARAMS_CONTENTPERPAGE: limit.toString(),
      HttpConstants.PARAMS_PAGE: page.toString(),
      HttpConstants.PARAMS_STATUS: status,
      HttpConstants.PARAMS_SEARCH: search,
    };

    getRequestWithRequest(GeneralPath.API_REST_MENU, queryParams).then((response) {
      if (response.statusCode == 200) {
        restMenuModel = RestMenuModel.fromJson(json.decode(response.body));
        if (restMenuModel.meta?.status == true) {
          debugPrint('status : ${restMenuModel.meta?.status}');
          debugPrint('Response menu Data: ${restMenuModel.data}');
          restMenuList = restMenuModel.data!;
          debugPrint('Response menu Data List: ${restMenuList.first.status}');
          isLoaderVisible = false;
          update();
        }else{
          if (restMenuModel.meta!.msg != "") {
            isLoaderVisible = false;
            update();
          }
        }
      } else {
        if (restMenuModel.meta!.msg != "") {
          showToastMessage(restMenuModel.meta!.msg!);
          isLoaderVisible = true;
          update();
        }
      }
      update();
    });
  }

  Future<void>getMenuListApi({required String status, required String search}) async{

    dynamic selectedStatus;
    if(status == "Inactive"){
      selectedStatus = 'DEACTIVE';
    }else{
      selectedStatus = status;
    }

    Map<String, String> queryParams = {
      // HttpConstants.PARAMS_CONTENTPERPAGE: limit.toString(),
      // HttpConstants.PARAMS_PAGE: page.toString(),
      HttpConstants.PARAMS_STATUS: selectedStatus,
      HttpConstants.PARAMS_SEARCH: search,
    };

    await getRequestWithRequest(GeneralPath.API_REST_MENU, queryParams).then((response) {
      if (response.statusCode == 200) {
        restMenuModel = RestMenuModel.fromJson(json.decode(response.body));
        if (restMenuModel.meta?.status == true) {
          debugPrint('status : ${restMenuModel.meta?.status}');
          debugPrint('Response menu Data: ${restMenuModel.data}');
          isLoaderVisible = false;
          update();
        }else{
          if (restMenuModel.meta!.msg != "") {
            isLoaderVisible = false;
            update();
          }
        }
      } else {
        if (restMenuModel.meta!.msg != "") {
          showToastMessage(restMenuModel.meta!.msg!);
          isLoaderVisible = true;
          update();
        }
      }
      update();
      return restMenuModel;
    });
  }

  Future<void> callStatusUpdateAPI({required String menuId, required String status, }) async{
    // isStatusChanged = true;
    // update();
    final params = jsonEncode({
      HttpConstants.PARAMS_MENUID: menuId,
      HttpConstants.PARAMS_STATUS: status,
    });
    await putRequest(GeneralPath.API_REST_MENU_STATUS, params).then((response) {
      if (response.statusCode == 200) {
        debugPrint('Response Data: ${response.body}');
        Map<String, dynamic> mResponse = jsonDecode(response.body);
        deleteCartModel = DeleteCartModel.fromJson(mResponse);
        if (deleteCartModel.meta?.status == true) {
          debugPrint('status : ${deleteCartModel.meta?.status}');
          showToastMessage(deleteCartModel.meta?.msg.toString() ?? "");
          isStatusChanged = true;
          update();
          getMenuListApi(search: "", status: "");
          update();
        }else{
          showToastMessage(deleteCartModel.meta?.msg.toString() ?? "");
          isStatusChanged = false;
          update();
        }
      } else {
        showToastMessage(deleteCartModel.meta?.msg.toString() ?? "");
        isStatusChanged = false;
        update();
        throw Exception('Failed to load data.');
      }
      update();
    });
  }
}

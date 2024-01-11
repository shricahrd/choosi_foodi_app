import 'dart:convert';

import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../../core/http_utils/http_constants.dart';
import '../../../core/http_utils/http_get_util.dart';
import '../../../core/utils/app_constants.dart';
import '../../../core/utils/app_strings_constants.dart';
import '../../../routes/general_path.dart';
import '../model/global_search_model.dart.dart';
import '../model/search_result_model.dart';

class GlobalSearchController extends GetxController {
  bool isLoaderVisible = false;
  GlobalSearchModel globalSearchModel = GlobalSearchModel();
  late List<SearchResult> searchResult;

  @override
  void onInit() {
    super.onInit();
    searchResult = <SearchResult>[];
  }

  callSearchAPI(
      {required String lat, required String long, required String search}) {
    isLoaderVisible = !isLoaderVisible;
    update();
    Map<String, String> queryParams = {
      HttpConstants.PARAMS_LAT: lat,
      HttpConstants.PARAMS_LONG: long,
      HttpConstants.PARAMS_SEARCH: search,
    };

    getRequestWithRequest(GeneralPath.API_SEARCH, queryParams).then((response) {
      if (response.statusCode == 200) {
        Map<String, dynamic> mResponse = jsonDecode(response.body);
        globalSearchModel = GlobalSearchModel.fromJson(mResponse);
        if (globalSearchModel.meta?.status == true) {
          var menulenth = globalSearchModel.data?.menuList?.length;
          searchResult.clear();
          var newLentgh = menulenth == null ? menulenth = 0 : menulenth;
          for (var i = 0; i < newLentgh; i++) {
            searchResult.add(new SearchResult(
                id: globalSearchModel.data!.menuList![i].restaurantId,
                name: globalSearchModel.data!.menuList![i].dishName,
                refranceName: dish_name));
          }

          menulenth = globalSearchModel.data?.restaurantList?.length;

          newLentgh = menulenth == null ? menulenth = 0 : menulenth;
          for (var i = 0; i < newLentgh; i++) {
            searchResult.add(new SearchResult(
                id: globalSearchModel.data!.restaurantList![i].restaurantId,
                name: globalSearchModel.data!.restaurantList![i].restaurantName,
                refranceName: rest_name));
          }
        }
        isLoaderVisible = !isLoaderVisible;
        update();
      } else {
        showToastMessage(globalSearchModel.meta!.msg.toString());
        isLoaderVisible = false;
        update();
        throw Exception('Failed to load data.');
      }
      update();
    });
  }
}
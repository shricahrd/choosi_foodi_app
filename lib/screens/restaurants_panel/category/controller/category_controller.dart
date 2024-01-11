
import 'dart:convert';
import 'package:get/get.dart';
import '../../../../core/http_utils/http_constants.dart';
import '../../../../core/http_utils/http_get_util.dart';
import '../../../../core/http_utils/http_post_util.dart';
import '../../../../core/utils/app_constants.dart';
import '../../../../routes/general_path.dart';
import '../model/category_details_model.dart';
import '../model/category_list_model.dart';
import '../model/category_status_model.dart';

class CategoryController extends GetxController{
  CategoryListModel categoryListModel = CategoryListModel();
  CategoryStatusModel categoryStatusModel = CategoryStatusModel();
  CategoryDetailsModel categoryDetailsModel = CategoryDetailsModel();
  bool isLoaderVisible = true;
  bool isDetailsLoaderVisible = false;
  dynamic createdDate;

  String parseTimeCreated(int value) {
    var date = DateTime.fromMicrosecondsSinceEpoch(value * 1000);
    var d12 = formatterMonth.format(date);
    createdDate = d12;
    print('createdDate: $createdDate');
    return d12;
  }

  Future<void>getCategoryListApi({required String status, required String search}) async{

    dynamic selectedStatus;
    if(status == "Inactive"){
      selectedStatus = 'DEACTIVE';
    }else{
      selectedStatus = status;
    }

    Map<String, String> queryParams = {
      HttpConstants.PARAMS_STATUS: selectedStatus,
      HttpConstants.PARAMS_SEARCH: search,
    };

    await getRequestWithRequest(GeneralPath.API_REST_CATEGORY_LIST, queryParams).then((response) {
      if (response.statusCode == 200) {
        categoryListModel = CategoryListModel.fromJson(json.decode(response.body));
        if (categoryListModel.meta?.status == true) {
          print('status : ${categoryListModel.meta?.status}');
          print('Response menu Data: ${categoryListModel.data}');
        }
      } else {
        if (categoryListModel.meta?.msg != "") {
          showToastMessage(categoryListModel.meta?.msg ?? "");
        }
      }
      isLoaderVisible = false;
      update();
      update();
      return categoryListModel;
    });
  }

  /*Future<void> updateCategoryApi({required String categoryId, required String status,}) async {
      final params = jsonEncode({
        HttpConstants.PARAMS_CATEGORYID1: categoryId,
        HttpConstants.PARAMS_STATUS: status,
      });
    await putRequest(GeneralPath.API_REST_CATEGORY_STATUS, params).then((response)  {
      if (response.statusCode == 200) {
        print('Response Data: ${response.body}');
        Map<String, dynamic> mResponse =  jsonDecode(response.body);
        categoryStatusModel = CategoryStatusModel.fromJson(mResponse);
        if (categoryStatusModel.meta?.status == true) {
          print('status : ${categoryStatusModel.meta?.status}');
          showToastMessage(categoryStatusModel.meta?.msg.toString() ?? "");
        }else{
          showToastMessage(categoryStatusModel.meta?.msg.toString() ?? "");
        }
      } else {
        showToastMessage(categoryStatusModel.meta?.msg.toString() ?? "");
        throw Exception('Failed to load data.');
      }
      update();
      // return isMenuUpdateed;
      return categoryStatusModel;
    });
  }*/

  // API_REST_CATEGORY_DETAILS
  // CategoryDetailsModel
  Future<void>callGetCategoryDetailsAPI(String categoryId) async {

    await getRequest(GeneralPath.API_REST_CATEGORY_DETAILS + categoryId).then((response) {
      if (response.statusCode == 200) {
        Map<String, dynamic> mResponse = jsonDecode(response.body);
         categoryDetailsModel = CategoryDetailsModel.fromJson(mResponse);
        if (categoryDetailsModel.meta?.status == true) {
          print('status true: ${categoryDetailsModel.meta?.status}');
          print('Response Data: ${categoryDetailsModel.data}');
          if(categoryDetailsModel.data?.createdAt == 0){
            createdDate = "";
          }else {
            parseTimeCreated(int.parse(categoryDetailsModel.data?.createdAt.toString() ?? ""));
          }
        }
      } else {
        showToastMessage(categoryDetailsModel.meta!.msg.toString());
        throw Exception('Failed to load data.');
      }
      isDetailsLoaderVisible = !isDetailsLoaderVisible;
      update();
      return categoryDetailsModel;
    });
  }

}
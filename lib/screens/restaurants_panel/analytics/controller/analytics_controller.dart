import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';
import '../../../../core/http_utils/http_get_util.dart';
import '../../../../core/utils/app_constants.dart';
import '../../../../routes/general_path.dart';
import '../model/analytics_model.dart';

class AnalyticsRestController extends GetxController{
  AnalyticsModel analyticsModel = AnalyticsModel();
  bool isLoaderVisible = false;
  int fileID = 1;

  callApi(String searchKey) {
    isLoaderVisible= !isLoaderVisible;
    update();

    getRequest(GeneralPath.API_REST_ANALYTICS + "?searchKey=$searchKey").then((response) {

      if (response.statusCode == 200) {
        Map<String, dynamic> mResponse = jsonDecode(response.body);

        analyticsModel = AnalyticsModel.fromJson(mResponse);
        if (analyticsModel.meta?.status == true) {
          debugPrint('status true: ${analyticsModel.meta?.status}');
          debugPrint('Response Data: ${analyticsModel.data}');
        }else{
          // showToastMessage(analyticsModel.meta?.msg ?? "");
        }
        update();
      } else {
        showToastMessage(analyticsModel.meta?.msg ?? "");
        throw Exception('Failed to load data.');
      }
      isLoaderVisible = false;
      update();
    });
  }

  Future<void> createExcel() async{
    fileID++;
    update();
    print('fileID: $fileID');
    final Workbook workbook = Workbook();
    final Worksheet sheet1 = workbook.worksheets[0];

    for(int i=1; i<= 7; i++){
      sheet1.getRangeByIndex(1, i).columnWidth = 19.86;
    }

    sheet1.getRangeByName('A1:L1').cellStyle.backColor = '#D9E1F2';
    sheet1.getRangeByName('A1:L1').cellStyle.hAlign = HAlignType.left;
    sheet1.getRangeByName('A1:L1').cellStyle.vAlign = VAlignType.center;
    sheet1.getRangeByName('A1:L1').cellStyle.bold = true;
    sheet1.getRangeByName('A1:L1').cellStyle.borders.all.lineStyle = LineStyle.thin;
    sheet1.getRangeByName('A1:L1').cellStyle.borders.all.color = '#BFBFBF';

    sheet1.getRangeByIndex(1, 1).text = 'Dish Image';
    sheet1.getRangeByIndex(1, 2).text = 'Dish Name';
    sheet1.getRangeByIndex(1, 3).text = 'Total Sales quantity';

    if(analyticsModel.data?.isNotEmpty == true) {
      for (int i = 0; i < analyticsModel.data!.length; i++) {

        String menuImage = "";
        if(analyticsModel.data?[i].menuImg.isEmpty == true){
          menuImage = "";
        }else {
          menuImage = analyticsModel.data?[i].menuImg.first ?? "";
        }

        sheet1.getRangeByIndex(i+2, 1).text = menuImage;
        sheet1.getRangeByIndex(i+2, 2).text = analyticsModel.data?[i].dishName ?? "";
        sheet1.getRangeByIndex(i+2, 3).text = analyticsModel.data?[i].totalSale.toString() ?? "";
      }
    }

    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();

    final String path = (await getApplicationSupportDirectory()).path;
    final String fileName = '$path/Analytics$fileID.xlsx';
    final File file = File(fileName);
    await file.writeAsBytes(bytes, flush: true);
    print('FileName: $fileName');
    await OpenFilex.open(fileName);
  }
}
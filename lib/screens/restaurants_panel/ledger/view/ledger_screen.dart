import 'package:choosifoodi/core/utils/app_color_utils.dart';
import 'package:choosifoodi/core/utils/app_images_utils.dart';
import 'package:choosifoodi/core/widgets/widget_card.dart';
import 'package:choosifoodi/core/widgets/widget_text.dart';
import 'package:choosifoodi/screens/restaurants_panel/ledger/controller/get_ledger_controller.dart';
import 'package:choosifoodi/screens/restaurants_panel/ledger/view/payment_history.dart';
import 'package:choosifoodi/screens/restaurants_panel/ledger/view/sale_history.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/utils/app_strings_constants.dart';
import '../../../../core/utils/networkManager.dart';
import 'group_order_sale_history.dart';

class LedgerScreen extends StatefulWidget {
  const LedgerScreen({Key? key}) : super(key: key);

  @override
  State<LedgerScreen> createState() => _LedgerScreenState();
}

class _LedgerScreenState extends State<LedgerScreen> {

  final GetLedgerController _getLedgerController = Get.put(GetLedgerController());
// create an instance
  final GetXNetworkManager _networkManager = Get.put(GetXNetworkManager());
  dynamic commission;
  @override
  void initState() {
    if(_networkManager.connectionType !=0) {
      print('Connection Type: ${_networkManager.connectionType}');
      _getLedgerController.callGetLedgerAPI();
      callApi();
    }
    super.initState();
  }

  callApi() async {
    await _getLedgerController.callGetCommissionApi();
    if(_getLedgerController.getCommissionModel.meta?.status == true) {
      commission = _getLedgerController.getCommissionModel.data?.commission;
      print('Commisssion: $commission');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(WHITE),
      appBar: WidgetAppbar.simpleAppBar(context, ledger, true),
      body: SafeArea(
        child:
          GetBuilder<GetXNetworkManager>(builder: (networkManager) {
            return networkManager.connectionType == 0
                ? Center(child: Text(check_internet))
                : GetBuilder<GetLedgerController>(builder: (logic){
                  return
                    logic.isLoaderVisible == false ?
                    Container(
                    margin: EdgeInsets.symmetric(horizontal: 5, vertical: 20),
                    child: ListView(
                      physics: BouncingScrollPhysics(),
                      children: [
                        WidgetCard.rectCard2(available_amount, "\$" + logic.getLedgerModel.data!.balanceAmount.toStringAsFixed(2), ic_money_bag),
                        SizedBox(
                          height: 10,
                        ),
                        WidgetCard.customTextInputField(total_sale, "\$" + logic.getLedgerModel.data!.totalAmountEarned.toStringAsFixed(2)),
                        WidgetCard.customTextInputField(commission_paid, "\$"+ logic.getLedgerModel.data!.totalCommission.toStringAsFixed(2)),
                        InkWell(
                          onTap: onClickPayment,
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                            decoration: BoxDecoration(
                              color: Color(ORANGE),
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.all(Radius.circular(7)),
                            ),
                            alignment: Alignment.center,
                            child: WidgetText.widgetPoppinsMediumText(
                              view_payment_history,
                              Color(WHITE),
                              16,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: onClickSale,
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                            decoration: BoxDecoration(
                              color: Color(WHITE),
                              shape: BoxShape.rectangle,
                              border: Border.all(color: Color(ORANGE), width: 1),
                              borderRadius: BorderRadius.all(Radius.circular(7)),
                            ),
                            alignment: Alignment.center,
                            child: WidgetText.widgetPoppinsMediumText(
                              view_sale_history,
                              Color(ORANGE),
                              16,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: (){
                            Get.to(()=> GOSaleHistoryScreen(commission: commission,));
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                            decoration: BoxDecoration(
                              color: Color(ORANGE),
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.all(Radius.circular(7)),
                            ),
                            alignment: Alignment.center,
                            child: WidgetText.widgetPoppinsMediumText(
                              view_go_sale_history,
                              Color(WHITE),
                              16,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
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
          })
      ),
    );
  }

  onClickPayment() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => PaymentHistoryScreen()));
  }

  onClickSale() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => SaleHistoryScreen(commission: commission,)));
  }
}

/*        Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 8,
                            child: Card(
                              elevation: 2,
                              color: Color(WHITE),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0)),
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(15, 0, 6, 0),
                                child: InkWell(
                                  onTap: getDateRangePicker,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 5,
                                        child: Container(
                                            color: Colors.white,
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(
                                                  vertical: 15),
                                              child: WidgetText
                                                  .widgetPoppinsRegularOverflowText(
                                                _startDate == ""
                                                    ? choose_date_range
                                                    : _startDate +
                                                    ' ' +
                                                    to +
                                                    ' ' +
                                                    _endDate,
                                                _startDate == ""
                                                    ? Color(GREY2)
                                                    : Color(BLACK),
                                                13,
                                              ),
                                            )),
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                            right: 10.0,
                                          ),
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
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            flex: 2,
                            child: InkWell(
                              onTap: () {},
                              child: Container(
                                padding: EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Color(ORANGE),
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.all(Radius.circular(7)),
                                ),
                                alignment: Alignment.center,
                                child: WidgetText.widgetPoppinsMediumText(
                                  filter,
                                  Color(WHITE),
                                  13,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: WidgetButton.widgetDefaultButton(export_excel, () {}),
                    ),
                    SizedBox(
                      height: 10,
                    ),*/
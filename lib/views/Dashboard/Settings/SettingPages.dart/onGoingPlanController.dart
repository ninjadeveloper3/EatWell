// ignore_for_file: depend_on_referenced_packages

import 'package:eat_well/api-handler/api-extention.dart';
import 'package:eat_well/api-handler/api-repo.dart';
import 'package:eat_well/model/OngoingOrderDetailModel.dart';
import 'package:eat_well/widgets/toast.dart';
import 'package:get/get.dart';

class OngoingPlanController extends GetxController {
  ApiRepository apiRepository;
  OngoingPlanController(this.apiRepository);

  // var ongoingOrderDetail =
  //     List<OngoingOrderDetailModel>.empty(growable: true).obs;

  OngoingOrderDetailModel? ongoing;
  DateTime? startdate;
  DateTime? enddate;

  Future<bool> getOngoingPlanDetail({required int id}) async {
    bool isApiCompleted = false;
    await apiRepository
        .getMealHistoryData(id)
        .getResponse<Response<String>>((response) {
      if (response.data['code'].toString() == '200') {
        ongoing = OngoingOrderDetailModel.fromJson(response.data['data']);
        isApiCompleted = true;
        return isApiCompleted;
      } else {
        flutterToast('Something went wrong');
        return isApiCompleted;
      }
    });
    return isApiCompleted;
  }
}

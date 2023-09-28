import 'package:get/get.dart';

import '../../../components/arlert/saha_alert.dart';
import '../../../data/repository/repository_manager.dart';
import '../../../model/renter.dart';

class ChooseRenterController extends GetxController {
  var listRenterSelected = RxList<Renter>();
  var listRenter = RxList<Renter>();
  int currentPage = 1;
  bool isEnd = false;
  var loadInit = true.obs;
  var isLoading = false.obs;
  List<Renter>? listRenterInput;
  String? textSearch;

  var status = 0.obs;

  ChooseRenterController({this.listRenterInput}) {
    if (listRenterInput != null) {
      listRenterSelected(listRenterInput);
    }
    getAllRenter(isRefresh: true);
  }

  Future<void> getAllRenter({
    bool? isRefresh,
  }) async {
    if (isRefresh == true) {
      currentPage = 1;
      isEnd = false;
    }

    try {
      if (isEnd == false) {
        //isLoading.value = true;
        var data = await RepositoryManager.manageRepository.getAllRenter(
          search: textSearch,
          page: currentPage,
          //status: status.value
        );

        if (isRefresh == true) {
          listRenter(data!.data!.data!);
          listRenter.refresh();
        } else {
          listRenter.addAll(data!.data!.data!);
        }

        if (data.data!.nextPageUrl == null) {
          isEnd = true;
        } else {
          isEnd = false;
          currentPage = currentPage + 1;
        }
      }
      loadInit.value = false;
      isLoading.value = false;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }
}

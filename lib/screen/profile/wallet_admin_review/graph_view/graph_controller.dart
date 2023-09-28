
import 'package:get/get.dart';
import 'package:gohomy/components/arlert/saha_alert.dart';
import 'package:gohomy/data/repository/repository_manager.dart';
import 'package:gohomy/model/dashboard.dart';

class GraphController extends GetxController {

  GraphController({this.type, this.selectedYear}) {
    selectedYear = DateTime.now().year;
    getDataGraph();
  }
  String? type;
  int? selectedYear;
  var dataGraph = RxList<Graph>();
  void changeYear({required int newYear}) {
    selectedYear = newYear;
    getDataGraph();
  }

  Future<void> getDataGraph() async {
    try {
      var data = await RepositoryManager.adminManageRepository.getDataForGraph(type: type, year: selectedYear);
        if(data!.data!.isEmpty) {
          dataGraph.clear();
        }
        dataGraph.addAll(data?.data as Iterable<Graph>);
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }
}
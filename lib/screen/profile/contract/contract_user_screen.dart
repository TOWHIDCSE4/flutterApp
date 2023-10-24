import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:gohomy/components/loading/loading_full_screen.dart';
import 'package:gohomy/model/contract.dart';
import 'package:gohomy/screen/profile/contract/update_contract/contract_details_screen.dart';
import 'package:gohomy/utils/string_utils.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import '../../../components/text_field/saha_text_field_search.dart';
import '../../../utils/debounce.dart';
import 'contract_user_controller.dart';

class ContractUserScreen extends StatefulWidget {
  @override
  State<ContractUserScreen> createState() => _ContractUserScreenState();
}

class _ContractUserScreenState extends State<ContractUserScreen>
    with SingleTickerProviderStateMixin {
  ContractUserController contractUserController = ContractUserController();

  RefreshController refreshController = RefreshController();

  late TabController _tabController;
  late DateTime startDate;
  late DateTime endDate;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                colors: <Color>[Colors.deepOrange, Colors.orange]),
          ),
        ),
        title: const Text('Hợp đồng'),
        actions: [
          GestureDetector(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: SizedBox(
                        width: Get.width * 0.9,
                        height: Get.height * 0.5,
                        child: SfDateRangePicker(
                          onCancel: () {
                            Get.back();
                          },
                          onSubmit: (v) {
                            contractUserController.onOkChooseTime(
                                startDate, endDate);
                            contractUserController.getAllContractUser(
                                isRefresh: true);
                          },
                          showActionButtons: true,
                          onSelectionChanged: chooseRangeTime,
                          selectionMode: DateRangePickerSelectionMode.range,
                          initialSelectedRange: PickerDateRange(
                            contractUserController.fromDateOption,
                            contractUserController.toDateOption,
                          ),
                          maxDate: DateTime.now(),
                        ),
                      ),
                    );
                  });
            },
            child: Container(
              margin: const EdgeInsets.all(10),
              child: const Icon(
                FontAwesomeIcons.calendar,
              ),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 45,
            width: Get.width,
            child: ColoredBox(
              color: Colors.white,
              child: TabBar(
                controller: _tabController,
                onTap: (v) {
                  contractUserController.status.value = v == 0
                      ? 0
                      : v == 1
                          ? 2
                          : 1;
                  contractUserController.getAllContractUser(isRefresh: true);
                },
                tabs: [
                  Tab(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'Chờ xác nhận',
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Tab(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'Còn hiệu lực',
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Tab(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'Hết hiệu lực',
                          style: TextStyle(color: Colors.black54, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Divider(
            height: 1,
          ),
          SahaTextFieldSearch(
            hintText: "Tìm kiếm hợp đồng",
            onChanged: (v) {
              EasyDebounce.debounce(
                  'debounce_search_contract', const Duration(milliseconds: 300), () {
                contractUserController.textSearch = v;
                contractUserController.getAllContractUser(isRefresh: true);
              });
            },
            onClose: () {
              contractUserController.textSearch = "";
              contractUserController.getAllContractUser(isRefresh: true);
            },
          ),
          Expanded(
            child: Obx(
              () => contractUserController.loadInit.value
                  ? SahaLoadingFullScreen()
                  : contractUserController.listContract.isEmpty
                      ? const Center(
                          child: Text('Không có hợp đồng'),
                        )
                      : SmartRefresher(
                          enablePullDown: true,
                          enablePullUp: true,
                          header: const MaterialClassicHeader(),
                          footer: CustomFooter(
                            builder: (
                              BuildContext context,
                              LoadStatus? mode,
                            ) {
                              Widget body = Container();
                              if (mode == LoadStatus.idle) {
                                body = Obx(() =>
                                    contractUserController.isLoading.value
                                        ? const CupertinoActivityIndicator()
                                        : Container());
                              } else if (mode == LoadStatus.loading) {
                                body = const CupertinoActivityIndicator();
                              }
                              return SizedBox(
                                height: 100,
                                child: Center(child: body),
                              );
                            },
                          ),
                          controller: refreshController,
                          onRefresh: () async {
                            await contractUserController.getAllContractUser(
                                isRefresh: true);
                            refreshController.refreshCompleted();
                          },
                          onLoading: () async {
                            await contractUserController.getAllContractUser();
                            refreshController.loadComplete();
                          },
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: contractUserController.listContract
                                  .map((e) => itemContract(e))
                                  .toList(),
                            ),
                          ),
                        ),
            ),
          ),
        ],
      ),
    );
  }

  Widget itemContract(Contract contract) {
    return InkWell(
      onTap: () {
        Get.to(() => UpdateContractScreen(
                  id: contract.id,
                ))!
            .then((value) =>
                contractUserController.getAllContractUser(isRefresh: true));
      },
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Container(
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Đại diện thuê:",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      " ${(contract.listRenter ?? []).where((e) => e.isRepresent == true).toList().isEmpty ? "" : (contract.listRenter ?? []).where((e) => e.isRepresent == true).toList()[0].name ?? ""}",
                    )
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Tiền hợp đồng:",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "${SahaStringUtils().convertToMoney(contract.money ?? 0)} VNĐ",
                      style: const TextStyle(
                        color: Colors.red,
                      ),
                    )
                  ],
                ),
                const Divider(),
                if (contract.motelRoom?.towerId != null)
                  Container(
                     margin: const EdgeInsets.only(
                    top: 5,
                    bottom: 5,
                  ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Toà nhà:",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Container(
                              width: Get.width / 2,
                              alignment: Alignment.centerRight,
                              child: Text(
                                contract.motelRoom?.towerName ?? "",
                                style: const TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          
                          ],
                        ),
                      
                      ],
                    ),
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Nhà trọ:",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Container(
                      width: Get.width / 2,
                      alignment: Alignment.centerRight,
                      child: Text(
                        contract.motelRoom?.motelName ?? "",
                        style: const TextStyle(
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(
                    top: 5,
                    bottom: 5,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Số điện thoại chủ trọ:",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        contract.motelRoom?.phoneNumber ?? "",
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    top: 5,
                    bottom: 5,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            FontAwesomeIcons.peopleRoof,
                            color: Color(0xFF00B894),
                            size: 18,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            "${contract.motelRoom?.capacity ?? ""}",
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            contract.motelRoom?.sex == 0
                                ? FontAwesomeIcons.marsAndVenus
                                : contract.motelRoom?.sex == 1
                                    ? FontAwesomeIcons.mars
                                    : FontAwesomeIcons.venus,
                            color: contract.motelRoom?.sex == 0
                                ? const Color(0xFFBDC3C7)
                                : contract.motelRoom?.sex == 1
                                    ? const Color(0xFF2980B9)
                                    : const Color(0xFFE84393),
                            size: 15,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            contract.motelRoom?.sex == 0
                                ? "Nam, Nữ"
                                : contract.motelRoom?.sex == 1
                                    ? "Nam"
                                    : "Nữ",
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(
                            FontAwesomeIcons.house,
                            color: Color(0xFFFDCB6E),
                            size: 15,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text("${contract.motelRoom?.area ?? ""}m²"),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (contract.status == 3)
            Positioned(
              top: 20,
              child: Container(
                width: Get.width / 3,
                height: 30,
                decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(12)),
                transform: Matrix4.rotationZ(0.2),
                child: const Center(
                  child: Text(
                    'Đã chuyển tiền cọc',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }

  void chooseRangeTime(DateRangePickerSelectionChangedArgs args) {
    if (args.value is PickerDateRange) {
      startDate = args.value.startDate;
      endDate = args.value.endDate ?? args.value.startDate;
    }
  }
}

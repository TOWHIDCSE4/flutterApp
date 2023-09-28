import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'package:gohomy/components/appbar/saha_appbar.dart';
import 'package:gohomy/components/arlert/saha_alert.dart';
import 'package:gohomy/components/loading/loading_full_screen.dart';
import 'package:gohomy/components/text_field/saha_text_field_search.dart';
import 'package:gohomy/screen/profile/bill/choose_tower/choose_tower_screen.dart';
import 'package:gohomy/utils/debounce.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../components/button/saha_button.dart';
import '../../../../model/contract.dart';
import '../../../../utils/string_utils.dart';
import '../../../owner/contract/add_contract/add_contract_screen.dart';
import 'choose_contract_controller.dart';

class ChooseContractScreen extends StatelessWidget {
  ChooseContractScreen(
      {super.key, required this.onChoose, this.contractSelected}) {
    controller = ChooseContractController(contractInput: contractSelected);
  }
  late ChooseContractController controller;
  RefreshController refreshController = RefreshController();
  Contract? contractSelected;
  Function onChoose;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SahaAppBar(
        titleText: "Chọn hợp đồng",
        actions: [
          IconButton(onPressed: () {
            Get.to(() => TowerFilterScreen(onChoose: (tower) {
              controller.towerChoose = tower;
              controller.getAllContract(isRefresh: true);
              Get.back();
            }));
          }, icon: const Icon(Icons.filter_alt))
        ],
      ),
      body: Column(
        children: [
          SahaTextFieldSearch(
            hintText: "Tìm kiếm theo phòng",
            onChanged: (va) {
              EasyDebounce.debounce(
                  'list_contract', const Duration(milliseconds: 300), () {
                controller.textSearch = va;
                controller.getAllContract(isRefresh: true);
              });
            },
            onClose: () {
              controller.textSearch = "";
              controller.getAllContract(isRefresh: true);
            },
          ),
          Obx(
            () => Expanded(
              child: controller.loadInit.value
                  ? SahaLoadingFullScreen()
                  : controller.listContract.isEmpty
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
                                body = Obx(() => controller.isLoading.value
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
                            await controller.getAllContract(isRefresh: true);
                            refreshController.refreshCompleted();
                          },
                          onLoading: () async {
                            await controller.getAllContract();
                            refreshController.loadComplete();
                          },
                          child: SingleChildScrollView(
                            keyboardDismissBehavior:
                                ScrollViewKeyboardDismissBehavior.onDrag,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: controller.listContract
                                  .map((e) => itemContract(e))
                                  .toList(),
                            ),
                          ),
                        ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: SizedBox(
        height: 65,
        child: Column(
          children: [
            SahaButtonFullParent(
              color: Theme.of(context).primaryColor,
              text: "Xác nhận",
              onPressed: () {
                if (controller.contractChoose.value.id == null) {
                  SahaAlert.showError(message: "Bạn chưa chọn hợp đồng nào");
                  return;
                }
                onChoose(controller.contractChoose.value);
                Get.back();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget itemContract(Contract contract) {
    return InkWell(
      onTap: () {
        Get.to(() => AddContractScreen(
                  contractId: contract.id,
                  ignoring: contract.status == 1 ? true : false,
                  isUser: false,
                ))!
            .then((value) => {controller.getAllContract(isRefresh: true)});
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
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      height: 20,
                      width: 20,
                      child: Checkbox(
                          value:
                              controller.contractChoose.value.id == contract.id,
                          onChanged: (v) {
                            if (v == true) {
                              controller.contractChoose.value = contract;
                            }
                          }),
                    )
                  ],
                ),
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
                      "Số điện thoại: ",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      " ${(contract.listRenter ?? []).where((e) => e.isRepresent == true).toList().isEmpty ? "" : (contract.listRenter ?? []).where((e) => e.isRepresent == true).toList()[0].phoneNumber ?? ""}",
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
                      "Số/tên phòng:",
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
                        "Số điện thoại chủ nhà:",
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
                width: Get.width / 4,
                height: 30,
                decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(12)),
                transform: Matrix4.rotationZ(0.2),
                child: const Center(
                  child: Text(
                    'Đã đặt coc',
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
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:gohomy/components/loading/loading_full_screen.dart';
import 'package:intl/intl.dart';

import '../../../components/appbar/saha_appbar.dart';
import '../../../components/button/saha_button.dart';
import '../../../components/empty/saha_empty_avatar.dart';
import '../../../components/loading/loading_container.dart';
import '../../../components/text_field/saha_text_field_search.dart';
import '../../../model/renter.dart';
import '../../../utils/debounce.dart';
import '../../admin/potential_user/add_renter/add_renter_screen.dart';
import '../renters/add_update_tenants/add_update_tenant_screen.dart';
import '../renters/renter_details/renter_detail_screen.dart';
import 'choose_renters_controller.dart';

class ChooseRenterScreen extends StatelessWidget {
  List<Renter>? listRenterInput;
  bool? only;
  Function onChoose;
  ChooseRenterScreen(
      {this.listRenterInput, required this.onChoose, this.only}) {
    chooseRenterController =
        ChooseRenterController(listRenterInput: listRenterInput);
  }

  late ChooseRenterController chooseRenterController;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: SahaAppBar(
          titleText: 'Chọn người thuê',
          actions: [
            GestureDetector(
              onTap: () {
                Get.to(() => AddRenterPotentialScreen())!.then((value) =>
                    chooseRenterController.getAllRenter(isRefresh: true));
              },
              child: Container(
                margin: const EdgeInsets.all(10),
                child: const Icon(
                  FontAwesomeIcons.plus,
                ),
              ),
            )
          ],
        ),
        bottomNavigationBar: SizedBox(
          height: 65,
          child: Column(
            children: [
              SahaButtonFullParent(
                text: "Xác nhận",
                onPressed: () {
                  if (chooseRenterController.listRenterSelected.isNotEmpty) {
                    if (only == true) {
                      for (int i = 0;
                          i < chooseRenterController.listRenterSelected.length;
                          i++) {
                        var index = chooseRenterController.listRenter
                            .indexWhere(((e) =>
                                e.id ==
                                chooseRenterController
                                    .listRenterSelected[i].id));

                        if (index != -1) {
                          chooseRenterController.listRenterSelected[i] =
                              chooseRenterController.listRenter[index];
                          chooseRenterController
                              .listRenterSelected[i].isRepresent = true;
                          print(chooseRenterController
                              .listRenterSelected[i].name);
                          print(chooseRenterController
                              .listRenterSelected[i].isRepresent);
                        } else {
                          chooseRenterController
                              .listRenterSelected[i].isRepresent = false;
                        }
                      }
                      print(chooseRenterController.listRenterSelected
                          .map((e) => e.name));
                    }

                    onChoose(chooseRenterController.listRenterSelected);
                  }
                  Get.back();
                },
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            SahaTextFieldSearch(
              hintText: "Tìm kiếm người thuê",
              onChanged: (va) {
                EasyDebounce.debounce(
                    'list_users', const Duration(milliseconds: 300), () {
                  chooseRenterController.textSearch = va;
                  chooseRenterController.getAllRenter(isRefresh: true);
                });
              },
              onClose: () {
                chooseRenterController.textSearch = "";
                chooseRenterController.getAllRenter(isRefresh: true);
              },
            ),
            Expanded(
              child: Obx(
                () => chooseRenterController.loadInit.value
                    ? SahaLoadingFullScreen()
                    : SingleChildScrollView(
                        child: Column(
                          children: chooseRenterController.listRenter
                              .map((e) => itemRenter(e))
                              .toList(),
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget itemRenter(Renter renter) {
    return InkWell(
      onTap: () {
        Get.to(() => RenterDetailScreen(
                  renterId: renter.id!,
                ))!
            .then((value) =>
                chooseRenterController.getAllRenter(isRefresh: true));
      },
      child: Stack(
        alignment: Alignment.centerRight,
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
                child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  ClipOval(
                    child: Image.network(
                      renter.avatarImage ?? '',
                      fit: BoxFit.cover,
                      width: 40,
                      height: 40,
                      errorBuilder: (context, error, stackTrace) {
                        return const SahaEmptyAvata(
                          height: 40,
                          width: 40,
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          renter.name ?? 'Chưa có thông tin',
                          style: TextStyle(
                              color: Theme.of(Get.context!).primaryColor,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          renter.phoneNumber ?? 'Chưa có thông tin',
                          style: const TextStyle(),
                        ),
                        Text("Só/tên phòng: ${renter.motelName ?? ''}"),
                        Text('Tên toà nhà: ${renter.nameTowerExpected ?? ''}'),
                        if(renter.hasContract == false)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Ngày thuê dự kiến: ${DateFormat("dd-MM-yyyy").format(renter.estimateRentalDate ?? DateTime.now())}"),
                            Text("Thời hạn thuê dự kiến: ${renter.estimateRentalPeriod ?? ''} tháng"),
                          ],
                        ),
                        
                      
                        
                      ],
                    ),
                  )
                ]),
              ),

                Checkbox(
                    side: BorderSide(
                      color: Theme.of(Get.context!).primaryColor,
                      width: 1,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                value: chooseRenterController.listRenterSelected
                    .map((e) => e.id)
                    .toList()
                    .contains(renter.id),
                onChanged: (v) {
                  if (only == true) {
                    chooseRenterController.listRenterSelected([renter]);
                  } else {
                    if (chooseRenterController.listRenterSelected
                        .map((e) => e.id)
                        .toList()
                        .contains(renter.id)) {
                      chooseRenterController.listRenterSelected
                          .removeWhere((e) => e.id == renter.id);
                    } else {
                      chooseRenterController.listRenterSelected.add(renter);
                    }
                  }
                })
        ],
      ),
    );
  }
}




import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gohomy/components/text_field/sahashopTextField.dart';
import 'package:intl/intl.dart';
import 'package:pattern_formatter/numeric_formatter.dart';

import '../../../../components/empty/saha_empty_avatar.dart';
import '../../../../components/text_field/rice_text_field.dart';
import '../../../../model/potential_user.dart';
import '../../../../model/tower.dart';
import '../../../../utils/string_utils.dart';
import '../../../owner/choose_room/choose_room_screen.dart';
import '../../../owner/motel_room/choose_tower/choose_tower_screen.dart';
import 'add_renter_controller.dart';

class AddRenterPotentialScreen extends StatelessWidget {
  AddRenterPotentialScreen(
      {super.key, this.userPotential, this.isFromDetailScreen,this.onSubmit}) {
    controller = AddRenterController(
        userPotential: userPotential, isFromDetailScreen: isFromDetailScreen);
  }

  PotentialUser? userPotential;
  late AddRenterController controller;
  bool? isFromDetailScreen;
  Function? onSubmit;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Thêm người thuê'),
        ),
        body: SingleChildScrollView(
          keyboardDismissBehavior:ScrollViewKeyboardDismissBehavior.onDrag,
          child: Column(
            children: [
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(100),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset:
                              const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100.0),
                      child: CachedNetworkImage(
                        height: 100,
                        width: 100,
                        fit: BoxFit.cover,
                        imageUrl: '',
                        // placeholder: (context, url) =>
                        //     SahaLoadingWidget(),
                        errorWidget: (context, url, error) =>
                            const SahaEmptyAvata(
                          height: 100,
                          width: 100,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              item(
                  icon: const Icon(
                    Icons.person_outline,
                    color: Colors.grey,
                  ),
                  child: RiceTextField(
                    controller: controller.name,
                    hintText: "Nhập tên người thuê",
                    onChanged: (v) {
                      controller.renterReq.value.name = v;
                    },
                  )),
              item(
                  icon: const Icon(
                    Icons.phone,
                    color: Colors.grey,
                  ),
                  child: RiceTextField(
                    controller: controller.phone,
                    hintText: "Nhập số điện thoại",
                    onChanged: (v) {
                      controller.renterReq.value.phoneNumber = v;
                    },
                  )),
              item(
                  icon: const Icon(
                    Icons.email_outlined,
                    color: Colors.grey,
                  ),
                  child: RiceTextField(
                    hintText: "Nhập email",
                    controller: controller.email,
                    onChanged: (v) {
                      controller.renterReq.value.email = v;
                    },
                  )),
              const SizedBox(
                height: 10,
              ),
              textField(
                child: InkWell(
                  onTap: () {
                    Get.to(() => ChooseTowerScreen(
                          towerChoose: controller.towerSelected,
                          onChoose: (Tower tower) {
                            controller.nameTower.text =
                                tower.towerName ?? "";
                            controller.towerSelected = tower;
                            controller.renterReq.value.nameTowerExpected =
                                tower.towerName;
                            controller.renterReq.value.towerId = tower.id;

                            ///// xoá data phòng đã chọn
                            controller.roomName.text = '';
                            controller.motelRoomSelected = null;
                            controller.renterReq.value.motelName = null;
                            controller.renterReq.value.motelId = null;
                          },
                        ));
                  },
                  child: RiceTextField(
                    enabled: false,
                    hintText: "Chọn toà nhà",
                    controller: controller.nameTower,
                  ),
                ),
                labelText: "Tên toà nhà",
              ),
              textField(
                child: InkWell(
                  onTap: () {
                    Get.to(() => ChooseRoomScreen(
                          hasContract: false,
                          listMotelInput: controller.motelRoomSelected == null
                              ? []
                              : [controller.motelRoomSelected!],
                          towerId: controller.towerSelected?.id,
                          isTower: controller.towerSelected?.id == null
                              ? false
                              : true,
                          tower: controller.towerSelected,
                          onChoose: (v) {
                            if (v.isNotEmpty) {
                              controller.roomName.text = v[0].motelName;
                              controller.motelRoomSelected = v[0];
                              controller.renterReq.value.motelName =
                                  v[0].motelName;
                                  controller.renterReq.value.motelId = v[0].id;
                            }
                          },
                        ));
                  },
                  child: RiceTextField(
                    enabled: false,
                    hintText: "Chọn số phòng",
                    controller: controller.roomName,
                  ),
                ),
                labelText: "Số/tên phòng",
              ),
              textField(
                child: RiceTextField(
                  hintText: "Tiền phòng dự kiến",
                  textInputType:
                      const TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [ThousandsFormatter()],
                  controller: controller.priceExpected,
                  onChanged: (v) {
                    controller.renterReq.value.priceExpected = double.tryParse(SahaStringUtils()
                                  .convertFormatText(v!));
                  },
                ),
                labelText: "Tiền phòng dự kiến",
              ),
              textField(
                child: Stack(
                  children: [
                    RiceTextField(
                      hintText: "Nhập thời hạn thuê dự kiến",
                      controller: controller.intendTimeHire,
                      textInputType: TextInputType.number,
                      onChanged: (v) {
                        controller.renterReq.value.estimateRentalPeriod = v;
                      },
                    ),
                    const Positioned(right: 5, top: 5, child: Text("(Tháng)"))
                  ],
                ),
                labelText: "Thời hạn thuê dự kiến",
              ),
              textField(
                child: Stack(
                  children: [
                    InkWell(
                      onTap: () async {
                        var date = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2022, 1, 1),
                            lastDate: DateTime(2050, 1, 1));
                        if (date != null) {
                          controller.intendDayHire.text =
                              DateFormat('dd-MM-yyyy').format(date);
                        }
                      },
                      child: RiceTextField(
                        enabled: false,
                        hintText: "Chọn ngày thuê dự kiến",
                        controller: controller.intendDayHire,
                      ),
                    ),
                    const Positioned(
                        right: 5,
                        top: 5,
                        child: Icon(
                          Icons.calendar_month,
                          color: Colors.grey,
                        ))
                  ],
                ),
                labelText: "Ngày thuê dự kiến",
              ),
            ],
          ),
        ),
        // floatingActionButton: Padding(
        //   padding: const EdgeInsets.only(right: 16),
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.end,
        //     children: [
        //       InkWell(
        //         onTap: () {
        //           controller.addRenter();
        //         },
        //         child: Container(
        //           padding: const EdgeInsets.all(8),
        //           margin: const EdgeInsets.all(8),
        //           decoration: BoxDecoration(
        //               color: Colors.green,
        //               borderRadius: BorderRadius.circular(8)),
        //           child: Row(
        //             children: const [
        //               Icon(
        //                 Icons.add,
        //                 color: Colors.white,
        //               ),
        //               SizedBox(
        //                 width: 4,
        //               ),
        //               Text(
        //                 'Thêm',
        //                 style: TextStyle(color: Colors.white),
        //               )
        //             ],
        //           ),
        //         ),
        //       )
        //     ],
        //   ),
        // ),
        bottomNavigationBar: SizedBox(
          height: 65,
          child: Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {
                    if(onSubmit !=null){
                      onSubmit!(controller.renterReq.value);
                      Get.back();
                    }else{
                      controller.addRenter();
                    }
                    
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(8)),
                    child: Row(
                      children: const [
                        Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          'Thêm',
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget item({required Widget icon, required Widget child, TextStyle? style}) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(top: 10, bottom: 5, left: 10, right: 10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ]),
      child: Row(
        children: [
          icon,
          SizedBox(
            width: 8,
          ),
          Expanded(child: child),
        ],
      ),
    );
  }

  Widget textField({required Widget child, required String labelText}) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            labelText,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          child,
          const Divider()
        ],
      ),
    );
  }
}

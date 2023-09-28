import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gohomy/components/dialog/dialog.dart';
import 'package:gohomy/components/text_field/text_field_no_border.dart';
import 'package:pattern_formatter/pattern_formatter.dart';
import '../../../../components/button/saha_button.dart';
import '../../../model/location_address.dart';
import '../../../utils/string_utils.dart';
import 'find_now_controller.dart';

class FindNowScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  FindNowController findNowController = FindNowController();
  List<String> listPrice = [
    '2,500,000',
    '3,000,000',
    '3,500,000',
    '4,000,000',
    '4,500,000'
  ];
  List<int> listCapacity = [2, 3, 4, 5];
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: const Text(
            "Tìm phòng nhanh",
          ),
          backgroundColor: const Color(0xFFEF4355),
        ),
        bottomNavigationBar: SizedBox(
          height: 65,
          child: Column(
            children: [
              SahaButtonFullParent(
                color: const Color(0xFFEF4355),
                text: 'Gửi thông tin',
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    findNowController.addFindFastMotel();
                  }
                },
              ),
            ],
          ),
        ),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      'Vui lòng để lại thông tin tìm phòng\ntư vấn viên sẽ liên hệ lại cho bạn sớm nhất có thể',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ),
                SahaTextFieldNoBorder(
                  withAsterisk: true,
                  controller: findNowController.nameEdit,
                  onChanged: (value) {
                    findNowController.findFast.value.name = value;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Không được để trống';
                    }
                    return null;
                  },
                  labelText: "Họ và tên",
                  hintText: "Nhập họ và tên",
                ),
                const Divider(),
                SahaTextFieldNoBorder(
                  controller: findNowController.phoneEdit,
                  textInputType: TextInputType.phone,
                  onChanged: (v) {
                    findNowController.findFast.value.phoneNumber = v;
                  },
                  validator: (value) {
                    if (value!.length != 10) {
                      return 'Số điện thoại không hợp lệ';
                    }
                    return null;
                  },
                  withAsterisk: true,
                  labelText: 'Số điện thoại',
                  hintText: "Nhập số điện thoại",
                ),
                const Divider(),
                InkWell(
                  onTap: () {
                    SahaDialogApp.showDialogAddressChoose(
                      accept: () {},
                      callback: (v) {
                        if (v.name == 'Tất cả') {
                          findNowController.locationProvince.value =
                              LocationAddress();
                          findNowController.locationDistrict.value =
                              LocationAddress();
                          findNowController.locationWard.value =
                              LocationAddress();
                          Get.back();
                        } else {
                          findNowController.locationProvince.value = v;
                          findNowController.locationDistrict.value =
                              LocationAddress();
                          findNowController.locationWard.value =
                              LocationAddress();

                          // findRoomLoginController.getAllRoomPost(
                          //   isRefresh: true,
                          // );
                          Get.back();
                          SahaDialogApp.showDialogAddressChoose(
                            accept: () {},
                            idProvince:
                                findNowController.locationProvince.value.id,
                            callback: (v) {
                              if (v.name == 'Tất cả') {
                                Get.back();
                              } else {
                                findNowController.locationDistrict.value = v;

                                Get.back();
                                SahaDialogApp.showDialogAddressChoose(
                                  accept: () {},
                                  idDistrict: findNowController
                                      .locationDistrict.value.id,
                                  callback: (v) {
                                    if (v.name == 'Tất cả') {
                                      Get.back();
                                    } else {
                                      findNowController.locationWard.value =
                                          v;
                                      Get.back();
                                    }
                                  },
                                );
                              }
                            },
                          );
                        }
                      },
                    );
                  },
                  child: Obx(() {
                    var province = findNowController.locationProvince;
                    var district = findNowController.locationDistrict;
                    var ward = findNowController.locationWard;
                    return SahaTextFieldNoBorder(
                      enabled: false,
                      labelText: "Địa chỉ nơi cần tìm",
                      textInputType: TextInputType.text,
                      controller: findNowController.addressEdit,
                      withAsterisk: false,
                      onChanged: (v) {
                        //addPostController.postReq.value.name = v;
                      },
                      hintText: province.value.id != null ||
                              district.value.id != null ||
                              ward.value.id != null
                          ? '${ward.value.name ?? ""}${ward.value.name != null ? ", " : ""}${district.value.name ?? ""}${district.value.name != null ? ", " : ""}${province.value.name ?? ""}'
                          : 'Chọn địa chỉ nơi cần tìm',
                      hintStyle: TextStyle(
                        color: province.value.id != null ||
                                district.value.id != null ||
                                ward.value.id != null
                            ? Colors.black87
                            : Colors.grey,
                      ),
                    );
                  }),
                ),
                const Divider(),
                SahaTextFieldNoBorder(
                  inputFormatters: [ThousandsFormatter()],
                  controller: findNowController.price,
                  textInputType: TextInputType.number,
                  onChanged: (v) {
                    findNowController.findFast.value.price =
                        double.parse(SahaStringUtils().convertFormatText(v));
                  },
                  labelText: 'Mức giá phòng cần tìm',
                  hintText: "Nhập mức giá",
                ),
                Wrap(
                  children: [...listPrice.map((e) => itemPrice(e))],
                ),
                const Divider(),
                SahaTextFieldNoBorder(
                  inputFormatters: [ThousandsFormatter()],
                  controller: findNowController.capacity,
                  textInputType: TextInputType.number,
                  onChanged: (v) {
                    findNowController.findFast.value.capacity =
                        int.parse(v ?? '');
                  },
                  labelText: 'Số lượng người ở',
                  hintText: "Nhập số lượng người ở",
                ),
                Center(
                  child: Wrap(
                    children: [...listCapacity.map((e) => itemCapacity(e))],
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                    margin: const EdgeInsets.all(10),
                    child: Image.asset(
                      'assets/icon_host/tien-nghi.png',
                      width: 120,
                    ),
              ),
              Container(
                  width: Get.width,
                  padding: const EdgeInsets.only(left: 15, top: 10, bottom: 10),
                  child: Obx(
                    () => Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      crossAxisAlignment: WrapCrossAlignment.start,
                      children: [
                        itemUtilities(
                            value: findNowController
                                    .findFast.value.hasWc ??
                                false,
                            tile: "Nhà vệ sinh",
                            onCheck: () {
                              findNowController
                                    .findFast.value
                                  .hasWc = !(findNowController
                                    .findFast.value.hasWc ??
                                  false);
                            }),
                        itemUtilities(
                            value: findNowController
                                    .findFast.value.hasMezzanine ??
                                false,
                            tile: "Gác xép",
                            onCheck: () {
                              findNowController
                                    .findFast.value
                                  .hasMezzanine = !(findNowController
                                    .findFast.value.hasMezzanine ??
                                  false);
                            }),
                        itemUtilities(
                            value: findNowController
                                    .findFast.value.hasBalcony ??
                                false,
                            tile: "Ban công",
                            onCheck: () {
                              findNowController
                                    .findFast.value
                                  .hasBalcony = !(findNowController
                                    .findFast.value.hasBalcony ??
                                  false);
                            }),
                        itemUtilities(
                            value: findNowController
                                    .findFast.value.hasFingerprint ??
                                false,
                            tile: "Ra vào vân tay",
                            onCheck: () {
                              findNowController
                                    .findFast.value
                                  .hasFingerprint = !(findNowController
                                    .findFast.value.hasFingerprint ??
                                  false);
                            }),
                        itemUtilities(
                            value: findNowController
                                    .findFast.value.hasOwnOwner ??
                                false,
                            tile: "Không chung chủ",
                            onCheck: () {
                              findNowController
                                    .findFast.value
                                  .hasOwnOwner = !(findNowController
                                    .findFast.value.hasOwnOwner ??
                                  false);
                            }),
                        itemUtilities(
                            value: findNowController
                                    .findFast.value.hasPet ??
                                false,
                            tile: "Nuôi Pet",
                            onCheck: () {
                             findNowController
                                    .findFast.value
                                  .hasPet = !(findNowController
                                    .findFast.value.hasPet ??
                                  false);
                            }),
                      ],
                    ),
                  ),
                ),
                  ],
                ),
                 Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Container(
                      padding: const EdgeInsets.all(10),
                      child: Image.asset(
                        'assets/icon_host/noi-that.png',
                        width: 120,
                      ),
                ),
                Container(
                  width: Get.width,
                  padding: const EdgeInsets.only(left: 15, top: 10, bottom: 10),
                  child: Obx(
                    () => Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      crossAxisAlignment: WrapCrossAlignment.start,
                      children: [
                        itemUtilities(
                            value: findNowController
                                    .findFast.value.hasAirConditioner ??
                                false,
                            tile: "Điều hoà",
                            onCheck: () {
                              findNowController
                                    .findFast.value
                                  .hasAirConditioner = !(findNowController
                                    .findFast
                                      .value
                                      .hasAirConditioner ??
                                  false);
                            }),
                        itemUtilities(
                            value: findNowController
                                    .findFast.value.hasWaterHeater ??
                                false,
                            tile: "Nóng lạnh",
                            onCheck: () {
                              findNowController
                                    .findFast.value
                                  .hasWaterHeater = !(findNowController
                                    .findFast.value.hasWaterHeater ??
                                  false);
                            }),
                        itemUtilities(
                            value: findNowController
                                    .findFast.value.hasKitchen ??
                                false,
                            tile: "Kệ bếp",
                            onCheck: () {
                              findNowController
                                    .findFast.value
                                  .hasKitchen = !(findNowController
                                    .findFast.value.hasKitchen ??
                                  false);
                            }),
                        itemUtilities(
                            value: findNowController
                                    .findFast.value.hasFridge ??
                                false,
                            tile: "Tủ lạnh",
                            onCheck: () {
                              findNowController
                                    .findFast.value
                                  .hasFridge = !(findNowController
                                    .findFast.value.hasFridge ??
                                  false);
                            }),
                        itemUtilities(
                            value: findNowController
                                    .findFast.value.hasBed ??
                                false,
                            tile: "Giường ngủ",
                            onCheck: () {
                              findNowController
                                    .findFast.value
                                  .hasBed = !(findNowController
                                    .findFast.value.hasBed ??
                                  false);
                            }),
                        itemUtilities(
                            value:findNowController
                                    .findFast.value.hasWashingMachine ??
                                false,
                            tile: "Máy giặt",
                            onCheck: () {
                              findNowController
                                    .findFast.value
                                  .hasWashingMachine = !(findNowController
                                    .findFast
                                      .value
                                      .hasWashingMachine ??
                                  false);
                            }),
                        itemUtilities(
                            value: findNowController
                                    .findFast.value.hasKitchenStuff ??
                                false,
                            tile: "Đồ dùng bếp",
                            onCheck: () {
                              findNowController
                                    .findFast.value
                                  .hasKitchenStuff = !(findNowController
                                    .findFast.value.hasKitchenStuff ??
                                  false);
                            }),
                        itemUtilities(
                            value:findNowController
                                    .findFast.value.hasTable ??
                                false,
                            tile: "Bàn ghế",
                            onCheck: () {
                              findNowController
                                    .findFast.value
                                  .hasTable = !(findNowController
                                    .findFast.value.hasTable ??
                                  false);
                            }),
                        itemUtilities(
                            value: findNowController
                                    .findFast.value
                                    .hasDecorativeLights ??
                                false,
                            tile: "Đèn trang trí",
                            onCheck: () {
                              findNowController
                                    .findFast.value
                                      .hasDecorativeLights =
                                  !(findNowController
                                    .findFast
                                          .value.hasDecorativeLights ??
                                      false);
                            }),
                        itemUtilities(
                            value:findNowController
                                    .findFast.value.hasPicture ??
                                false,
                            tile: "Tranh trang trí",
                            onCheck: () {
                              findNowController
                                    .findFast.value
                                  .hasPicture = !(findNowController
                                    .findFast.value.hasPicture ??
                                  false);
                            }),
                        itemUtilities(
                            value: findNowController
                                    .findFast.value.hasTree ??
                                false,
                            tile: "Cây cối trang trí",
                            onCheck: () {
                              findNowController
                                    .findFast.value
                                  .hasTree = !(findNowController
                                    .findFast.value.hasTree ??
                                  false);
                            }),
                        itemUtilities(
                            value: findNowController
                                    .findFast.value.hasPillow ??
                                false,
                            tile: "Chăn ga gối",
                            onCheck: () {
                              findNowController
                                    .findFast.value
                                  .hasPillow = !(findNowController
                                    .findFast.value.hasPillow ??
                                  false);
                            }),
                        itemUtilities(
                            value: findNowController
                                    .findFast.value.hasWardrobe ??
                                false,
                            tile: "Tủ quần áo",
                            onCheck: () {
                              findNowController
                                    .findFast.value
                                  .hasWardrobe = !(findNowController
                                    .findFast.value.hasWardrobe ??
                                  false);
                            }),
                        itemUtilities(
                            value: findNowController
                                    .findFast.value.hasMattress ??
                                false,
                            tile: "Nệm",
                            onCheck: () {
                              findNowController
                                    .findFast.value
                                  .hasMattress = !(findNowController
                                    .findFast.value.hasMattress ??
                                  false);
                            }),
                        itemUtilities(
                            value: findNowController
                                    .findFast.value.hasShoesRacks ??
                                false,
                            tile: "Kệ giày dép",
                            onCheck: () {
                              findNowController
                                    .findFast.value
                                  .hasShoesRacks = !(findNowController
                                    .findFast.value.hasShoesRacks ??
                                  false);
                            }),
                        itemUtilities(
                            value: findNowController
                                    .findFast.value.hasCurtain ??
                                false,
                            tile: "Rèm",
                            onCheck: () {
                              findNowController
                                    .findFast.value
                                  .hasCurtain = !(findNowController
                                    .findFast.value.hasCurtain ??
                                  false);
                            }),
                        itemUtilities(
                            value: findNowController
                                    .findFast.value.hasCeilingFans ??
                                false,
                            tile: "Quạt trần",
                            onCheck: () {
                              findNowController
                                    .findFast.value
                                  .hasCeilingFans = !(findNowController
                                    .findFast.value.hasCeilingFans ??
                                  false);
                            }),
                        itemUtilities(
                            value:findNowController
                                    .findFast.value.hasMirror ??
                                false,
                            tile: "Gương toàn thân",
                            onCheck: () {
                              findNowController
                                    .findFast.value
                                  .hasMirror = !(findNowController
                                    .findFast.value.hasMirror ??
                                  false);
                            }),
                        itemUtilities(
                            value: findNowController
                                    .findFast.value.hasSofa ??
                                false,
                            tile: "Sofa",
                            onCheck: () {
                             findNowController
                                    .findFast.value
                                  .hasSofa = !(findNowController
                                    .findFast.value.hasSofa ??
                                  false);
                            }),
                      ],
                    ),
                  ),
                ),
                   ],
                 ),
                Container(
                  
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 6,
                        offset: const Offset(1, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: SahaTextFieldNoBorder(
                    enabled: true,
                    controller: findNowController.noteEdit,
                    onChanged: (v) {
                      findNowController.findFast.value.note = v;
                    },
                    textInputType: TextInputType.multiline,
                    maxLine: 5,
                    labelText: "Ghi chú thêm",
                    hintText: "Nhập ghi chú",
                  ),
                ),
               
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget itemPrice(String price) {
    return InkWell(
      onTap: () {
        findNowController.price.text = price;
        findNowController.findFast.value.price =
            double.parse(SahaStringUtils().convertFormatText(price));
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
        child: Container(
          width: Get.width / 5,
          decoration: BoxDecoration(
              color: Colors.grey[200], borderRadius: BorderRadius.circular(12)),
          child: Center(child: Text(price)),
        ),
      ),
    );
  }

  Widget itemCapacity(int capacity) {
    return InkWell(
      onTap: () {
        findNowController.capacity.text = capacity.toString();
        findNowController.findFast.value.capacity = capacity;
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
        child: Container(
          width: Get.width / 7,
          decoration: BoxDecoration(
              color: Colors.grey[200], borderRadius: BorderRadius.circular(12)),
          child: Center(child: Text('$capacity')),
        ),
      ),
    );
  }
  Widget itemUtilities(
      {required bool value, required String tile, required Function onCheck}) {
    return InkWell(
      onTap: () {
        onCheck();
        findNowController.findFast.refresh();
      },
      child: Stack(
        children: [
          Container(
            width: (Get.width - 40) / 2,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                    color: value
                        ? Theme.of(Get.context!).primaryColor
                        : Colors.grey[200]!)),
            child: Center(
              child: Text(
                tile,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: value ? Theme.of(Get.context!).primaryColor : null),
              ),
            ),
          ),
          if (value == false)
            Positioned.fill(
              child: Container(
                height: 45,
                width: 45,
                decoration: BoxDecoration(
                  color: Colors.grey[200]!.withOpacity(0.5),
                ),
              ),
            ),
          if (value == true)
            Positioned(
              left: -25,
              top: -20,
              child: Container(
                  height: 45,
                  width: 45,
                  decoration: BoxDecoration(
                    color: Theme.of(Get.context!).primaryColor,
                  ),
                  transform: Matrix4.rotationZ(-0.5),
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: const <Widget>[
                      Positioned(
                          bottom: -0,
                          right: 20,
                          child: RotationTransition(
                            turns: AlwaysStoppedAnimation(20 / 360),
                            child: Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 13,
                            ),
                          ))
                    ],
                  )),
            )
        ],
      ),
    );
  }
}

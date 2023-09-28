import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gohomy/components/dialog/dialog.dart';
import 'package:gohomy/model/motel_room.dart';
import 'package:gohomy/model/service.dart';
import 'package:gohomy/screen/owner/choose_room/choose_room_screen.dart';
import 'package:gohomy/screen/profile/bill/add_bill/add_bill_controller.dart';
import 'package:gohomy/screen/profile/bill/widget/dialog_add_service.dart';
import 'package:intl/intl.dart';
import 'package:pattern_formatter/numeric_formatter.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:flutter/services.dart';
import '../../../../components/arlert/saha_alert.dart';
import '../../../../components/button/saha_button.dart';
import '../../../../components/loading/loading_full_screen.dart';
import '../../../../components/text_field/info_input_text_field.dart';
import '../../../../components/text_field/text_field_no_border.dart';
import '../../../../components/widget/image/select_images.dart';
import '../../../../const/type_image.dart';
import '../../../../model/bill.dart';
import '../../../../model/contract.dart';
import '../../../../model/image_assset.dart';
import '../../../../utils/string_utils.dart';
import '../../../owner/service/add_service/add_service_screen.dart';
import '../choose_contract/choose_contract_screen.dart';

class AddBillScreen extends StatelessWidget {
  Bill? billInput;
  Contract? contractInput;


  AddBillScreen({this.billInput,this.contractInput}) {
    addBillController = AddBillController(billInput: billInput,contractInput: contractInput);
  }

  late AddBillController addBillController;

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: <Color>[Colors.deepOrange, Colors.orange]),
            ),
          ),
          title: billInput == null
              ? const Text('Thêm hóa đơn')
              : const Text('Sửa hóa đơn'),
        ),
        body: Obx(
          () => addBillController.isLoading.value == true
              ? SahaLoadingFullScreen()
              : Padding(
                  padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                  child: Form(
                    key: formKey,
                    child: SingleChildScrollView(
                      keyboardDismissBehavior:
                          ScrollViewKeyboardDismissBehavior.onDrag,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                //color: Theme.of(context).primaryColor,
                              ),
                              child: Image.asset(
                                'assets/icon_bill/thong-tin.png',
                                width: Get.width / 3,
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            const Text(
                              'Hóa đơn tiền nhà tháng',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w300),
                            ),
                            InfoInputTextField(
                              textEditingController: addBillController.dateEdit,
                              icon: const Icon(Icons.calendar_today_sharp),
                              hintText: "Tháng",
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
                                              if (v is DateTime) {
                                                addBillController
                                                        .dateEdit.text =
                                                    DateFormat('MM-yyyy')
                                                        .format(v);
                                                addBillController
                                                        .billReq.value.content =
                                                    DateFormat('MM-yyyy')
                                                        .format(v);
                                              }
                                              Get.back();
                                            },
                                            showActionButtons: true,
                                            allowViewNavigation: false,
                                            //onSelectionChanged: chooseRangeTime,
                                            view: DateRangePickerView.year,
                                            selectionMode:
                                                DateRangePickerSelectionMode
                                                    .single,
                                            maxDate: DateTime.now(),
                                          ),
                                        ),
                                      );
                                    });
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Chọn hợp đồng",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 14),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                InkWell(
                                  onTap: () {

                                    if(billInput != null){
                                      return;
                                    }
                                    Get.to(()=>ChooseContractScreen(
                                      contractSelected: addBillController.contractChoose.value,
                                      onChoose: (Contract contract)async{
                                        addBillController.contractChoose.value = contract;

                                           addBillController
                                                .motelChoose.value.id = contract.motelId;
                                            addBillController
                                                .motelChoose.value = contract.motelRoom ?? MotelRoom();
                                            await addBillController.getBillRoom(
                                                addBillController
                                                    .motelChoose.value.id!);

                                      },
                                    ));
                                  },
                                  child: Row(
                                    children: [
                                    billInput == null ?
                                      Obx(
                                        () => Expanded(
                                          child: Text(
                                            addBillController.contractChoose
                                                        .value.id ==
                                                    null
                                                ? 'chọn hợp đồng'
                                                : "Hợp đồng thuê ${addBillController.contractChoose.value.motelRoom?.motelName ?? ''}",
                                            style: TextStyle(
                                                color: addBillController
                                                            .contractChoose
                                                            .value
                                                            .id ==
                                                        null
                                                    ? null
                                                    : Colors.blue),
                                          ),
                                        ),
                                      ) : Expanded(
                                                child: Text(
                                                    
                                                    "Hợp đồng thuê ${billInput?.motel?.motelName ?? ''}"),
                                              ),
                                      const Icon(
                                        Icons.arrow_forward_ios_rounded,
                                        size: 15,
                                      )
                                    ],
                                  ),
                                ),
                                const Divider(),
                                const SizedBox(
                                  height: 16,
                                ),
                              ],
                            ),
                            if(addBillController.contractChoose.value.id != null)
                            Stack(
                              children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Tên phòng *",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w300,
                                        fontSize: 14),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      // Get.to(() => ChooseRoomScreen(
                                      //     isChooseFromBill: true,
                                      //     hasContract: true,
                                      //     onChoose: (v) async {
                                      //       addBillController
                                      //           .motelChoose.value.id = v[0].id;
                                      //       addBillController
                                      //           .motelChoose.value = v[0];
                                      //       await addBillController.getBillRoom(
                                      //           addBillController
                                      //               .motelChoose.value.id!);
                                      //     }));
                                    },
                                    child: Row(
                                      children: [
                                 
                                        billInput == null
                                            ? Obx(
                                                () => Expanded(
                                                  child: Text(
                                                    addBillController
                                                                .motelChoose
                                                                .value
                                                                .id ==
                                                            null
                                                        ? 'tên phòng'
                                                        : addBillController
                                                                .motelChoose
                                                                .value
                                                                .motelName ??
                                                            "",
                                                  ),
                                                ),
                                              )
                                            : Expanded(
                                                child: Text(addBillController
                                                            .motelChoose
                                                            .value
                                                            .id ==
                                                        null
                                                    ? '${billInput!.motel!.motelName}'
                                                    : addBillController
                                                            .motelChoose
                                                            .value
                                                            .motelName ??
                                                        ""),
                                              ),
                                        // const Icon(
                                        //   Icons.arrow_forward_ios_rounded,
                                        //   size: 15,
                                        // )
                                      ],
                                    ),
                                  ),
                                  const Divider(),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                ],
                              ),
                         
                            ]),
                            Row(
                              children: [
                                Image.asset(
                                  'assets/icon_bill/phi-dich-vu.png',
                                  width: Get.width / 3,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                InkWell(
                                  onTap: () {
                                    DialogAddService.showDialogServiceInput(
                                        onDone: (String name, double price,
                                            int quantity) {
                                      if ((addBillController
                                                  .billReq.value.moService ??
                                              [])
                                          .isEmpty) {
                                        addBillController
                                            .billReq.value.moService = [];
                                        addBillController
                                            .billReq.value.moService!
                                            .add(Service(
                                                serviceName: name,
                                                typeUnit: 4,
                                                serviceCharge: price,
                                                quantity: quantity));
                                        addBillController.billReq.refresh();
                                      } else {
                                        addBillController
                                            .billReq.value.moService!
                                            .add(Service(
                                                serviceName: name,
                                                typeUnit: 4,
                                                serviceCharge: price,
                                                quantity: quantity));
                                        addBillController.billReq.refresh();
                                      }
                                      Get.back();
                                    });
                                  },
                                  child: Container(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(40),
                                        border:
                                            Border.all(color: Colors.black)),
                                    child: Row(
                                      children: const [
                                        Text(
                                          'Thêm phí dịch vụ',
                                          style: TextStyle(fontSize: 12),
                                        ),
                                        Icon(
                                          Icons.add,
                                          size: 14,
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                            ...(addBillController.billReq.value.moService ?? [])
                                .map((e) => service(
                                    e,
                                    (addBillController
                                                .billReq.value.moService ??
                                            [])
                                        .indexOf(e)))
                                .toList(),
                            const SizedBox(
                              height: 16,
                            ),
                            all(),
                            const SizedBox(
                              height: 50,
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
                                    offset: const Offset(
                                        1, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: SahaTextFieldNoBorder(
                                enabled: true,
                                controller:
                                    addBillController.noteTextEditingController,
                                onChanged: (v) {
                                  addBillController.billReq.value.note = v;
                                },
                                textInputType: TextInputType.multiline,
                                maxLine: 5,
                                labelText: "Ghi chú",
                                hintText: "Nhập ghi chú",
                              ),
                            ),
                          ]),
                    ),
                  ),
                ),
        ),
        bottomNavigationBar: SizedBox(
          height: 65,
          child: Column(
            children: [
              SahaButtonFullParent(
                text: billInput != null ? 'Sửa hoá đơn' : "Tạo hoá đơn",
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    if (billInput != null) {
                      addBillController.updateBill();
                    } else {
                      addBillController.addBill();
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget all() {
    double moneyService() {
      var money = 0.0;
      for (var e in (addBillController.billReq.value.moService ?? [])) {
        if (e.typeUnit == 0) {
          money = money +
              (((e.quantity ?? 0) - (e.oldQuantity ?? 0)) *
                  (e.serviceCharge ?? 0));
        } else {
          money = money + (((e.quantity ?? 0)) * (e.serviceCharge ?? 0));
        }
      }
      return money;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Image.asset(
            'assets/icon_bill/hoa-don-tong.png',
            width: Get.width / 3,
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
          child: Column(
            children: [
              Row(
                children: [
                  const Text(
                    'Tiền phòng(1 tháng)',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () {
                      SahaDialogApp.showDialogInput(
                          title: 'Tiền phòng',
                          isNumber: true,
                          textInput: SahaStringUtils().convertToUnit(
                              addBillController.billReq.value.totalMoneyMotel ??
                                  0),
                          onInput: (v) {
                            addBillController.billReq.value
                                .totalMoneyMotel = double.tryParse(
                                    SahaStringUtils().convertFormatText(v)) ??
                                0;
                            addBillController.billReq.refresh();
                          });
                    },
                    child: Row(
                      children: [
                        Text(
                          addBillController.billReq.value.totalMoneyMotel ==
                                  null
                              ? '0'
                              : SahaStringUtils().convertToMoney(
                                  addBillController
                                      .billReq.value.totalMoneyMotel),
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        const Icon(
                          Icons.edit,
                          size: 15,
                          color: Colors.blue,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Dịch vụ',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
                  ),
                  Text(
                    SahaStringUtils().convertToMoney(moneyService()),
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: moneyService() < 0 ? Colors.red : null),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Tổng',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
                  ),
                  Text(
                    SahaStringUtils().convertToMoney(
                        (addBillController.billReq.value.totalMoneyMotel ?? 0) +
                            moneyService()),
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color:
                            (addBillController.billReq.value.totalMoneyMotel ??
                                            0) +
                                        moneyService() <
                                    0
                                ? Colors.red
                                : null),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  const Text(
                    'Giảm giá',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () {
                      SahaDialogApp.showDialogInput(
                          title: 'Giảm giá',
                          isNumber: true,
                          textInput: SahaStringUtils().convertToUnit(
                              addBillController.billReq.value.discount ?? 0),
                          onInput: (v) {
                            addBillController
                                .billReq.value.discount = double.tryParse(
                                    SahaStringUtils().convertFormatText(v)) ??
                                0;
                            addBillController.billReq.refresh();
                          });
                    },
                    child: Row(
                      children: [
                        Text(
                          addBillController.billReq.value.discount == null
                              ? '0'
                              : SahaStringUtils().convertToMoney(
                                  addBillController.billReq.value.discount),
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        const Icon(
                          Icons.edit,
                          size: 15,
                          color: Colors.blue,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Tổng thanh toán ',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    SahaStringUtils().convertToMoney(
                        (addBillController.billReq.value.totalMoneyMotel ?? 0) +
                            moneyService() -
                            (addBillController.billReq.value.discount ?? 0)),
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: (addBillController
                                            .billReq.value.totalMoneyMotel ??
                                        0) +
                                    moneyService() +
                                    (addBillController.billReq.value.discount ??
                                        0) <
                                0
                            ? Colors.red
                            : Colors.green),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Dùng tiền cọc thanh toán hoá đơn:'),
                  Checkbox(
                      value: addBillController.isUseDepositMoney.value,
                      onChanged: (v) {
                        addBillController.isUseDepositMoney.value = v!;
                        addBillController.billReq.value.hasUseDeposit = v;
                      })
                ],
              ),
              Obx(() => addBillController.isUseDepositMoney.value
                  ? const Text(
                      'Dùng tiền đặt cọc để thanh toán cho hoá đơn này',
                      style: TextStyle(color: Colors.red, fontSize: 14),
                    )
                  : Container()),
            ],
          ),
        ),
      ],
    );
  }

  Widget service(Service service, int index) {
    TextEditingController price = TextEditingController(
        text: SahaStringUtils().convertToUnit(service.serviceCharge ?? 0));
    price.selection =
        TextSelection.fromPosition(TextPosition(offset: price.text.length));
    TextEditingController oldQuantity =
        TextEditingController(text: '${service.oldQuantity ?? 0}');
    oldQuantity.selection = TextSelection.fromPosition(
        TextPosition(offset: oldQuantity.text.length));
    TextEditingController quantity = TextEditingController(
        text: service.typeUnit == 2 ? "1" : '${service.quantity ?? 0}');

    if (service.typeUnit == 2) {
      service.quantity = 1;
    }

    quantity.selection =
        TextSelection.fromPosition(TextPosition(offset: quantity.text.length));

    double totalMoneyService(int type) {
      if (service.typeUnit == 0) {
        return (((service.quantity ?? 0) - (service.oldQuantity ?? 0)) *
            (service.serviceCharge ?? 0));
      } else {
        return (((service.quantity ?? 0)) * (service.serviceCharge ?? 0));
      }
    }

    return Container(
      width: Get.width,
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 1,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    "${service.typeUnit == 0 ? service.serviceName ?? "" : "${service.serviceName ?? ""} - ${convertServiceType(service.typeUnit ?? 0)}"}  (${SahaStringUtils().convertToMoney(service.serviceCharge ?? 0)} ${service.serviceUnit ?? ""})",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 14)),
                if (service.typeUnit != 2)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SelectImages(
                      type: BILL_FILES_FOLDER,
                      maxImage: 10,
                      title: 'Ảnh chỉ số ${service.serviceName ?? ""}',
                      subTitle: 'Tối đa 10 hình',
                      onUpload: () {},
                      images: (service.images ?? [])
                          .map((e) => ImageData(linkImage: e))
                          .toList(),
                      doneUpload: (List<ImageData> listImages) {
                        print(
                            "done upload image ${listImages.length} images => ${listImages.toList().map((e) => e.linkImage).toList()}");

                        if ((listImages.map((e) => e.linkImage ?? "x"))
                            .toList()
                            .contains('x')) {
                          SahaAlert.showError(message: 'Lỗi ảnh');
                          return;
                        }
                        service.images =
                            listImages.map((e) => e.linkImage ?? "").toList();
                        addBillController.billReq.refresh();
                      },
                    ),
                  ),
                const SizedBox(
                  height: 8,
                ),
                service.typeUnit == 0
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: 150,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                                color: Colors.white),
                            child: TextFormField(
                              controller: oldQuantity,
                              keyboardType: TextInputType.number,
                              readOnly: true,
                              decoration: InputDecoration(
                                  label: const Text(
                                    'Chỉ số cũ',
                                    style: TextStyle(fontSize: 14),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: const BorderSide(
                                        color: Colors.black, width: 1),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: const BorderSide(
                                        color: Colors.black, width: 1),
                                  )),
                              onChanged: (v) {
                                service.oldQuantity = int.tryParse(v) ?? 0;
                                addBillController.billReq.refresh();
                              },
                            ),
                          ),
                          Container(
                            width: 150,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                                color: Colors.white),
                            child: TextFormField(
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              keyboardType: TextInputType.number,
                              controller: quantity,
                              validator: ((value) {
                                if (value == '') {
                                  return 'không được bỏ trống';
                                }
                                if (int.parse(value!) <
                                    int.parse(oldQuantity.text)) {
                                  return 'Nhập lại ';
                                }
                                return null;
                              }),
                              decoration: InputDecoration(
                                  label: const Text(
                                    'Chỉ số mới',
                                    style: TextStyle(fontSize: 14),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.red, width: 1),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: const BorderSide(
                                        color: Colors.black, width: 1),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: const BorderSide(
                                        color: Colors.black, width: 1),
                                  )),
                              onChanged: (v) {
                                service.quantity = int.tryParse(v) ?? 0;
                                addBillController.billReq.refresh();
                              },
                            ),
                          ),
                        ],
                      )
                    : Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: 150,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                                color: Colors.white),
                            child: TextFormField(
                              controller: price,
                              //readOnly: true,
                              keyboardType: TextInputType.number,
                              inputFormatters: [ThousandsFormatter()],
                              decoration: InputDecoration(
                                  label: const Text(
                                    'Giá tiền',
                                    style: TextStyle(fontSize: 14),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: const BorderSide(
                                        color: Colors.black, width: 1),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: const BorderSide(
                                        color: Colors.black, width: 1),
                                  )),
                              onChanged: (v) {
                                service.serviceCharge = double.tryParse(
                                        SahaStringUtils()
                                            .convertFormatText(v)) ??
                                    0;
                                addBillController.billReq.refresh();
                              },
                            ),
                          ),
                          Container(
                            width: 150,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                                color: Colors.white),
                            child: TextFormField(
                              readOnly: service.typeUnit == 2 ? true : false,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              keyboardType: TextInputType.number,
                              controller: quantity,
                              validator: ((value) {
                                if (value == '') {
                                  return 'Không được để trống';
                                }

                                return null;
                              }),
                              decoration: InputDecoration(
                                  label: const Text(
                                    'Số lượng',
                                    style: TextStyle(fontSize: 14),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.red, width: 1),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: const BorderSide(
                                        color: Colors.black, width: 1),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: const BorderSide(
                                        color: Colors.black, width: 1),
                                  )),
                              onChanged: (v) {
                                service.quantity = int.tryParse(v) ?? 0;
                                addBillController.billReq.refresh();
                              },
                            ),
                          ),
                        ],
                      ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Thành tiền :',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                    Text(
                      SahaStringUtils().convertToMoney(
                          totalMoneyService(service.typeUnit ?? 0)),
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: totalMoneyService(service.typeUnit ?? 0) < 0
                              ? Colors.red
                              : null),
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (service.typeUnit == 4)
            Positioned(
              top: 5,
              right: 5,
              child: IconButton(
                  onPressed: () {
                    (addBillController.billReq.value.moService ?? [])
                        .removeAt(index);
                    addBillController.billReq.refresh();
                  },
                  icon: const Icon(
                    Icons.clear,
                    color: Colors.red,
                  )),
            )
        ],
      ),
    );
  }
}

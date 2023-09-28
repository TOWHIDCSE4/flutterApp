import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gohomy/components/loading/loading_full_screen.dart';
import 'package:gohomy/screen/admin/decentralization_admin/add_decentralization/add_decentralization_screen.dart';
import 'package:gohomy/screen/admin/decentralization_admin/decentralization_manage_controller.dart';
import 'package:gohomy/screen/admin/decentralization_admin/update_decentralization/update_decentralization_screen.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../components/dialog/dialog.dart';
import '../../../model/decentralization.dart';

class DecentralizationScreen extends StatelessWidget {
  DecentralizationScreen({Key? key}) : super(key: key);
  DecentralizationController decentralizationController =
      DecentralizationController();
  RefreshController refreshController = RefreshController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                // begin: Alignment.bottomLeft,
                // end: Alignment.topRight,
                colors: <Color>[Colors.deepOrange, Colors.orange]),
          ),
        ),
        title: const Text('Quản lý phân quyền'),
      ),
      body: Obx(
        () => decentralizationController.loadInit.value
            ? SahaLoadingFullScreen()
            : decentralizationController.listDecentralization.isEmpty
                ? const Center(
                    child: Text('Chưa có phần quyền nào'),
                  )
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        ...decentralizationController.listDecentralization
                            .map((element) => itemDecentralization(element))
                      ],
                    ),
                  ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => AddDecentralizationScreen())!.then((value) =>
              decentralizationController.getAllDecentralization(
                  isRefresh: true));
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget itemDecentralization(Decentralization decentralization) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: Colors.deepOrange)),
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Phân quyền: ${decentralization.name ?? " "}",
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: const [
                      Text(
                        "Mô tả: ",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    decentralization.description ?? "",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Get.to(() => UpdateDecentralizationScreen(
                                  id: decentralization.id!,
                                ))!
                            .then((value) => decentralizationController
                                .getAllDecentralization(isRefresh: true));
                      },
                      child: Container(
                        margin: const EdgeInsets.all(8),
                        padding: const EdgeInsets.only(
                            right: 8, left: 8, bottom: 5, top: 5),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: const BorderRadius.all(Radius.circular(3))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: const [Text("   Sửa   ")],
                            )
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        SahaDialogApp.showDialogYesNo(
                            mess: 'Bạn có chắc chắn muốn xoá hoá đơn này chứ ?',
                            onOK: () {
                              decentralizationController
                                  .deleteDecentralization(
                                      id: decentralization.id!)
                                  .then((value) => decentralizationController
                                      .getAllDecentralization(isRefresh: true));
                            });
                      },
                      child: Container(
                        margin: const EdgeInsets.all(8),
                        padding: const EdgeInsets.only(
                            right: 8, left: 8, bottom: 5, top: 5),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: const BorderRadius.all(Radius.circular(3))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: const [Text("   Xoá   ")],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const Divider(
          height: 1,
        ),
      ],
    );
  }
}

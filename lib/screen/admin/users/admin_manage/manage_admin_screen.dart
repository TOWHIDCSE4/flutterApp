import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gohomy/screen/admin/users/admin_manage/admin_detail/admin_detail_screen.dart';
import 'package:gohomy/screen/admin/users/admin_manage/manage_admin_controller.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../components/empty/saha_empty_avatar.dart';
import '../../../../components/loading/loading_full_screen.dart';
import '../../../../components/loading/loading_widget.dart';
import '../../../../model/user.dart';

class ManageAdminScreen extends StatelessWidget {
  ManageAdminScreen({Key? key}) : super(key: key);
  ManageAdminController manageAdminController = ManageAdminController();
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
        title: const Text('Quản lý admin'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
              child: Obx(
                () => manageAdminController.loadInit.value
                    ? SahaLoadingFullScreen()
                    : SmartRefresher(
                        controller: refreshController,
                        enablePullDown: true,
                        enablePullUp: true,
                        header: const MaterialClassicHeader(),
                        onRefresh: () async {},
                        onLoading: () async {},
                        footer: CustomFooter(
                          builder: (
                            BuildContext context,
                            LoadStatus? mode,
                          ) {
                            Widget body = Container();
                            if (mode == LoadStatus.idle) {
                              body = Obx(() =>
                                  manageAdminController.isLoading.value
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
                        child: ListView.builder(
                            addAutomaticKeepAlives: false,
                            addRepaintBoundaries: false,
                            itemCount: manageAdminController.listAdmin.length,
                            itemBuilder: (BuildContext context, int index) {
                              return userItem(
                                  manageAdminController.listAdmin[index]);
                            }),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget userItem(User user) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          Get.to(() => AdminDetailScreen(id: user.id!))!.then(
              (value) => manageAdminController.getAllAdmin(isRefresh: true));
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 1,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100.0),
                  child: CachedNetworkImage(
                    height: 70,
                    width: 70,
                    fit: BoxFit.cover,
                    imageUrl: user.avatarImage == null ? '' : user.avatarImage!,
                    //placeholder: (context, url) => SahaLoadingWidget(),
                    errorWidget: (context, url, error) => const SahaEmptyAvata(
                      height: 60,
                      width: 60,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        Text(
                          user.name ?? 'Chưa có tên',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Colors.orange[700]),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      user.phoneNumber ?? '',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

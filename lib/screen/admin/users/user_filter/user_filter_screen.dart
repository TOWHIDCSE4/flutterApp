import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gohomy/screen/data_app_controller.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../components/empty/saha_empty_avatar.dart';
import '../../../../components/loading/loading_full_screen.dart';
import '../../../../components/loading/loading_widget.dart';
import '../../../../model/user.dart';
import '../../../../utils/debounce.dart';
import 'user_filter_controller.dart';

class UserFilterScreen extends StatefulWidget {
  final bool? isShowTab;
  final Function onChoose;
  final int? idChoose;

  const UserFilterScreen(
      {this.isShowTab = true, required this.onChoose, this.idChoose});

  @override
  State<UserFilterScreen> createState() => _UserFilterScreenState();
}

class _UserFilterScreenState extends State<UserFilterScreen>
    with SingleTickerProviderStateMixin {
  RefreshController refreshController = RefreshController();
  late TabController _tabController;
  late UserFilterController userFilterController;

  @override
  void initState() {
    super.initState();
    userFilterController =
        UserFilterController(isHost: widget.isShowTab == false ? true : false);
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
        title: Obx(
          () => userFilterController.isSearch.value == true
              ? Container(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: Colors.white,
                  ),
                  child: Container(
                    padding: const EdgeInsets.only(left: 10),
                    height: 40,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5)),
                    child: TextFormField(
                      onFieldSubmitted: (value) {
                        userFilterController.search = value;
                        userFilterController.getAllUsers(isRefresh: true);
                      },
                      controller: userFilterController.searchEdit,
                      autofocus:
                          userFilterController.isSearch.value ? true : false,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: const EdgeInsets.only(
                            right: 15, top: 20, bottom: 5),
                        border: InputBorder.none,
                        hintText: "Tìm kiếm",
                        suffixIcon: IconButton(
                          onPressed: () {
                            userFilterController.searchEdit.clear();
                            //chatListController.listBoxChatSearch([]);
                            userFilterController.search = '';
                            userFilterController.getAllUsers(isRefresh: true);
                            FocusScope.of(context).unfocus();

                            userFilterController.isSearch.value = false;
                          },
                          icon: const Icon(
                            Icons.clear,
                            size: 15,
                          ),
                        ),
                      ),
                      onChanged: (v) {
                        EasyDebounce.debounce('user_filter_screen',
                            const Duration(milliseconds: 500), () {
                          userFilterController.search = v;
                          userFilterController.getAllUsers(isRefresh: true);
                        });
                      },
                      minLines: 1,
                      maxLines: 1,
                    ),
                  ),
                )
              : const Text('Chọn tài khoản'),
        ),
        actions: [
          IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                if (userFilterController.isSearch.value == false) {
                  userFilterController.isSearch.value = true;
                } else {
                  userFilterController.isSearch.value = false;
                }
              }),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          if (widget.isShowTab == true)
            SizedBox(
              height: 45,
              width: Get.width,
              child: ColoredBox(
                color: Colors.white,
                child: TabBar(
                  controller: _tabController,
                  onTap: (v) {
                    if (v == 0) {
                      userFilterController.isHost == true;
                      userFilterController.isRented == false;
                    } else {
                      userFilterController.isHost == false;
                      userFilterController.isRented == true;
                    }
                    userFilterController.getAllUsers(isRefresh: true);
                  },
                  tabs: [
                    Tab(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            'Chủ nhà',
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
                            'Người thuê',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          Expanded(
            child: Obx(
              () => userFilterController.loadInit.value
                  ? SahaLoadingFullScreen()
                  : SmartRefresher(
                      controller: refreshController,
                      enablePullDown: true,
                      enablePullUp: true,
                      onRefresh: () async {
                        await userFilterController.getAllUsers(isRefresh: true);
                        refreshController.refreshCompleted();
                      },
                      onLoading: () async {
                        await userFilterController.getAllUsers();
                        refreshController.loadComplete();
                      },
                      footer: CustomFooter(
                        builder: (
                          BuildContext context,
                          LoadStatus? mode,
                        ) {
                          Widget body = Container();
                          if (mode == LoadStatus.idle) {
                            body = Obx(() =>
                                userFilterController.isLoading.value
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
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            userItem(Get.find<DataAppController>()
                                .currentUser
                                .value),
                            ...userFilterController.listUser
                                .map((element) => userItem(element))
                                .toList()
                          ],
                        ),
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget userItem(User user) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () {
              widget.onChoose(user);
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
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100.0),
                      child: CachedNetworkImage(
                        height: 70,
                        width: 70,
                        fit: BoxFit.cover,
                        imageUrl:
                            user.avatarImage == null ? '' : user.avatarImage!,
                        // placeholder: (context, url) => SahaLoadingWidget(),
                        errorWidget: (context, url, error) =>
                            const SahaEmptyAvata(
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
                            const SizedBox(
                              width: 4,
                            ),
                            if (user.isHost == true) const Text('(Chủ nhà)'),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          user.phoneNumber ?? '',
                          style: const TextStyle(fontSize: 16),
                        ),
                        if (user.isHost == true && user.isHost != null)
                          Text(
                            "Thời gian giải quyết sự cố (phút) : ${user.avgMinutesResolvedProblem ?? 0}",
                            style: const TextStyle(fontSize: 13),
                          )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        if (user.id == widget.idChoose)
          const Positioned(
              top: 20,
              right: 20,
              child: Icon(
                Icons.check,
                color: Colors.green,
              ))
      ],
    );
  }
}

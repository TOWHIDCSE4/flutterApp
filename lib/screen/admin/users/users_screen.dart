import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gohomy/components/empty/saha_empty_avatar.dart';
import 'package:gohomy/screen/admin/users/user_details/user_details_screen.dart';

import 'package:gohomy/screen/admin/users/users_controller.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../components/loading/loading_full_screen.dart';
import '../../../components/loading/loading_widget.dart';
import '../../../model/user.dart';
import '../../../utils/debounce.dart';

class UsersScreen extends StatefulWidget {
  UsersScreen({Key? key, this.isHost}) : super(key: key);
  bool? isHost;
  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen>
    with SingleTickerProviderStateMixin {
  UserController userController = UserController();
  RefreshController refreshController = RefreshController();
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    if (widget.isHost == true) {
      userController.isHost = true;
      userController.getAllUsers(isRefresh: true);
    } else {
      _tabController = TabController(length: 2, vsync: this);
      userController.isRented = true;

      userController.getAllUsers(isRefresh: true);
    }
  }

  String dropdownValue = 'Mặc định';
  List<String> list = <String>[
    'Mặc định',
    'Hạng',
  ];

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
        title: Obx(
          () => userController.isSearch.value == true
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
                        userController.search = value;
                        userController.getAllUsers(isRefresh: true);
                      },
                      controller: userController.searchEdit,
                      autofocus: userController.isSearch.value ? true : false,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: const EdgeInsets.only(
                            right: 15, top: 20, bottom: 5),
                        border: InputBorder.none,
                        hintText: "Tìm kiếm",
                        suffixIcon: IconButton(
                          onPressed: () {
                            userController.searchEdit.clear();
                            //chatListController.listBoxChatSearch([]);
                            userController.search = '';
                            userController.getAllUsers(isRefresh: true);
                            FocusScope.of(context).unfocus();

                            userController.isSearch.value = false;
                          },
                          icon: const Icon(
                            Icons.clear,
                            size: 15,
                          ),
                        ),
                      ),
                      onChanged: (v) {
                        EasyDebounce.debounce(
                            'user_screen', const Duration(milliseconds: 500),
                            () {
                          userController.search = v;
                          userController.getAllUsers(isRefresh: true);

                          // if (v == '') {
                          //   chatListController.listBoxChatSearch([]);
                          // } else {
                          //   chatListController.textSearch = v;
                          //   chatListController.getAllBoxChat(isRefresh: true);
                          // }
                        });
                      },
                      minLines: 1,
                      maxLines: 1,
                    ),
                  ),
                )
              : const Text('Quản lý'),
        ),
        actions: [
          IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                if (userController.isSearch.value == false) {
                  userController.isSearch.value = true;
                } else {
                  userController.isSearch.value = false;
                }
              }),
        ],
      ),
      body: Column(
        children: [
          if (widget.isHost != true)
            SizedBox(
              height: 45,
              width: Get.width,
              child: ColoredBox(
                color: Colors.white,
                child: TabBar(
                  controller: _tabController,
                  onTap: (v) {
                    userController.isRented = v == 0 ? true : false;
                    userController.getAllUsers(isRefresh: true);
                  },
                  tabs: [
                    Tab(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            'Người thuê có phòng',
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
                            'Người thuê chưa có phòng',
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
          if (widget.isHost == true)
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Hiển thị người dùng theo :',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  DropdownButton<String>(
                    value: dropdownValue,
                    elevation: 16,
                    style: TextStyle(color: Theme.of(context).primaryColor),
                    onChanged: (String? value) {
                      setState(() {
                        dropdownValue = value!;
                        if (value == 'Hạng') {
                          userController.getAllUsers(
                              isRefresh: true, ranked: 'host_rank');
                        }
                        if (value == 'Mặc định') {
                          userController.getAllUsers(isRefresh: true);
                        }
                      });
                    },
                    items: list.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
              child: Obx(
                () => userController.loadInit.value
                    ? SahaLoadingFullScreen()
                    : SmartRefresher(
                        controller: refreshController,
                        enablePullDown: true,
                        enablePullUp: true,
                        header: const MaterialClassicHeader(),
                        onRefresh: () async {
                          if (dropdownValue == 'Mặc định') {
                            await userController.getAllUsers(isRefresh: true);
                            refreshController.refreshCompleted();
                          } else {
                            await userController.getAllUsers(
                                isRefresh: true, ranked: 'host_rank');
                            refreshController.refreshCompleted();
                          }
                        },
                        onLoading: () async {
                          if (dropdownValue == 'Mặc định') {
                            await userController.getAllUsers();
                            refreshController.loadComplete();
                          } else {
                            await userController.getAllUsers(
                                ranked: 'host_rank');
                            refreshController.loadComplete();
                          }
                        },
                        footer: CustomFooter(
                          builder: (
                            BuildContext context,
                            LoadStatus? mode,
                          ) {
                            Widget body = Container();
                            if (mode == LoadStatus.idle) {
                              body = Obx(() => userController.isLoading.value
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
                            itemCount: userController.listUser.length,
                            itemBuilder: (BuildContext context, int index) {
                              return userItem(userController.listUser[index]);
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
          if (dropdownValue == 'Mặc định') {
            Get.to(() => UserDetailsScreen(
                      userId: user.id!,
                      isHost: widget.isHost,
                    ))!
                .then((value) => userController.getAllUsers(isRefresh: true));
          } else {
            Get.to(() => UserDetailsScreen(
                      userId: user.id!,
                      isHost: widget.isHost,
                    ))!
                .then((value) => userController.getAllUsers(
                    isRefresh: true, ranked: 'host_rank'));
          }
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
                  borderRadius: BorderRadius.circular(100),
                  clipBehavior: Clip.hardEdge,
                  child: Stack(
                    children: [
                      ClipRRect(
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
                      if (user.accountRank == 2)
                        Positioned(
                            bottom: 0,
                            left: 0,
                            child: ClipRRect(
                                child: Image.asset(
                              'assets/vip.png',
                              height: 30,
                              width: 30,
                            ))),
                    ],
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
                    Text(
                      user.name ?? 'Chưa có tên',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.orange[700]),
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
                      ),
                    Text(
                        'Ngày tạo : ${DateFormat('dd-MM-yyyy').format(user.createdAt!)}'),
                    TextButton(
                        onPressed: () {
                          if (user.status == 0) {
                            userController.banUser(id: user.id!, status: 2);
                          } else {
                            userController.banUser(id: user.id!, status: 0);
                          }
                        },
                        child: Text(user.status == 0
                            ? 'Mở khoá tài khoản'
                            : 'Khoá tài khoản')),
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

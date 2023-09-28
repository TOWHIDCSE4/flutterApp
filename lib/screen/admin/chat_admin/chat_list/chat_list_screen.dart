import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../../components/dialog/dialog.dart';
import '../../../../components/empty/saha_empty_avatar.dart';
import '../../../../components/loading/loading_container.dart';
import '../../../../components/loading/loading_full_screen.dart';
import '../../../../data/remote/response-request/chat/all_box_chat_res.dart';
import '../../../../model/user.dart';
import '../../../../utils/date_utils.dart';
import '../../../../utils/debounce.dart';
import '../../../data_app_controller.dart';
import '../chat_detail/chat_detail_screen.dart';
import 'chat_list_controller.dart';

class ChatListAdminScreen extends StatefulWidget {
  User userInputWatch;
  User? toUser;
  ChatListAdminScreen({this.toUser, required this.userInputWatch});
  @override
  State<ChatListAdminScreen> createState() => _ChatListAdminScreenState();
}

class _ChatListAdminScreenState extends State<ChatListAdminScreen> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  late ChatListAdminController chatListController;
  DataAppController dataAppController = Get.find();

  @override
  void initState() {
    super.initState();
    chatListController =
        Get.put(ChatListAdminController(userInput: widget.userInputWatch));
    if (widget.toUser != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        chatListController.idPersonIn = widget.toUser?.id ?? 0;
        Get.to(() => ChatDetailAdminScreen(
                  toUser: widget.toUser!,
                ))!
            .then((value) {
          chatListController.getAllBoxChat(isRefresh: true);
        });
      });
    }
  }

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
          () => chatListController.isSearch.value == true
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
                        chatListController.textSearch = value;
                        chatListController.getAllBoxChat(isRefresh: true);
                      },
                      controller: chatListController.searchEdit,
                      autofocus:
                          chatListController.isSearch.value ? true : false,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: const EdgeInsets.only(
                            right: 15, top: 20, bottom: 5),
                        border: InputBorder.none,
                        hintText: "Tìm kiếm",
                        suffixIcon: IconButton(
                          onPressed: () {
                            chatListController.searchEdit.clear();
                            chatListController.listBoxChatSearch([]);
                            chatListController.textSearch = '';
                            chatListController.getAllBoxChat(isRefresh: true);
                            FocusScope.of(context).unfocus();

                            chatListController.isSearch.value = false;
                          },
                          icon: const Icon(
                            Icons.clear,
                            size: 15,
                          ),
                        ),
                      ),
                      onChanged: (v) {
                        EasyDebounce.debounce('debounce_timer_chatlist_search',
                            const Duration(milliseconds: 500), () {
                          chatListController.textSearch = v;
                          chatListController.getAllBoxChat(isRefresh: true);
                        });
                      },
                      minLines: 1,
                      maxLines: 1,
                    ),
                  ),
                )
              : const Text('Chat'),
        ),
        actions: [
          IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                if (chatListController.isSearch.value == false) {
                  chatListController.isSearch.value = true;
                } else {
                  chatListController.isSearch.value = false;
                }
              }),
        ],
      ),
      body: Obx(
        () => chatListController.listBoxChatSearch.isNotEmpty
            ? personSearch()
            : person(),
      ),
    );
  }

  Widget person() {
    return Obx(
      () => chatListController.isLoadingInit.value == true
          ? SahaLoadingFullScreen()
          : chatListController.listBoxChat.isEmpty
              ? const Center(
                  child: Icon(
                  Icons.chat_rounded,
                  size: 50,
                  color: Colors.grey,
                ))
              : SmartRefresher(
                  enablePullDown: true,
                  enablePullUp: true,
                  header: const MaterialClassicHeader(),
                  footer: CustomFooter(
                    builder: (
                      BuildContext context,
                      LoadStatus? mode,
                    ) {
                      Widget? body;
                      if (mode == LoadStatus.idle) {
                      } else if (mode == LoadStatus.loading) {
                        body = const CupertinoActivityIndicator();
                      } else if (mode == LoadStatus.canLoading) {
                        body = const Text("Đã hết User");
                      } else {
                        body = const Text("Đã xem hết User");
                      }
                      return SizedBox(
                        height: 55.0,
                        child: Center(child: body),
                      );
                    },
                  ),
                  controller: _refreshController,
                  onRefresh: () async {
                    await chatListController.getAllBoxChat(isRefresh: true);
                    _refreshController.refreshCompleted();
                  },
                  onLoading: () async {
                    await chatListController.getAllBoxChat();
                    _refreshController.loadComplete();
                  },
                  child: ListView.builder(
                      itemCount: chatListController.listBoxChat.length,
                      itemBuilder: (context, index) {
                        return itemChatUser(
                            chatListController.listBoxChat[index]);
                      }),
                ),
    );
  }

  Widget personSearch() {
    return Obx(
      () => chatListController.listBoxChatSearch.isEmpty
          ? const Center(
              child: Text('Không thấy tài khoản nào!'),
            )
          : ListView.builder(
              itemCount: chatListController.listBoxChatSearch.length,
              itemBuilder: (context, index) {
                return itemChatUser(
                    chatListController.listBoxChatSearch[index]);
              }),
    );
  }

  Widget itemChatUser(BoxChat boxChat) {
    return InkWell(
      onTap: () {
        chatListController.idPersonIn = boxChat.toUser?.id ?? 0;
        Get.to(() => ChatDetailAdminScreen(
                  toUser: boxChat.toUser!,
                ))!
            .then((value) {
          chatListController.getAllBoxChat(isRefresh: true);
        });
      },
      child: Column(
        children: [
          Slidable(
            endActionPane: ActionPane(
              motion: const ScrollMotion(),
              children: [
                SlidableAction(
                  // An action can be bigger than the others.
                  flex: 2,
                  onPressed: (BuildContext context) {
                    SahaDialogApp.showDialogYesNo(
                        mess: 'Bạn có chắc chắn muốn xoá tin nhắn này chứ?',
                        onOK: () {
                          chatListController.deleteBoxUSer(boxChat.vsUserId!);
                        });
                  },
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.red,
                  icon: Icons.delete,
                  label: 'Xoá',
                ),
              ],
            ),
            child: SizedBox(
              height: 80,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(3000),
                      child: CachedNetworkImage(
                        imageUrl: boxChat.toUser?.avatarImage ?? "",
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                        //placeholder: (context, url) => const SahaLoadingContainer(),
                        errorWidget: (context, url, error) =>
                            const SahaEmptyAvata(
                          height: 40,
                          width: 40,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                boxChat.toUser?.name ?? "Chưa đặt tên",
                                maxLines: 2,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: boxChat.seen == false
                                      ? FontWeight.bold
                                      : FontWeight.w500,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          "${boxChat.lastMess ?? ""} . ${SahaDateUtils().getHHMM(boxChat.updatedAt ?? DateTime.now())}",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontWeight: boxChat.seen == false
                                  ? FontWeight.bold
                                  : null,
                              fontSize: boxChat.seen == false ? 14 : 13),
                        ),
                      ],
                    ),
                  ),
                  if (boxChat.seen == false)
                    const Icon(
                      Icons.circle,
                      size: 18,
                      color: Colors.blue,
                    ),
                  const SizedBox(
                    width: 5,
                  ),
                ],
              ),
            ),
          ),
          const Divider(
            height: 1,
          ),
        ],
      ),
    );
  }
}

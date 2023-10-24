import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../components/dialog/dialog.dart';
import '../../../components/empty/saha_empty_avatar.dart';
import '../../../components/loading/loading_container.dart';
import '../../../components/loading/loading_full_screen.dart';
import '../../../components/widget/check_customer_login/check_customer_login_screen.dart';
import '../../../data/remote/response-request/chat/all_box_chat_res.dart';
import '../../../model/motel_post.dart';
import '../../../model/user.dart';
import '../../../utils/date_utils.dart';
import '../../../utils/debounce.dart';
import '../../../utils/string_utils.dart';
import '../../data_app_controller.dart';
import '../chat_detail/chat_detail_screen.dart';
import 'chat_list_controller.dart';

class ChatListLockScreen extends StatelessWidget {
  final User? toUser;
  final MotelPost? motelPost;
  final bool? isBackAll;
  const ChatListLockScreen({Key? key, this.toUser, this.motelPost,this.isBackAll})
      : super(key: key);
  //ChatListLockScreen({this.toUser});
  @override
  Widget build(BuildContext context) {
    return CheckCustomerLogin(
        child: ChatListScreen(
      motelPost: motelPost,
      toUser: toUser,
      isBackAll: isBackAll,
    ));
  }
}

class ChatListScreen extends StatefulWidget {
  User? toUser;
  bool? isBackAll;
  MotelPost? motelPost;
  ChatListScreen({this.toUser, this.isBackAll, this.motelPost});
  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  ChatListController chatListController = Get.put(ChatListController());
  DataAppController dataAppController = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.toUser != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        chatListController.idPersonIn = widget.toUser?.id ?? 0;
         if(widget.isBackAll == true){
            Get.back();
          }
        Get.to(() => ChatDetailScreen(
                  toUser: widget.toUser!,
                  isBackAll: widget.isBackAll,
                  motelPost: widget.motelPost,
                ))!
            .then((value) {
          chatListController.getChatAdminHelper();
         
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
                        chatListController.getChatAdminHelper();
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
                            chatListController.getChatAdminHelper();
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
                          chatListController.getChatAdminHelper();

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
                            chatListController.listBoxChat[index],index);
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
                    chatListController.listBoxChatSearch[index],index);
              }),
    );
  }

  Widget itemChatUser(BoxChat boxChat,int index) {
    return InkWell(
      onTap: () {
        chatListController.idPersonIn = boxChat.toUser?.id ?? 0;
        Get.to(() => ChatDetailScreen(
                  toUser: boxChat.toUser!,
                ))!
            .then((value) async{
         chatListController.listBoxChat[index] = await chatListController.getBoxChat(idBoxChat: boxChat.id!) ?? boxChat;
         chatListController.listBoxChat.refresh();
          //chatListController.getChatAdminHelper();
         dataAppController.getBadge();
        });
      },
      child: Slidable(
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
             
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
        child: Container(
          height: 80,
          margin:const EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ]),
          child: Container(
            decoration: BoxDecoration(
              color: index < chatListController.listAdminHelper.length
                  ? Color(0xffFFEDEF)
                  : index < chatListController.listAdminHelper.length + chatListController.listIsMyHost.length
                      ? Color(0xffFFF8EE)
                      : Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
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
                      placeholder: (context, url) =>
                          const SahaLoadingContainer(),
                      errorWidget: (context, url, error) =>
                          const SahaEmptyAvata(
                        height: 40,
                        width: 40,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Stack(
                    children: [
                      if (boxChat.seen == false)
                        Positioned(
                          right: 0,
                          top: 10,
                          child: const Icon(
                            Icons.circle,
                            size: 10,
                            color: Colors.red,
                          ),
                        ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                '${boxChat.toUser?.name ?? "Chưa đặt tên" } ${index < chatListController.listAdminHelper.length? " (Admin)" :index < chatListController.listAdminHelper.length + chatListController.listIsMyHost.length ?' (Chủ nhà)' : boxChat.isMyRenter == true ? '(Khách thuê)' : ""}',
                                  maxLines: 2,
                                  style: TextStyle(
                                      fontSize: 16,
                                      letterSpacing: 0.3,
                                      color: boxChat.seen == true ? Colors.orange.withOpacity(0.7) : Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.bold),
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(child: Text(
                                "${(boxChat.isMyLastMessage == 1) ? "Bạn: " : ""} ${(boxChat.lastListMoPostId ?? []).isNotEmpty ? "Tin phòng đính kèm" : boxChat.lastMess ?? ""}   ",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontWeight: boxChat.seen == false
                                        ? FontWeight.bold
                                        : null,
                                    fontSize:
                                    boxChat.seen == false ? 14 : 13),
                              ),),
                              Text(daysBetween(
                                          (boxChat.updatedAt ?? DateTime.now()), DateTime.now()) <
                                      4
                                  ? SahaStringUtils().displayTimeAgoFromTime(
                                      boxChat.updatedAt ?? DateTime.now())
                                  : DateFormat('dd-MM-yyyy').format(
                                      boxChat.updatedAt ?? DateTime.now())),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }
}

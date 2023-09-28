import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../components/arlert/saha_alert.dart';
import '../../../components/notification/alert_notification.dart';
import '../../../data/remote/response-request/chat/all_box_chat_res.dart';
import '../../../data/repository/repository_manager.dart';
import '../../../data/socket/socket.dart';
import '../../../utils/debounce.dart';
import '../../data_app_controller.dart';

class ChatListController extends GetxController {
  var listBoxChat = RxList<BoxChat>();
  var listAdminHelper = RxList<BoxChat>();
  var listIsMyHost = RxList<BoxChat>();
  var listBoxChatSearch = RxList<BoxChat>();
  int currentPage = 1;
  String? textSearch;
  bool isEnd = false;
  var isLoading = false.obs;
  var isLoadingInit = true.obs;
  var isSearch = false.obs;
  int idGroupIn = 0;
  int idPersonIn = 0;

  TextEditingController searchEdit = TextEditingController();
  DataAppController dataAppController = Get.find();

  ChatListController() {
    getChatAdminHelper();
    socket();
  }

  // Future<void> addFriend(int userId) async {
  //   try {
  //     var data =
  //         await RepositoryManager.accountRepository.addFriend(userId: userId);
  //     SahaAlert.showSuccess(message: "Đã thêm bạn bè");
  //   } catch (err) {
  //     SahaAlert.showError(message: err.toString());
  //   }
  // }

  Future<void> searchAllUser() async {
    try {
      var data = await RepositoryManager.chatRepository
          .searchAllUser(search: textSearch ?? '');
      if ((data?.data?.data ?? []).isNotEmpty) {
        listBoxChatSearch(
            data!.data!.data!.map((e) => BoxChat(toUser: e)).toList());
      }
    } catch (err) {
      SahaAlert.showError(message: toString());
    }
  }

  void socket() {
    print('this is socket');
    EasyDebounce.debounce(
        'debounce_timer_chatlist', const Duration(milliseconds: 2000), () {
      SocketUser().chatListPerson(dataAppController.badge.value.user?.id,
          (data) {
        listBoxChat(ChatPersonData.fromJson(data).data!);
        if (listBoxChat.isNotEmpty) {
          if (idPersonIn != (listBoxChat[0].toUser?.id ?? 0)) {
            SahaNotificationAlert.alertNotification(
                listBoxChat[0].toUser?.name ?? "",
                listBoxChat[0].lastMess ?? "");
          }
        }
      });
    });
  }

  Future<void> getAllBoxChat({
    bool? isRefresh,
  }) async {
    if (isRefresh == true) {
      currentPage = 1;
      isEnd = false;
    }

    try {
      if (isEnd == false) {
        isLoading.value = true;
        var data = await RepositoryManager.chatRepository
            .getAllBoxChat(page: currentPage, search: textSearch);

        if (isRefresh == true) {
          listBoxChat.value = [];
          listBoxChat.addAll(listAdminHelper);
          listBoxChat.addAll(listIsMyHost);
          listBoxChat.addAll(data!.data!.data!);
        } else {
          listBoxChat.addAll(data!.data!.data!);
        }

        if (data.data!.nextPageUrl == null) {
          isEnd = true;
        } else {
          isEnd = false;
          currentPage = currentPage + 1;
        }
      }

      isLoading.value = false;
      isLoadingInit.value = false;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isLoadingInit.value = false;
  }

  Future<void> deleteBoxUSer(int vsUserId) async {
    try {
      var data = await RepositoryManager.chatRepository
          .deleteBoxUSer(userId: vsUserId);
      getAllBoxChat(isRefresh: true);
      SahaAlert.showSuccess(message: "Đã xoá");
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> getChatAdminHelper() async {
    try {
      var data = await RepositoryManager.chatRepository
          .getChatAdminHelper(search: textSearch);
      listAdminHelper.value = data!.data!.adminHelper!;
      listIsMyHost.value = data.data!.myHost!;

      getAllBoxChat(isRefresh: true);
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<BoxChat?> getBoxChat({required int idBoxChat}) async {
    try {
      var data = await RepositoryManager.chatRepository
          .getBoxChat(idBoxChat: idBoxChat);
     return data!.data!;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }
}

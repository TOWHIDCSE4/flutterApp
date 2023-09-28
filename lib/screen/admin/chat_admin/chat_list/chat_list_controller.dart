import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../components/arlert/saha_alert.dart';
import '../../../../components/notification/alert_notification.dart';
import '../../../../data/remote/response-request/chat/all_box_chat_res.dart';
import '../../../../data/repository/repository_manager.dart';
import '../../../../data/socket/socket.dart';
import '../../../../model/user.dart';
import '../../../../utils/debounce.dart';
import '../../../data_app_controller.dart';

class ChatListAdminController extends GetxController {
  var listBoxChat = RxList<BoxChat>();
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
  User userInput;

  ChatListAdminController({required this.userInput}) {
    getAllBoxChat(isRefresh: true);
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
            .getAllBoxChatAdmin(page: currentPage, search: textSearch, userId: userInput.id!);

        if (isRefresh == true) {
          listBoxChat(data!.data!.data!);
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
}

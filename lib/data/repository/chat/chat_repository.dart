import '../../../model/motel_post.dart';
import '../../remote/response-request/account/all_user_res.dart';
import '../../remote/response-request/account/user_res.dart';
import '../../remote/response-request/chat/all_box_chat_res.dart';
import '../../remote/response-request/chat/all_mess_res.dart';
import '../../remote/response-request/chat/box_chat_res.dart';
import '../../remote/response-request/chat/chat_admin_helper_res.dart';
import '../../remote/response-request/chat/mess_res.dart';
import '../../remote/response-request/success/success_response.dart';
import '../../remote/saha_service_manager.dart';
import '../handle_error.dart';

class ChatRepository {
  Future<AllBoxChatRes?> getAllBoxChatAdmin({
    required int page,
    String? search,
    required int userId,
  }) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .getAllBoxChatAdmin(page, search, userId);
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<AllMessRes?> getAllMessAdmin(
      {required int personId, required int page}) async {
    try {
      var res =
          await SahaServiceManager().service!.getAllMessAdmin(personId, page);
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<AllBoxChatRes?> getAllBoxChat(
      {required int page, String? search}) async {
    try {
      var res = await SahaServiceManager().service!.getAllBoxChat(page, search);
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

    Future<BoxChatRes?> getBoxChat(
      {required int idBoxChat}) async {
    try {
      var res = await SahaServiceManager().service!.getBoxChat(idBoxChat);
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

    Future<ChatAdminHelperRes?> getChatAdminHelper({String? search}
      ) async {
    try {
      var res = await SahaServiceManager().service!.getChatAdminHelper(search);
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<AllMessRes?> getAllMess(
      {required int personId, required int page}) async {
    try {
      var res = await SahaServiceManager().service!.getAllMess(personId, page);
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<UserRes?> searchUser({
    required String phone,
  }) async {
    try {
      var res = await SahaServiceManager().service!.searchUser({
        'phone_number': phone,
      });
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<AllUserRes?> searchAllUser({
    required String search,
  }) async {
    try {
      var res = await SahaServiceManager().service!.searchAllUser(search);
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<MessRes?> chatPerson(
      {required int personId,
      String? content,
      String? id,
      List<MotelPost>? list,
      List<String>? image}) async {
    try {
      var res = await SahaServiceManager().service!.chatPerson(personId, {
        'content': content,
        'id': id,
        "list_mo_post_id":
            list == null ? null : List<int>.from(list.map((x) => x.id)),
        "images":
            image == null ? null : List<dynamic>.from(image.map((x) => x)),
      });
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<SuccessResponse?> deleteBoxUSer({required int userId}) async {
    try {
      var res = await SahaServiceManager().service!.deleteBoxUSer(userId);
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<SuccessResponse?> reCallUser(
      {required int userId, required String messId}) async {
    try {
      var res = await SahaServiceManager().service!.reCallUser(userId, messId);
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }
}

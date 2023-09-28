import 'package:get/get.dart';
import '../../../components/arlert/saha_alert.dart';
import '../../../data/remote/response-request/chat/all_mess_res.dart';
import '../../../data/repository/repository_manager.dart';
import '../../../data/socket/socket.dart';
import '../../../model/motel_post.dart';
import '../../../model/user.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

import '../../data_app_controller.dart';

class ChatDetailController extends GetxController {
  var isDone = false.obs;
  var listMess = RxList<Mess>();
  var user = User().obs;
  var listMessCV = RxList<types.Message>();
  var listMap = RxList<Map>();
  int currentPage = 1;
  String? textSearch;
  bool isEnd = false;
  var isLoading = false.obs;
  var isLoadingInit = true.obs;

  var isSearch = false.obs;

  User toUser;
  var myUser = User();
  var myUserCv = const types.User(id: '');

  DataAppController dataAppController = Get.find();
  MotelPost? motelPost;
  ChatDetailController({required this.toUser, this.motelPost}) {
    myUser = dataAppController.badge.value.user ?? User();
    myUserCv = types.User(id: '${dataAppController.badge.value.user?.id}');
    print('=============>${dataAppController.badge.value.user?.id}');
    socket();
    getAllMess(isRefresh: true);

  }

  Future<void> reCallUser(String messId) async {
    try {
      var data = await RepositoryManager.chatRepository
          .reCallUser(userId: toUser.id!, messId: messId);
      SahaAlert.showSuccess(message: 'Đã thu hồi');
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  void socketClearListen() {
    SocketUser().clearListen();
  }

  void socket() {
    SocketUser().listenUserWithId(
        dataAppController.badge.value.user?.id, toUser.id, (data) {
      var mess = Mess.fromJson(data);

      print(listMessCV.map((e) => e.id).toList());
      if (mess.type == 1) {
        var index = listMessCV.indexWhere((e) => e.id == mess.id);
        print('index $index');
        if (index != -1) {
          listMessCV.removeAt(index);
          isLoadingInit.refresh();
        }
      } else {
        var map = {
          "author": {
            "firstName": dataAppController.badge.value.user?.id == mess.userId
                ? myUser.name ?? ""
                : toUser.name ?? "",
            "id": dataAppController.badge.value.user?.id == mess.userId
                ? "${myUser.id ?? ""}"
                : "${mess.userId ?? ""}",
            "lastName": "",
            "imageUrl": dataAppController.badge.value.user?.id == mess.userId
                ? myUser.avatarImage ?? ""
                : toUser.avatarImage ?? "",
          },
          "createdAt":
              (mess.createdAt ?? DateTime.now()).millisecondsSinceEpoch,
          "id": "${mess.id}",
          "status": "seen",
          "text": "${mess.content ?? ""}️",
          "type": (mess.motelPost ?? []).isNotEmpty
              ? 'custom'
              : mess.images != null
                  ? "image"
                  : "text",
          "height": 1280,
          "size": 585000,
          "width": 1920,
          "name": "madrid",
          "uri": (mess.images ?? []).isNotEmpty ? mess.images![0] : '',
        };

        if ((mess.motelPost ?? []).isNotEmpty) {
          map['metadata'] = mess.motelPost![0].toJson();
          print(List<dynamic>.from(mess.motelPost!.map((x) => x.toJson())));

          var data = {
            'list_room':
                List<dynamic>.from(mess.motelPost!.map((x) => x.toJson()))
          };

          map['metadata'] = data;
        }

        final message = types.Message.fromJson(map);
        print(message.author.id);

        listMessCV.insert(0, message);
        isLoadingInit.refresh();
      }
    });
  }

  Future<bool> sendMessage(
      {String? content,
      String? image,
      String? id,
      List<MotelPost>? list}) async {
    try {
      var res = await RepositoryManager.chatRepository.chatPerson(
        personId: toUser.id!,
        content: content ?? '',
        id: id,
        list: list,
        image: image == null ? null : [image],
      );
      var index = listMessCV.indexWhere((e) => e.id == id);
      if (index != -1) {
        var mess = res!.data!;
        var map = {
          "author": {
            "firstName": dataAppController.badge.value.user?.id == mess.userId
                ? myUser.name ?? ""
                : toUser.name ?? "",
            "id": dataAppController.badge.value.user?.id == mess.userId
                ? "${myUser.id ?? ""}"
                : "${mess.userId ?? ""}",
            "lastName": "",
            "imageUrl": dataAppController.badge.value.user?.id == mess.userId
                ? myUser.avatarImage ?? ""
                : toUser.avatarImage ?? "",
          },
          "createdAt":
              (mess.createdAt ?? DateTime.now()).millisecondsSinceEpoch,
          "id": "${mess.id}",
          "status": "seen",
          "text": "${mess.content ?? ""}️",
          "type": (mess.motelPost ?? []).isNotEmpty
              ? 'custom'
              : mess.images != null
                  ? "image"
                  : "text",
          "height": 1280,
          "size": 585000,
          "width": 1920,
          "name": "madrid",
          "uri": (mess.images ?? []).isNotEmpty ? mess.images![0] : '',
        };

        if ((mess.motelPost ?? []).isNotEmpty) {
          map['metadata'] = mess.motelPost![0].toJson();
          print(List<dynamic>.from(mess.motelPost!.map((x) => x.toJson())));

          var data = {
            'list_room':
                List<dynamic>.from(mess.motelPost!.map((x) => x.toJson()))
          };

          map['metadata'] = data;
        }

        final message = types.Message.fromJson(map);
        listMessCV[index] = message;
        isLoadingInit.refresh();
      }
      return true;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    return false;
  }

  Future<void> getAllMess({
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
            .getAllMess(personId: toUser.id!, page: currentPage);

        user.value = data!.toUser!;
        toUser = user.value;

        if (isRefresh == true) {
          listMess(data.data!.data!);

          listMap(data.data!.data!.map((e) {
            var map = {
              "author": {
                "firstName":
                    e.isSender == true ? myUser.name ?? "" : toUser.name ?? "",
                "id": e.isSender == true
                    ? "${myUser.id ?? ""}"
                    : "${e.vsUser?.id ?? ""}",
                "lastName": "",
                "imageUrl": e.isSender == true
                    ? myUser.avatarImage ?? ""
                    : toUser.avatarImage ?? "",
              },
              "createdAt":
                  (e.createdAt ?? DateTime.now()).millisecondsSinceEpoch,
              "id": "${e.id}",
              "status": "seen",
              "text": "${e.content ?? ""}️",
              "type": (e.motelPost ?? []).isNotEmpty
                  ? 'custom'
                  : e.images != null
                      ? "image"
                      : "text",
              "height": 1280,
              "size": 585000,
              "width": 1920,
              "name": "madrid",
              "uri": (e.images ?? []).isNotEmpty ? e.images![0] : '',
            };

            if ((e.motelPost ?? []).isNotEmpty) {
              map['metadata'] = e.motelPost![0].toJson();
              print(List<dynamic>.from(e.motelPost!.map((x) => x.toJson())));

              var data = {
                'list_room':
                    List<dynamic>.from(e.motelPost!.map((x) => x.toJson()))
              };

              map['metadata'] = data;
            }

            return map;
          }).toList());
          cvMessages();
        } else {
          print('sss');
          listMess.addAll(data.data!.data!);
          listMap.addAll(data.data!.data!.map((e) {
            var map = {
              "author": {
                "firstName": e.isSender == true
                    ? myUser.name ?? ""
                    : e.vsUser?.name ?? "",
                "id": e.isSender == true
                    ? "${myUser.id ?? ""}"
                    : "${e.vsUser?.id ?? ""}",
                "lastName": "",
                "imageUrl": e.isSender == true
                    ? myUser.avatarImage ?? ""
                    : e.vsUser?.avatarImage ?? "",
              },
              "createdAt":
                  (e.createdAt ?? DateTime.now()).millisecondsSinceEpoch,
              "id": "${e.id}",
              "status": "seen",
              "text": "${e.content ?? ""}️",
              "type": (e.motelPost ?? []).isNotEmpty
                  ? 'custom'
                  : e.images != null
                      ? "image"
                      : "text",
              "height": 1280,
              "size": 585000,
              "width": 1920,
              "name": "madrid",
              "uri": (e.images ?? []).isNotEmpty ? e.images![0] : '',
            };
            if ((e.motelPost ?? []).isNotEmpty) {
              print(List<dynamic>.from(e.motelPost!.map((x) => x.toJson())));

              var data = {
                'list_room':
                    List<dynamic>.from(e.motelPost!.map((x) => x.toJson()))
              };
              map['metadata'] = data;
            }
            return map;
          }).toList());
          cvMessages();
        }

        if (currentPage == 1) {
          // if (motelPost != null) {
          //   handleSendMotelPost(list: [motelPost!], isFromPost: true);
          // }
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

  void cvMessages() async {
    final messages = listMap
        .map((e) => types.Message.fromJson(e as Map<String, dynamic>))
        .toList();

    listMessCV(messages);
    isLoadingInit.refresh();
  }

  void _addMessageRoom(List<MotelPost> list, bool? isFromPost) {
    var id = Uuid().v4();
    var map = {
      "author": {
        "firstName": dataAppController.badge.value.user?.name ?? '',
        "id": "${dataAppController.badge.value.user?.id ?? 0}",
        "lastName": "",
        "imageUrl": dataAppController.badge.value.user?.avatarImage ?? '',
      },
      "createdAt": DateTime.now().millisecondsSinceEpoch,
      "id": "${id}",
      "status": "seen",
      "text": "️",
      "type": 'custom',
      "height": 1280,
      "size": 585000,
      "width": 1920,
      "name": "madrid",
      "uri": '',
    };

    if (list.isNotEmpty) {
      print(List<dynamic>.from(list.map((x) => x.toJson())));
      var data = {
        'list_room': List<dynamic>.from(list.map((x) => x.toJson())),
        'from_post': isFromPost ?? false,
      };
      map['metadata'] = data;
    }

    var message = types.Message.fromJson(map as Map<String, dynamic>);
    listMessCV.insert(0, message);

    isLoadingInit.refresh();
  }

  void handleSendMotelPost({required List<MotelPost> list, bool? isFromPost}) {
    var id = const Uuid().v4();
    if (isFromPost != true) {
      sendMessage(list: list, id: id);
    }
    _addMessageRoom(list, isFromPost);
  }
}

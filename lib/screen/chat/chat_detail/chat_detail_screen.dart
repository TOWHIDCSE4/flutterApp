import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:get/get.dart';
import 'package:gohomy/model/motel_post.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:gohomy/utils/call.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import '../../../components/empty/saha_empty_avatar.dart';
import '../../../components/loading/loading_full_screen.dart';
import '../../../components/widget/post_item/post_item_chat.dart';
import '../../../const/type_image.dart';
import '../../../data/repository/repository_manager.dart';
import '../../../model/user.dart';
import '../../chat_custom/src/chat_l10n.dart';
import '../../chat_custom/src/chat_theme.dart';
import '../../chat_custom/src/widgets/chat.dart';
import '../../data_app_controller.dart';
import '../../find_room/room_information/personal_information/personal_information_screen.dart';
import '../choose_room_chat/choose_room_chat_screen.dart';
import 'chat_detail_controller.dart';

class ChatDetailScreen extends StatefulWidget {
  User toUser;
  bool? isBackAll;
  MotelPost? motelPost;
  ChatDetailScreen({required this.toUser, this.isBackAll, this.motelPost});

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  final List<types.Message> _messages = [];
  late ChatDetailController chatDetailController;
  final ScrollController _scrollController = ScrollController();
  DataAppController dataAppController = Get.find();
  bool isFirstMessage = true;

  @override
  void initState() {
    chatDetailController = ChatDetailController(
        toUser: widget.toUser, motelPost: widget.motelPost);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        chatDetailController.getAllMess();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    chatDetailController.socketClearListen();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          appBar: AppBar(
            // leading: widget.isBackAll == true
            //     ? IconButton(
            //         onPressed: () {
            //           Get.back();
            //           Get.back();
            //         },
            //         icon: const Icon(Icons.arrow_back_ios))
            //     : null,
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                    // begin: Alignment.bottomLeft,
                    // end: Alignment.topRight,
                    colors: <Color>[Colors.deepOrange, Colors.orange]),
              ),
            ),
            title: InkWell(
              onTap: () {
                if (chatDetailController.isLoading.value == false) {
                  Get.to(() => PersonalInformationScreen(
                        isHost: chatDetailController.user.value.isHost == false
                            ? false
                            : true,
                        user: chatDetailController.toUser,
                        phoneNumber: chatDetailController.toUser.phoneNumber,
                      ));
                }
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(3000),
                    child: Obx(
                      () => chatDetailController.isLoadingInit.value
                          ? const SizedBox()
                          : CachedNetworkImage(
                              imageUrl:
                                  chatDetailController.user.value.avatarImage ??
                                      '',
                              width: 40,
                              height: 40,
                              fit: BoxFit.cover,
                              // placeholder: (context, url) => const SahaLoadingContainer(
                              //   height: 40,
                              //   width: 30,
                              // ),
                              errorWidget: (context, url, error) =>
                                  const Padding(
                                padding: EdgeInsets.all(3.0),
                                child: SahaEmptyAvata(),
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
                      children: [
                        Obx(
                          () => chatDetailController.isLoadingInit.value
                              ? const SizedBox()
                              : Row(
                                children: [
                                  Text(
                                      chatDetailController.user.value.name ??
                                          "Chưa đặt tên",
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: 'Avenir'),
                                    ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  if(chatDetailController.user.value.cmndNumber != null)
                                    const Icon(Icons.check_circle, color: Colors.blueAccent)
                                ],
                              ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            actions: [
                IconButton(
                    onPressed: () {
                      Call.call(chatDetailController.toUser.phoneNumber ?? '');
                    },
                    icon: const Icon(
                      Icons.call,
                      color: Colors.white,
                    ))
            ],
          ),
          body: Obx(
            () => chatDetailController.isLoadingInit.value
                ? SahaLoadingFullScreen()
                : Chat(
                    hideBackgroundOnEmojiMessages: true,
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    dateLocale: 'vi',
                    l10n: const ChatL10nEn(
                      inputPlaceholder: 'Tin nhắn',
                    ),
                    messages: chatDetailController.listMessCV,
                    scrollController: _scrollController,
                    onAttachmentPressed: _handleAtachmentPressed,
                    onMessageTap: _handleMessageTap,
                    onMessageLongPress: _handleMessageLongPress,
                    onPreviewDataFetched: _handlePreviewDataFetched,
                    onSendPressed: _handleSendPressed,
                    showUserAvatars: true,
                    showUserNames: true,
                    //  bubbleBuilder: _bubbleBuilder,
                    customMessageBuilder: buildCustomMessage,
                    user: chatDetailController.myUserCv,
                    theme: DefaultChatTheme(
                        attachmentButtonIcon: Icon(
                          Icons.add,
                          color: Theme.of(context).primaryColor,
                          size: 30,
                        ),
                        inputTextDecoration: const InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.zero,
                            isCollapsed: true),
                        inputBorderRadius: const BorderRadius.vertical(
                            top: Radius.circular(15)),
                        backgroundColor: Colors.white,
                        inputBackgroundColor: Theme.of(context).primaryColor,
                        inputTextCursorColor: Theme.of(context).primaryColor,
                        inputTextColor: Theme.of(context).primaryColor,
                        primaryColor: Theme.of(context).primaryColor,
                        userNameTextStyle: TextStyle(
                            color: Colors.red,
                            fontSize: 16,
                            fontWeight: FontWeight.w700),
                        userAvatarNameColors: [Colors.red],
                        messageBorderRadius: 10),
                  ),
          ),
        ),
      );

  Widget buildCustomMessage(types.CustomMessage message,
      {required int messageWidth}) {
    print("================================${message.metadata}");

    var listRoom = message.metadata?["list_room"] == null
        ? []
        : List<MotelPost>.from(
            message.metadata!["list_room"]!.map((x) => MotelPost.fromJson(x)));
    var fromPost = message.metadata!['from_post'] ?? false;

    var loading = false.obs;
    // if (fromPost == true && chatDetailController.isDone.value == false) {
    //   chatDetailController
    //       .sendMessage(list: [widget.motelPost!], id: const Uuid().v4());
    // }

    return Container(
      width: messageWidth.toDouble(),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(9.0),
          bottomLeft: Radius.circular(9.0),
          topRight: Radius.circular(9.0),
          bottomRight: Radius.circular(0.0),
        ),
      ),
      child: Container(
        margin: const EdgeInsets.only(left: 2, right: 0, bottom: 5, top: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 3,
                offset: const Offset(0, 3),
              ),
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            ...listRoom.map(
              (e) => PostItemChat(
                post: e,
                width: Get.width,
                isAdmin: false,
              ),
            ),

            // if (fromPost == true && chatDetailController. isDone.value == false)
            //   InkWell(
            //     onTap: () async {
            //       if (chatDetailController.isDone.value == true) return;
            //       loading(true);
            //       var id = const Uuid().v4();
            //       bool data = await chatDetailController
            //           .sendMessage(list: [widget.motelPost!], id: id);
            //       loading(false);
            //       chatDetailController.isDone.value = true;
            //     },
            //     child: Container(
            //       padding:
            //           const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
            //       child: Obx(
            //         () => Row(
            //           mainAxisSize: MainAxisSize.min,
            //           children: [
            //             Text(
            //               chatDetailController.isDone.value ? "Đã gửi" : 'TƯ VẤN CHO TÔI',
            //               style: TextStyle(
            //                   fontWeight: FontWeight.bold,
            //                   fontSize: 16,
            //                   color: chatDetailController.isDone.value
            //                       ? Colors.green
            //                       : Theme.of(context).primaryColor),
            //             ),
            //             SizedBox(
            //               width: 5,
            //             ),
            //             Obx(
            //               () => loading.value
            //                   ? const SizedBox(
            //                       child: CircularProgressIndicator(
            //                         strokeWidth: 2,
            //                       ),
            //                       height: 15.0,
            //                       width: 15.0,
            //                     )
            //                   : Icon(
            //                      chatDetailController. isDone.value
            //                           ? Icons.check
            //                           : Icons.send_rounded,
            //                       color: chatDetailController.isDone.value
            //                           ? Colors.green
            //                           : Theme.of(context).primaryColor,
            //                       size: 18,
            //                     ),
            //             )
            //           ],
            //         ),
            //       ),
            //     ),
            //   )
          ],
        ),
      ),
    );
  }

  void _addMessage(types.Message message) {
    chatDetailController.listMessCV.insert(0, message);
    chatDetailController.isLoadingInit.refresh();
  }

  void _handleAtachmentPressed() {
    showModalBottomSheet<void>(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.0),
          topRight: Radius.circular(10.0),
        ),
      ),
      builder: (BuildContext context) => SafeArea(
        child: Container(
          height: 200,
          padding: EdgeInsets.only(left: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  _handleImageSelectionCamera();
                },
                child: const Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(
                    'Máy ảnh',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  _handleImageSelection();
                },
                child: const Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(
                    'Thư viện ảnh',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
              if (Get.find<DataAppController>().currentUser.value.isHost ==
                  true)
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Get.to(() => ChooseRoomChatScreen(
                          onChoose: (List<MotelPost> list) {
                            chatDetailController.handleSendMotelPost(
                                list: list);
                            Get.back();
                          },
                        ));
                  },
                  child: const Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Text(
                      'Chọn phòng',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(
                    'Đóng',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleImageSelection() async {
    var id = const Uuid().v4();
    final result = await ImagePicker().pickImage(
      imageQuality: 70,
      maxWidth: 1440,
      source: ImageSource.gallery,
    );
    if (result != null) {}

    if (result != null) {
      var file = File(result.path);
      var type = ANOTHER_FILES_FOLDER;
      var link = await RepositoryManager.imageRepository
          .uploadImage(image: file, type: type);

      if (link != null) {
        chatDetailController.sendMessage(content: '', image: link, id: id);
      }

      final bytes = await result.readAsBytes();
      final image = await decodeImageFromList(bytes);

      final message = types.ImageMessage(
        author: chatDetailController.myUserCv,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        height: image.height.toDouble(),
        id: id,
        name: result.name,
        size: bytes.length,
        uri: result.path,
        width: image.width.toDouble(),
      );

      _addMessage(message);
    }
  }

  void _handleImageSelectionCamera() async {
    var id = const Uuid().v4();
    final result = await ImagePicker().pickImage(
      imageQuality: 70,
      maxWidth: 1440,
      source: ImageSource.camera,
    );
    if (result != null) {}

    if (result != null) {
      var file = File(result.path);
      var type = ANOTHER_FILES_FOLDER;
      var link = await RepositoryManager.imageRepository
          .uploadImage(image: file, type: type);

      if (link != null) {
        chatDetailController.sendMessage(content: '', image: link, id: id);
      }

      final bytes = await result.readAsBytes();
      final image = await decodeImageFromList(bytes);

      final message = types.ImageMessage(
        author: chatDetailController.myUserCv,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        height: image.height.toDouble(),
        id: id,
        name: result.name,
        size: bytes.length,
        uri: result.path,
        width: image.width.toDouble(),
      );

      _addMessage(message);
    }
  }

  void _handleMessageLongPress(BuildContext _, types.Message message) async {
    if (message is types.FileMessage) {
      var localPath = message.uri;

      if (message.uri.startsWith('http')) {
        try {
          final index =
              _messages.indexWhere((element) => element.id == message.id);
          final updatedMessage =
              (_messages[index] as types.FileMessage).copyWith(
            isLoading: true,
          );

          setState(() {
            _messages[index] = updatedMessage;
          });

          final client = http.Client();
          final request = await client.get(Uri.parse(message.uri));
          final bytes = request.bodyBytes;
          final documentsDir = (await getApplicationDocumentsDirectory()).path;
          localPath = '$documentsDir/${message.name}';

          if (!File(localPath).existsSync()) {
            final file = File(localPath);
            await file.writeAsBytes(bytes);
          }
        } finally {
          final index =
              _messages.indexWhere((element) => element.id == message.id);
          final updatedMessage =
              (_messages[index] as types.FileMessage).copyWith(
            isLoading: null,
          );

          setState(() {
            _messages[index] = updatedMessage;
          });
        }
      }

      //await OpenFile.open(localPath);
    }
    // SahaDialogApp.showDialogRemoveMess(onChoose: () {
    //   chatDetailController.listMessCV.removeWhere((e) => e.id == message.id);
    //   chatDetailController.isLoadingInit.refresh();
    //   chatDetailController.reCallUser(message.id);
    //   print('${message.id}');
    // });
  }

  void _handleMessageTap(BuildContext _, types.Message message) async {
    if (message is types.FileMessage) {
      var localPath = message.uri;

      if (message.uri.startsWith('http')) {
        try {
          final index =
              _messages.indexWhere((element) => element.id == message.id);
          final updatedMessage =
              (_messages[index] as types.FileMessage).copyWith(
            isLoading: true,
          );

          setState(() {
            _messages[index] = updatedMessage;
          });

          final client = http.Client();
          final request = await client.get(Uri.parse(message.uri));
          final bytes = request.bodyBytes;
          final documentsDir = (await getApplicationDocumentsDirectory()).path;
          localPath = '$documentsDir/${message.name}';

          if (!File(localPath).existsSync()) {
            final file = File(localPath);
            await file.writeAsBytes(bytes);
          }
        } finally {
          final index =
              _messages.indexWhere((element) => element.id == message.id);
          final updatedMessage =
              (_messages[index] as types.FileMessage).copyWith(
            isLoading: null,
          );

          setState(() {
            _messages[index] = updatedMessage;
          });
        }
      }

      //await OpenFile.open(localPath);
    }
  }

  void _handlePreviewDataFetched(
    types.TextMessage message,
    types.PreviewData previewData,
  ) {
    final index = _messages.indexWhere((element) => element.id == message.id);
    final updatedMessage = (_messages[index] as types.TextMessage).copyWith(
      previewData: previewData,
    );

    setState(() {
      _messages[index] = updatedMessage;
    });
  }

  void _handleSendPressed(types.PartialText message) {
    var id = const Uuid().v4();

    final textMessage = types.TextMessage(
      author: chatDetailController.myUserCv,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: id,
      text: message.text,
    );
    if (widget.motelPost != null && isFirstMessage == true) {
      chatDetailController
          .handleSendMotelPost(list: [widget.motelPost!], isFromPost: true);
         
      chatDetailController
          .sendMessage(list: [widget.motelPost!], id: const Uuid().v4());
    }
     Future.delayed(const Duration(milliseconds: 500),(){
                chatDetailController.sendMessage(content: message.text, id: id);
          });


    isFirstMessage = false;

    _addMessage(textMessage);
  }
}

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_compress/video_compress.dart';
import 'package:video_player/video_player.dart';

import '../../../main.dart';
import '../../../screen/owner/post_management/add_update_post_management/add_update_post_management_controller.dart';
import '../../arlert/saha_alert.dart';
import '../../loading/loading_widget.dart';
import '../../../data/repository/repository_manager.dart';
import 'package:flutter/material.dart';

class VideoPickerSingle extends StatefulWidget {
  final Function? onChange;
  final Function? dispose;
  String? linkVideo;
  final String? title;
  final double? width;
  final double? height;
  final bool? isWatch;

  VideoPickerSingle(
      {Key? key,
      this.onChange,
      this.linkVideo,
      this.title,
      this.dispose,
      this.width,
      this.isWatch,
      this.height})
      : super(key: key);

  @override
  State<VideoPickerSingle> createState() => _VideoPickerSingleState();
}

class _VideoPickerSingleState extends State<VideoPickerSingle> with RouteAware {
  VideoPickerSingleController videoPickerSingleController =
      VideoPickerSingleController();

  VideoPlayerController? controllerPicker;

  VideoPlayerController? controllerInit;

  late Subscription subscription;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

   @override
  void didUpdateWidget(VideoPickerSingle oldWidget) {
    super.didUpdateWidget(oldWidget);

   initVideo();
  }

  @override
  void didPushNext() {
    print("abc");

    subscription.unsubscribe();
  }

 

  @override
  void initState() {
    print(widget.linkVideo);

    subscription = VideoCompress.compressProgress$.subscribe((progress) {
      videoPickerSingleController.process.value = progress;
    });
    initVideo();
    super.initState();
  }

  Future<void> initVideo() async {
    if (widget.linkVideo != null) {
      try {
        controllerInit = VideoPlayerController.network(
          widget.linkVideo ?? '',
          videoPlayerOptions: VideoPlayerOptions(mixWithOthers: false),
        );

        await controllerInit!.initialize();

        controllerInit!.setLooping(true);

        setState(() {});
      } catch (e) {
        print("============>${e.toString()}");
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    print('dispose controller init');
    if (controllerInit != null) {
      controllerInit!.dispose();
    }
    if (controllerPicker != null) {
      print('dispose controller picker');
      controllerPicker!.dispose();
    }
    print('unsubcrible');
    subscription.unsubscribe();
  }

  @override
  Widget build(BuildContext context) {
   
   print("abcddssseer");
    return Obx(() {
      var deviceVideo = videoPickerSingleController.pathVideo;
      if (deviceVideo.value == "") {
        return addVideo();
      }
      return buildItemAsset(File(deviceVideo.value));
    });
  }

  Widget addVideo() {
    //initVideo();

    return videoPickerSingleController.isLoadingAdd.value
        ? SahaLoadingWidget()
        : Align(
            alignment: Alignment.center,
            child: InkWell(
              onTap: () {
                videoPickerSingleController.getVideo(onOK: (link) {
                  widget.onChange!(link);
                }, onPlayVideo: (file) {
                  playVideoPicker(file);
                });
              },
              child: Obx(
                () => Container(
                  height: widget.height,
                  width: widget.width,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      border: Border.all(
                        color: !(videoPickerSingleController.isRemove.value ==
                                    true &&
                                widget.linkVideo != null)
                            ? Theme.of(Get.context!).primaryColor
                            : Colors.transparent,
                      )),
                  child: videoPickerSingleController.isRemove.value == true &&
                          widget.linkVideo != null
                      ? AspectRatio(
                          aspectRatio: controllerInit!.value.aspectRatio,
                          child: Stack(
                            alignment: Alignment.bottomCenter,
                            clipBehavior: Clip.none,
                            children: <Widget>[
                              VideoPlayer(controllerInit!),
                              ControlsOverlay(
                                  controller: controllerInit!,
                                  reload: (v) {
                                    setState(() {});
                                  }),
                              VideoProgressIndicator(controllerInit!,
                                  allowScrubbing: true),
                              if (widget.isWatch != true)
                                Positioned(
                                  top: -10,
                                  right: -10,
                                  child: InkWell(
                                    onTap: () {
                                      videoPickerSingleController
                                          .isRemove.value = false;
                                      widget.onChange!(null);
                                      controllerInit?.pause();
                                    },
                                    child: Container(
                                      height: 30,
                                      width: 30,
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            width: 1, color: Colors.white),
                                      ),
                                      child: const Center(
                                        child: Text(
                                          "x",
                                          style: TextStyle(
                                            fontSize: 13,
                                            height: 1,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                            ],
                          ),
                        )
                      : Obx(
                          () => Container(
                            padding: const EdgeInsets.all(10),
                            child: Center(
                              child: (videoPickerSingleController
                                              .process.value <
                                          100 &&
                                      videoPickerSingleController
                                              .process.value >
                                          0)
                                  ? Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        CircularProgressIndicator(
                                          value: videoPickerSingleController
                                                  .process.value /
                                              100,
                                          semanticsLabel: 'Đang chuẩn bị video',
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          'Đang chuẩn bị video',
                                          style: TextStyle(
                                            color: Theme.of(Get.context!)
                                                .primaryColor,
                                          ),
                                        ),
                                      ],
                                    )
                                  : Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.videocam_rounded,
                                          color: Theme.of(Get.context!)
                                              .primaryColor,
                                          size: 50,
                                        ),
                                        Text(
                                          widget.title ?? 'Video',
                                          style: TextStyle(
                                            color: Theme.of(Get.context!)
                                                .primaryColor,
                                          ),
                                        ),
                                      ],
                                    ),
                            ),
                          ),
                        ),
                ),
              ),
            ),
          );
  }

  Widget buildItemAsset(File asset) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          border: Border.all(color: Colors.grey)),
      child: SizedBox(
        child: Stack(
          alignment: Alignment.bottomLeft,
          clipBehavior: Clip.none,
          children: [
            SizedBox(
              height: widget.height,
              width: widget.width,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(7.0),
                  child: previewVideo()),
            ),
            Positioned(
              top: -10,
              right: -10,
              child: InkWell(
                onTap: () {
                  videoPickerSingleController.removeVideo();
                  widget.onChange!(null);
                  controllerPicker?.pause();
                },
                child: Container(
                  height: 25,
                  width: 25,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                    border: Border.all(width: 1, color: Colors.white),
                  ),
                  child: const Center(
                    child: Text(
                      "x",
                      style: TextStyle(
                        fontSize: 13,
                        height: 1,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget previewVideo() {
    return AspectRatioVideo(controllerPicker);
  }

  Future<void> playVideoPicker(
    XFile? file,
  ) async {
    if (file != null) {
      if (controllerPicker != null) {
        print("remove controller picker ========");
        await controllerPicker!.dispose();
      }

      if (controllerInit != null) {
        print("remove controller init ========");
        await controllerInit!.dispose();
      }

      late VideoPlayerController controller;

      controller = VideoPlayerController.file(File(file.path));

      controllerPicker = controller;
      const double volume = 1.0;
      await controller.setVolume(volume);
      await controller.initialize();
      await controller.setLooping(true);
      await controller.play();
    }
  }
}

class VideoPickerSingleController extends GetxController {
  var pathVideo = "".obs;
  var process = 0.0.obs;
  final picker = ImagePicker();
  var isLoadingAdd = false.obs;
  var isRefresh = false;
  var isRemove = true.obs;

  Future getVideo({
    Function? onOK,
    Function? onError,
    required Function onPlayVideo,
  }) async {
    final pickedFile = await picker.pickVideo(
      source: ImageSource.gallery,
      maxDuration: const Duration(minutes: 1),
    );
    if (pickedFile != null) {
      MediaInfo? mediaInfo = await VideoCompress.compressVideo(
        pickedFile.path,
        quality: VideoQuality.MediumQuality,
        deleteOrigin: false,
      );
      pathVideo.value = pickedFile.path;
      onPlayVideo(pickedFile);
      // var link = await upVideo(mediaInfo?.file);
      onOK!(mediaInfo?.file);
    }
  }

  void removeVideo() {
    process.value = 0;
    pathVideo("");

    // Get.find<AddUpdatePostManagementController>()
    //     .motelPostRequest
    //     .value
    //     .linkVideo = '';
  }

  Future<String?> upVideo(File? file, String type) async {
    isLoadingAdd.value = true;
    try {
      var link = await RepositoryManager.imageRepository
          .uploadVideo(video: file, type: type);
      isLoadingAdd.value = false;
      return link;
    } catch (err) {
      isLoadingAdd.value = false;
      SahaAlert.showError(message: err.toString());
    }
    return null;
  }
}

class AspectRatioVideo extends StatefulWidget {
  const AspectRatioVideo(this.controller, {Key? key}) : super(key: key);

  final VideoPlayerController? controller;

  @override
  AspectRatioVideoState createState() => AspectRatioVideoState();
}

class AspectRatioVideoState extends State<AspectRatioVideo> {
  VideoPlayerController? get controller => widget.controller;
  bool initialized = false;

  void _onVideoControllerUpdate() {
    if (!mounted) {
      return;
    }
    if (initialized != controller!.value.isInitialized) {
      initialized = controller!.value.isInitialized;
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    controller!.addListener(_onVideoControllerUpdate);
  }

  @override
  void dispose() {
    controller!.removeListener(_onVideoControllerUpdate);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (initialized) {
      return Center(
        child: AspectRatio(
          aspectRatio: controller!.value.aspectRatio,
          child: VideoPlayer(controller!),
        ),
      );
    } else {
      return Container();
    }
  }
}

class ControlsOverlay extends StatelessWidget {
  const ControlsOverlay(
      {Key? key, required this.controller, required this.reload})
      : super(key: key);

  final VideoPlayerController controller;
  final Function reload;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 50),
          reverseDuration: const Duration(milliseconds: 200),
          child: controller.value.isPlaying
              ? const SizedBox.shrink()
              : Container(
                  color: Colors.black26,
                  child: const Center(
                    child: Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                      size: 100.0,
                      semanticLabel: 'Play',
                    ),
                  ),
                ),
        ),
        GestureDetector(
          onTap: () {
            controller.value.isPlaying ? controller.pause() : controller.play();
            reload(controller.value.isPlaying);
          },
        ),
      ],
    );
  }
}

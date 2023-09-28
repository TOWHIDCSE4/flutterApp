import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:video_player/video_player.dart';

import '../../arlert/saha_alert.dart';
import '../../empty/saha_empty_image.dart';
import '../video_picker_single/video_picker_single.dart';

class ShowImage {
  static void seeImage({
    List<dynamic>? listImageUrl,
    int? index,
  }) {
    PageController pageController = PageController(initialPage: index!);
    showModalBottomSheet<void>(
      isScrollControlled: true,
      context: Get.context!,
      builder: (BuildContext context) {
        return Stack(
          children: [
            InkWell(
              onLongPress: () async {
                showModalBottomSheet(
                    context: Get.context!,
                    backgroundColor: Colors.white,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15.0),
                          topRight: Radius.circular(15.0)),
                    ),
                    builder: (context) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          ListTile(
                            leading: const Icon(
                              Icons.download,
                              color: Colors.blue,
                            ),
                            title: const Text(
                              'Tải ảnh',
                            ),
                            onTap: () {
                              String path = listImageUrl![index];
                              print(path);
                              GallerySaver.saveImage(path)
                                  .then((bool? success) {
                                if (success == true) {
                                  SahaAlert.showSuccess(message: "Đã lưu");
                                  Get.back();
                                }
                              });
                            },
                          ),
                          ListTile(
                            leading: const Icon(
                              Icons.download,
                              color: Colors.blue,
                            ),
                            title: const Text(
                              'Tải toàn bộ ảnh',
                            ),
                            onTap: () async {
                              for (var e in listImageUrl!)  {
                                String path = e;
                                await GallerySaver.saveImage(path)
                                    .then((bool? success) {});
                              }
                              SahaAlert.showSuccess(message: "Đã lưu");
                              Get.back();
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      );
                    });
              },
              child: PhotoViewGallery.builder(
                scrollPhysics: const BouncingScrollPhysics(),
                pageController: pageController,
                builder: (BuildContext context, int index) {
                  return PhotoViewGalleryPageOptions(
                    minScale: 0.0,
                    imageProvider: NetworkImage(listImageUrl![index] ?? ""),
                    initialScale: PhotoViewComputedScale.contained * 1,
                    heroAttributes: PhotoViewHeroAttributes(
                        tag: listImageUrl[index] ?? "error$index"),
                  );
                },
                itemCount: listImageUrl!.length,
                loadingBuilder: (context, event) => const Center(
                  child: SizedBox(
                    width: 20.0,
                    height: 20.0,
                    child: CupertinoActivityIndicator(),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 60,
              right: 20,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black.withOpacity(0.5),
                ),
                child: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    Get.back();
                  },
                  color: Colors.white,
                ),
              ),
            )
          ],
        );
      },
    );
  }

  static void seeImageWithVideo({
    List<String>? listImageUrl,
    String? linkVideo,
    int? index,
    Duration? durationInitVideo,
  }) {
    showModalBottomSheet<void>(
      isScrollControlled: true,
      context: Get.context!,
      builder: (BuildContext context) {
        return PageViewVideoImage(
          linkVideo: linkVideo,
          listImageUrl: listImageUrl,
          index: index,
          durationInitVideo: durationInitVideo,
        );
      },
    );
  }
}

class PageViewVideoImage extends StatefulWidget {
  PageViewVideoImage(
      {Key? key,
      this.listImageUrl,
      this.linkVideo,
      this.index,
      this.durationInitVideo})
      : super(key: key);
  List<String>? listImageUrl;
  String? linkVideo;
  int? index;
  Duration? durationInitVideo;
  @override
  State<PageViewVideoImage> createState() => _PageViewVideoImageState();
}

class _PageViewVideoImageState extends State<PageViewVideoImage> {
  VideoPlayerController? controllerInit;
  late PageController pageController;

  @override
  void initState() {
    print(widget.linkVideo);
    pageController = PageController(initialPage: widget.index ?? 0);
    initVideo();
    super.initState();
  }

  Future<void> initVideo() async {
    if (widget.linkVideo != null) {
      print(widget.linkVideo);
      controllerInit = VideoPlayerController.network(
        widget.linkVideo ?? "",
        videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
      );
      controllerInit!.setLooping(true);
      await controllerInit!.initialize();
      if (widget.durationInitVideo != null) {
        controllerInit!.seekTo(widget.durationInitVideo!);
      }

      controllerInit!.play();
      setState(() {});
    }
  }

  @override
  void dispose() {
    super.dispose();
    print('dispose controller init');
    if (controllerInit != null) {
      controllerInit!.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            onPageChanged: (v){
              controllerInit?.pause();
            },
            controller: pageController,
            children: [
              SizedBox.expand(
                child: FittedBox(
                  fit: BoxFit.fitWidth,
                  child: SizedBox(
                      width: controllerInit?.value.size.width ?? 0,
                      height: controllerInit?.value.size.height ?? 0,
                      child:  Stack(
                        alignment: Alignment.bottomCenter,
                        children: <Widget>[

                          VideoPlayer(controllerInit!),
                          ControlsOverlay(
                              controller: controllerInit!,
                              reload: (v) {
                                print(v);
                                setState(() {});
                              }),
                          VideoProgressIndicator(controllerInit!, allowScrubbing: true),
                        ],
                      ),
                  ),
                ),
              ),

              ...(widget.listImageUrl ?? [])
                  .map(
                    (e) => InteractiveViewer(
                      minScale: 1,
                      maxScale: 1.6,
                      child: CachedNetworkImage(
                        height: double.infinity,
                        width: double.infinity,
                        fit: BoxFit.fitWidth,
                        imageUrl: e,
                        //placeholder: (context, url) => const SahaLoadingContainer(),
                        errorWidget: (context, url, error) => const SahaEmptyImage(),
                      ),
                    ),
                  )
                  .toList(),
            ],
          ),
          Positioned(
            top: 50,
            right: 10,
            child: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black54,
                ),
                child: IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(
                      Icons.clear,
                      color: Colors.white,
                    ))),
          ),
        ],
      ),
    );
  }
}

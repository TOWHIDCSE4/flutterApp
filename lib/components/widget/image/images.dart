import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gohomy/components/widget/image/show_image.dart';
import 'package:video_player/video_player.dart';

import '../../../main.dart';
import '../../empty/saha_empty_avatar.dart';
import '../../empty/saha_empty_image.dart';
import '../../loading/loading_container.dart';
import '../../loading/loading_widget.dart';

class RoomImage extends StatefulWidget {
  RoomImage({Key? key, this.listImageUrl, this.linkVideo}) : super(key: key);
  List<String>? listImageUrl;
  String? linkVideo;
  VideoPlayerController? controllerInit;
  var init = true;
  PageController pageController = PageController();

  @override
  State<RoomImage> createState() => _RoomImageState();
}

class _RoomImageState extends State<RoomImage> with RouteAware{

   @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPushNext() {
    print("abc");
    widget.controllerInit?.pause();
   
  }
 

  @override
  void didUpdateWidget(RoomImage oldWidget) {
    super.didUpdateWidget(oldWidget);
    oldWidget.controllerInit?.pause();
    imageIndex.value = 0;
    widget.pageController = PageController(keepPage: false);
   

    if (widget.linkVideo != null) {
      initVideo();
    }
  }

  var imageIndex = 0.obs;
  @override
  void initState() {
    print('=======>>> ${widget.listImageUrl}');
    print(widget.linkVideo);
    initVideo();
    super.initState();
  }

  Future<void> initVideo() async {
    if (widget.linkVideo != null) {
      print(widget.linkVideo);
      widget.controllerInit = VideoPlayerController.network(
        widget.linkVideo ?? "",
        videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
      );
      widget.controllerInit!.setLooping(true);

      await widget.controllerInit!.initialize();
      await widget.controllerInit!.play();
      setState(() {});
    }
  }

  @override
  void dispose() {
    super.dispose();
    print('dispose controller init');
    if (widget.controllerInit != null) {
      widget.controllerInit!.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.linkVideo == null) {
      return Obx(
        () => SizedBox(
          height: Get.height / 2.2,
          width: Get.width,
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: InkWell(
                      onTap: () {
                        ShowImage.seeImage(
                            listImageUrl: (widget.listImageUrl ?? []).toList(),
                            index: imageIndex.value);
                      },
                      child:

                          // PageView.builder(
                          //   onPageChanged: (index) {
                          //     imageIndex.value = index;
                          //   },
                          //   itemBuilder: (BuildContext context, int index) {
                          //     // Trả về widget tương ứng với mỗi index
                          //     return IndexedStack(
                          //       index: imageIndex.value,
                          //       children: [
                          //         ...(widget.listImageUrl ?? [])
                          //             .map((e) => Image.network(
                          //                   e,
                          //                   height: double.infinity,
                          //                   width: double.infinity,
                          //                   fit: BoxFit.cover,
                          //                   errorBuilder:
                          //                       (context, error, stackTrace) {
                          //                     return const SahaEmptyImage();
                          //                   },
                          //                 ))
                          //       ],
                          //     );
                          //   },
                          // ),

                          PageView(
                        controller: widget.pageController,
                        onPageChanged: (index) {
                          imageIndex.value = index;
                        },
                        children: [
                          ...(widget.listImageUrl ?? [])
                              .map((e) => Image.network(
                                    e,
                                    height: double.infinity,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return const SahaEmptyImage();
                                    },
                                  ))
                        ],
                      )
                      // CachedNetworkImage(
                      //   height: double.infinity,
                      //   width: double.infinity,
                      //   fit: BoxFit.cover,
                      //   imageUrl: widget.listImageUrl![imageIndex.value],
                      //  placeholder: (context, url) => const SahaLoadingContainer(),
                      //   errorWidget: (context, url, error) => const SahaEmptyImage(),
                      // ),
                      ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        ...(widget.listImageUrl ?? []).map((e) =>
                            images(e, (widget.listImageUrl ?? []).indexOf(e)))
                      ],
                    )),
              )
            ],
          ),
        ),
      );
    } else {
     
      return SizedBox(
          height: Get.height / 3,
          child: Stack(
            alignment: Alignment.center,
            children: [
              PageView(
                controller: widget.pageController,
                onPageChanged: (index) {
                  imageIndex.value = index;
                  widget.controllerInit?.pause();
                },
                children: [
                  InkWell(
                    onTap: () {
                      widget.controllerInit!.pause();
                      ShowImage.seeImageWithVideo(
                          listImageUrl: (widget.listImageUrl ?? []).toList(),
                          linkVideo: widget.linkVideo,
                          durationInitVideo: widget.controllerInit?.value.position,
                          index: 0);
                    },
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: <Widget>[
                        SizedBox.expand(
                          child: FittedBox(
                            fit: BoxFit.fitHeight,
                            child: SizedBox(
                              width: widget.controllerInit?.value.size.width ?? 0,
                              height: widget.controllerInit?.value.size.height ?? 0,
                              child: VideoPlayer(widget.controllerInit!),
                            ),
                          ),
                        ),
                        // ControlsOverlay(
                        //     controller: controllerInit!,
                        //     reload: (v) {
                        //       print(v);
                        //       setState(() {});
                        //     }),
                        VideoProgressIndicator(widget.controllerInit!,
                            allowScrubbing: true),
                      ],
                    ),
                  ),
                  ...(widget.listImageUrl ?? []).map((e) => InkWell(
                    onTap: (){
                     ShowImage.seeImageWithVideo(
                      listImageUrl: (widget.listImageUrl ?? []).toList(),
                      linkVideo: widget.linkVideo,
                      index: imageIndex.value);
                    },
                    child: Image.network(
                          e,
                          height: double.infinity,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const SahaEmptyImage();
                          },
                        ),
                  ))
                ],
              ),
              Positioned(
                bottom: 5,
                child: Row(
                  children: [
                    itemCircle(0),
                    ...(widget.listImageUrl ?? []).map((e) => itemCircle((widget.listImageUrl ?? []).indexOf(e) + 1))
                  ],
                ),
              )
            ],
          )

          // Swiper(
          //   controller: SwiperController(),
          //   allowImplicitScrolling: true,
          //   onIndexChanged: (v) {
          //     widget.init = false;
          //     widget.controllerInit?.pause();
          //     print("=========>$v");
          //   },
          //   index: 0,
          //   itemBuilder: (BuildContext context, int index) {
          //     index = index != 0 && widget.init == true ? 0 : index;
          //     print("index : $index");
          //     print(widget.init);

          //     if (index == 0) {
          //       return
          // InkWell(
          //         onTap: () {
          //           widget.controllerInit!.pause();
          //           ShowImage.seeImageWithVideo(
          //               listImageUrl: (widget.listImageUrl ?? []).toList(),
          //               linkVideo: widget.linkVideo,
          //               durationInitVideo: widget.controllerInit?.value.position,
          //               index: 0);
          //         },
          //         child: Stack(
          //           alignment: Alignment.bottomCenter,
          //           children: <Widget>[
          //             SizedBox.expand(
          //               child: FittedBox(
          //                 fit: BoxFit.fitHeight,
          //                 child: SizedBox(
          //                   width: widget.controllerInit?.value.size.width ?? 0,
          //                   height: widget.controllerInit?.value.size.height ?? 0,
          //                   child: VideoPlayer(widget.controllerInit!),
          //                 ),
          //               ),
          //             ),
          //             // ControlsOverlay(
          //             //     controller: controllerInit!,
          //             //     reload: (v) {
          //             //       print(v);
          //             //       setState(() {});
          //             //     }),
          //             VideoProgressIndicator(widget.controllerInit!,
          //                 allowScrubbing: true),
          //           ],
          //         ),
          //       );
          //     }
          //     return InkWell(
          //       onTap: () {
          //         ShowImage.seeImageWithVideo(
          //             listImageUrl: (widget.listImageUrl ?? []).toList(),
          //             linkVideo: widget.linkVideo,
          //             index: index);
          //       },
          //       child: CachedNetworkImage(
          //         fit: BoxFit.cover,
          //         imageUrl: (widget.listImageUrl ?? [])[index - 1],
          //         // placeholder: (context, url) => SahaLoadingWidget(),
          //         errorWidget: (context, url, error) => const SahaEmptyAvata(),
          //       ),
          //     );
          //   },
          //   itemCount: (widget.listImageUrl ?? []).length + 1,
          //   pagination: SwiperPagination(),
          // ),
          );
    }
  }

  Widget images(String imageUrl, int index) {
    return Container(
      decoration: BoxDecoration(
          border: index == imageIndex.value
              ? Border.all(color: Theme.of(context).primaryColor)
              : null),
      height: 100,
      width: 100,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(4, 4, 4, 4),
        child: InkWell(
          onTap: () {
            imageIndex.value = index;

            widget.pageController.animateToPage(index,
                duration: const Duration(milliseconds: 500),
                curve: Curves.ease);
          },
          child: CachedNetworkImage(
            height: double.infinity,
            width: double.infinity,
            fit: BoxFit.cover,
            imageUrl: imageUrl,
            placeholder: (context, url) => const SahaLoadingContainer(),
            errorWidget: (context, url, error) => const SahaEmptyImage(),
          ),
        ),
      ),
    );
  }

  Widget itemCircle(int index){
    return Obx(()=> Padding(
      padding: const EdgeInsets.only(left: 2,right: 2),
      child: Icon(Icons.circle,color: index == imageIndex.value ? Colors.deepOrange : Colors.grey,size: 10,),
    ));
  }
}

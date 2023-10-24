import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gohomy/screen/profile/help_post/help_post_details/help_post_details_controller.dart';
import 'package:intl/intl.dart';

import '../../../../components/empty/saha_empty_image.dart';
import '../../../../components/loading/loading_full_screen.dart';
import '../../../../components/loading/loading_widget.dart';

class HelpPostDetailsScreen extends StatefulWidget {
  HelpPostDetailsScreen({Key? key, required this.id}) : super(key: key);
  int id;
  @override
  State<HelpPostDetailsScreen> createState() => _HelpPostDetailsScreenState();
}

class _HelpPostDetailsScreenState extends State<HelpPostDetailsScreen> {
  HelpPostDetailsController helpPostDetailsController =
      HelpPostDetailsController();
  @override
  void initState() {
    super.initState();
    helpPostDetailsController.getOneHelpPost(id: widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chi tiết bài đăng'),
      ),
      body: Obx(
        () => helpPostDetailsController.loadInit.value
            ? SahaLoadingFullScreen()
            : Padding(
                padding: const EdgeInsets.all(4.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(5.0),
                      child: CachedNetworkImage(
                        height: Get.height / 3,
                        width: Get.width,
                        fit: BoxFit.cover,
                        imageUrl: helpPostDetailsController
                                .helpPost.value.helpPost?.imageUrl ??
                            '',
                        //placeholder: (context, url) => SahaLoadingWidget(),
                        errorWidget: (context, url, error) => const SahaEmptyImage(),
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 4),
                      child: Text(
                          'Bài đăng ngày ${DateFormat('dd-MM-yyyy').format(helpPostDetailsController.helpPost.value.createdAt ?? DateTime.now())}'),
                    ),
                    Text(
                      helpPostDetailsController
                              .helpPost.value.helpPost?.title ??
                          '',
                      style:
                          const TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
                    ),
                    Text(
                      helpPostDetailsController
                              .helpPost.value.categoryHelpPost?.title ??
                          '',
                      style:
                          const TextStyle(fontSize: 20, fontWeight: FontWeight.w200),
                    ),
                    SizedBox(
                      width: Get.width,
                      child: Text(helpPostDetailsController
                              .helpPost.value.helpPost?.content ??
                          ''),
                    )
                  ],
                ),
              ),
      ),
    );
  }
}

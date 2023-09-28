import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:gohomy/components/loading/loading_widget.dart';

import '../../../components/widget/post_item/post_item.dart';
import '../../../model/motel_post.dart';
import '../../data_app_controller.dart';
import 'find_location_controller.dart';

class FindLocationScreen extends StatelessWidget {
  FindLocationController findLocationController = FindLocationController();
  DataAppController dataAppController = Get.find();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.2,
        iconTheme: IconThemeData(
          color: Theme.of(context).primaryColor,
        ),
        title: Row(
          children: [
            Icon(
              Icons.location_on_rounded,
              color: Theme.of(context).primaryColor,
            ),
            const SizedBox(
              width: 5,
            ),
            Expanded(
              child: Obx(
                () => Text(
                  findLocationController.address.value,
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: Obx(
        () => findLocationController.loading.value
            ? Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SahaLoadingWidget(
                      size: 50,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Đang tìm vị trí của bạn',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ],
                ),
              )
            : findLocationController.listAllRoomPost.isEmpty
                ? Center(
                    child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        'assets/icon/overbooked.svg',
                        height: 100,
                        width: 100,
                        color: Theme.of(context).primaryColor,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Không có phòng nào gần bạn',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ],
                  ))
                : ListView.builder(
                    addAutomaticKeepAlives: false,
                    addRepaintBoundaries: false,
                    itemCount:
                        (findLocationController.listAllRoomPost.length / 2)
                            .ceil(),
                    itemBuilder: (BuildContext context, int index) {
                      var length =
                          findLocationController.listAllRoomPost.length;
                      var index1 = index * 2;

                      return itemRoom(
                          motelPost1:
                              findLocationController.listAllRoomPost[index1],
                          motelPost2: length <= (index1 + 1)
                              ? null
                              : findLocationController
                                  .listAllRoomPost[index1 + 1]);
                    }),
      ),
    );
  }

  Widget itemRoom({
    required MotelPost motelPost1,
    required MotelPost? motelPost2,
  }) {


    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Row(
        children: [
           PostItem(
            post: motelPost1,

          ),
          if (motelPost2 != null)
               PostItem(
              post: motelPost2,

            ),
        ],
      ),
    );
  }
}

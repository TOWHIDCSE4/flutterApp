import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gohomy/components/widget/image/show_image.dart';

import '../../empty/saha_empty_image.dart';
import '../../loading/loading_container.dart';

class ProductImage extends StatelessWidget {
  ProductImage({super.key, this.listImageUrl});

  final List<String>? listImageUrl;
  var imageIndex = 0.obs;
  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
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
                          listImageUrl: (listImageUrl ?? []).toList(),
                          index: imageIndex.value);
                    },
                    child: PageView(
                      controller: pageController,
                      onPageChanged: (index) {
                        imageIndex.value = index;
                      },
                      children: [
                        ...(listImageUrl ?? []).map((e) => Image.network(
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
                      ...(listImageUrl ?? []).map((e) =>
                          images(e, (listImageUrl ?? []).indexOf(e)))
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }

  Widget images(String imageUrl, int index) {
    return Container(
      decoration: BoxDecoration(
          border: index == imageIndex.value
              ? Border.all(color: Theme.of(Get.context!).primaryColor)
              : null),
      height: 100,
      width: 100,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(4, 4, 4, 4),
        child: InkWell(
          onTap: () {
            imageIndex.value = index;

            pageController.animateToPage(index,
                duration: const Duration(milliseconds: 500),
                curve: Curves.ease);
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
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
      ),
    );
  }
}

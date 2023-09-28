import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gohomy/components/loading/loading_full_screen.dart';
import 'package:gohomy/screen/admin/service_sell/add_service_sell/add_service_sell_screen.dart';
import 'package:gohomy/screen/admin/service_sell/service_sell_controller.dart';
import 'package:gohomy/screen/admin/service_sell/service_sell_details/service_sell_details_screen.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../components/empty/saha_empty_image.dart';
import '../../../components/loading/loading_widget.dart';
import '../../../model/service_sell.dart';
import '../../../utils/string_utils.dart';

class ServiceSellScreen extends StatefulWidget {
  const ServiceSellScreen({Key? key}) : super(key: key);

  @override
  State<ServiceSellScreen> createState() => _ServiceSellScreenState();
}

class _ServiceSellScreenState extends State<ServiceSellScreen> {
  ServiceSellController serviceSellController = ServiceSellController();
  RefreshController refreshController = RefreshController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                // begin: Alignment.bottomLeft,
                // end: Alignment.topRight,
                colors: <Color>[Colors.deepOrange, Colors.orange]),
          ),
        ),
        title: const Text('Dịch vụ bán'),
      ),
      body: Obx(
        () => serviceSellController.loadInit.value
          ? SahaLoadingFullScreen()
          : SmartRefresher(
              enablePullDown: true,
              enablePullUp: true,
              header: const MaterialClassicHeader(),
              controller: refreshController,
              footer: CustomFooter(
                builder: (
                  BuildContext context,
                  LoadStatus? mode,
                ) {
                  Widget body = Container();
                  if (mode == LoadStatus.idle) {
                    body = Obx(() => serviceSellController.isLoading.value
                        ? const CupertinoActivityIndicator()
                        : Container());
                  } else if (mode == LoadStatus.loading) {
                    body = const CupertinoActivityIndicator();
                  }
                  return SizedBox(
                    height: 100,
                    child: Center(child: body),
                  );
                },
              ),
              onRefresh: () async {
                await serviceSellController.getAllServiceSell(isRefresh: true);
                refreshController.refreshCompleted();
              },
              onLoading: () async {
                await serviceSellController.getAllServiceSell();
                refreshController.loadComplete();
              },
              child: Obx(
                () => ListView.builder(
                    addAutomaticKeepAlives: false,
                    addRepaintBoundaries: false,
                    itemCount: serviceSellController.listServiceSell.length,
                    itemBuilder: (BuildContext context, int index) {
                      return serviceSellItem(
                          serviceSellController.listServiceSell[index]);
                    }),
              ),
            )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => const AddServiceSellScreen())!.then((value) =>
              serviceSellController.getAllServiceSell(isRefresh: true));
        },
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget serviceSellItem(ServiceSell item) {
    return InkWell(
      onTap: () {
        Get.to(() => ServiceSellDetailsScreen(
                  id: item.id,
                ))!
            .then((value) =>
                serviceSellController.getAllServiceSell(isRefresh: true));
      },
      child: Container(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 1,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Container(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5.0),
                  child: CachedNetworkImage(
                    height: 100,
                    width: 100,
                    fit: BoxFit.cover,
                    imageUrl:
                        (item.images ?? []).isEmpty ? "" : item.images![0],
                    //placeholder: (context, url) => SahaLoadingWidget(),
                    errorWidget: (context, url, error) => const SahaEmptyImage(),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${item.name}'),
                  Text('${SahaStringUtils().convertToMoney(item.price)} vnđ'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

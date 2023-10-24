import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:gohomy/components/appbar/saha_appbar.dart';
import 'package:gohomy/components/loading/loading_full_screen.dart';
import 'package:gohomy/screen/admin/users/referrals/referrals_controller.dart';
import 'package:gohomy/screen/admin/users/referrals/referrals_detail/referral_detail_screen.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../components/empty/saha_empty_avatar.dart';
import '../../../../components/loading/loading_widget.dart';
import '../../../../model/user.dart';

class ReferralScreen extends StatelessWidget {
  ReferralScreen({super.key});
  ReferralController referralController = ReferralController();
  RefreshController refreshController = RefreshController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SahaAppBar(titleText: 'Quản lý cộng tác viên'),
      body: Obx(
        () => referralController.loadInit.value
            ? SahaLoadingFullScreen()
            : referralController.listReferral.isEmpty
                ? const Center(
                    child: Text('Chưa có cộng tác viên nào'),
                  )
                : SmartRefresher(
                    enablePullDown: true,
                    enablePullUp: true,
                    header: const MaterialClassicHeader(),
                    onRefresh: () {
                      referralController.getAllReferral(isRefresh: true);
                      refreshController.refreshCompleted();
                    },
                    onLoading: () async {
                      referralController.getAllReferral();
                      refreshController.loadComplete();
                    },
                    footer: CustomFooter(
                      builder: (
                        BuildContext context,
                        LoadStatus? mode,
                      ) {
                        Widget body = Container();
                        if (mode == LoadStatus.idle) {
                          body = Obx(() => referralController.isLoading.value
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
                    controller: refreshController,
                    child: ListView.builder(
                        addAutomaticKeepAlives: false,
                        addRepaintBoundaries: false,
                        itemCount: referralController.listReferral.length,
                        itemBuilder: (BuildContext context, int index) {
                          return referralItem(
                              referralController.listReferral[index]);
                        }),
                  ),
      ),
    );
  }

  Widget referralItem(User user) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          Get.to(() => ReferralDetailScreen(
                user: user,
              ));
        },
        child: Container(
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
          child: Row(
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100.0),
                  child: CachedNetworkImage(
                    height: 70,
                    width: 70,
                    fit: BoxFit.cover,
                    imageUrl: user.avatarImage == null ? '' : user.avatarImage!,
                    //placeholder: (context, url) => SahaLoadingWidget(),
                    errorWidget: (context, url, error) => const SahaEmptyAvata(
                      height: 60,
                      width: 60,
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
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      user.name ?? 'Chưa có tên',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.orange[700]),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      user.phoneNumber ?? '',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

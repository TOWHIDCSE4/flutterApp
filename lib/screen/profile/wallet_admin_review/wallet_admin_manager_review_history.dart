import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:gohomy/screen/profile/deposit_withdraw/widget/deposit_history_tile.dart';
import 'package:gohomy/screen/profile/deposit_withdraw/widget/withdraw_history_tile.dart';
import 'package:gohomy/screen/profile/wallet_admin_review/wallet_admin_review.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import './wallet_admin_controller.dart';

class WalletAdminManagerReviewHistory extends StatefulWidget {
  WalletAdminManagerReviewHistory({super.key}) {
    walletAdminController = Get.put(WalletAdminController());
  }

  late WalletAdminController walletAdminController;

  @override
  State<WalletAdminManagerReviewHistory> createState() =>
      _WalletAdminManagerReviewHistoryState();
}

class _WalletAdminManagerReviewHistoryState
    extends State<WalletAdminManagerReviewHistory> {


  @override
  void initState() {
    super.initState();
  }

  bool _isSearching = false;

  void _toggleSearch() {
    setState(() {
      _isSearching = !_isSearching;
    });
  }

  @override
  Widget build(BuildContext context) {
    const tabBar = TabBar(
      labelColor: Color(0xFF009247),
      labelStyle: TextStyle(
        fontFamily: 'Inter',
        fontWeight: FontWeight.w700,
      ),
      unselectedLabelColor: Color(0xFFFB3E15),
      unselectedLabelStyle: TextStyle(
        fontFamily: 'Inter',
        fontWeight: FontWeight.w700,
      ),
      tabs: [
        Tab(text: 'NẠP'),
        Tab(text: 'RÚT'),
      ],
    );
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: <Color>[Colors.deepOrange, Colors.orange],
              ),
            ),
          ),
          title: Row(
            children: [
              Expanded(
                child: _isSearching
                    ? Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: Container(
                          padding: const EdgeInsets.only(left: 10),
                          height: 40,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5)),
                          child: TextFormField(
                            onFieldSubmitted: (value) {},
                            //controller: chatListController.searchEdit,
                            decoration: InputDecoration(
                              isDense: true,
                              contentPadding:
                                  const EdgeInsets.only(top: 20, bottom: 5),
                              border: InputBorder.none,
                              hintText: "Tìm kiếm",
                            ),
                            minLines: 1,
                            maxLines: 1,
                          ),
                        ),
                      )
                    : const Text('Ví renren'),
              ),
              if (!_isSearching)
                GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            content: SizedBox(
                              width: Get.width * 0.9,
                              height: Get.height * 0.5,
                              child: SfDateRangePicker(
                                onCancel: () {
                                  Get.back();
                                },
                                showActionButtons: true,
                                selectionMode:
                                    DateRangePickerSelectionMode.range,
                                maxDate: DateTime.now(),
                              ),
                            ),
                          );
                        });
                  },
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    child: const Icon(
                      FontAwesomeIcons.calendar,
                    ),
                  ),
                ),
              GestureDetector(
                onTap: _toggleSearch,
                child: const Icon(Icons.search),
              ),
            ],
          ),
          bottom: PreferredSize(
            preferredSize: tabBar.preferredSize * 4.75,
            child: Column(
              children: [
                // DataBar.
                Container(
                  color: Colors.white,
                  child: Obx(
                    () => GridView(
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.symmetric(vertical: 7.5),
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 2.5,
                      ),
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 7.5),
                          child: GradientContainerWithShadow(
                            title: 'Tổng tiền nạp',
                            subtitle: widget.walletAdminController.dashboard
                                    .value.totalDeposits ??
                                "",
                            color: const Color(0xFF009247),
                            type: GradientContaineType.vnd,
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => GraphDeposit(),
                                )),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 7.5),
                          child: GradientContainerWithShadow(
                            title: 'Tổng tiền rút',
                            subtitle: widget.walletAdminController.dashboard
                                    .value.totalWithdraws ??
                                "",
                            color: const Color(0xFFF73131),
                            type: GradientContaineType.vnd,
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const GraphWithdraw(),
                                )),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 7.5),
                          child: GradientContainerWithShadow(
                            title: 'Tổng số Xu vàng',
                            subtitle: widget.walletAdminController.dashboard
                                    .value.totalGoldenCoins ??
                                "",
                            color: const Color(0xFFFDBB0C),
                            type: GradientContaineType.goldCoin,
                            // onTap: () => Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //       builder: (context) => const GraphGoldCoin(),
                            //     )),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 7.5),
                          child: GradientContainerWithShadow(
                            title: 'Tổng số Xu bạc',
                            subtitle: widget.walletAdminController.dashboard
                                    .value.totalSilverCoins ??
                                "",
                            color: const Color(0xFF8E8E8E),
                            type: GradientContaineType.silverCoin,
                            // onTap: () => Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //       builder: (context) =>
                            //           const GraphAmountSilverCoin(),
                            //     )),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                // TabBar.
                const Material(color: Colors.white, child: tabBar),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [WalletDepositHistory(), WalletWithdrawHistory()],
        ),
      ),
    );

    //   NestedScrollView(
    //     clipBehavior: Clip.none,
    //     physics: const NeverScrollableScrollPhysics(),
    //     floatHeaderSlivers: true,
    //     headerSliverBuilder: (context, innerBoxIsScrolled) => [
    //       // AppBar.
    //       SliverAppBar(
    //         pinned: true,
    //         floating: true,
    //         snap: true,
    //         // automaticallyImplyLeading: false,
    //         centerTitle: true,
    //         elevation: 0,
    //         scrolledUnderElevation: 2,
    //         // shadowColor: AppColors.shadowAccent,
    //         // shape: const RoundedRectangleBorder(
    //         //   borderRadius: AppThemes.borderRadiusAppBar,
    //         // ),
    //         title: const Text('Quản lý ví Renren'),
    //         actions: [
    //           IconButton(
    //             onPressed: () {},
    //             icon: const Icon(Icons.calendar_today_outlined),
    //           ),
    //           IconButton(
    //             onPressed: () {},
    //             icon: const Icon(Icons.search),
    //           ),
    //         ],
    //         bottom: PreferredSize(
    //           preferredSize: tabBar.preferredSize * 4.75,
    //           child: Column(
    //             children: [
    //               // DataBar.
    //               Container(
    //                 color: Colors.white,
    //                 child: GridView.builder(
    //                   physics: const NeverScrollableScrollPhysics(),
    //                   padding: const EdgeInsets.symmetric(vertical: 7.5),
    //                   shrinkWrap: true,
    //                   gridDelegate:
    //                       const SliverGridDelegateWithFixedCrossAxisCount(
    //                     crossAxisCount: 2,
    //                     childAspectRatio: 2.5,
    //                   ),
    //                   itemCount: topContainerMaps.length,
    //                   itemBuilder: (context, index) {
    //                     return Padding(
    //                       padding: const EdgeInsets.symmetric(
    //                           horizontal: 20, vertical: 7.5),
    //                       child: GradientContainerWithShadow(
    //                           title: topContainerMaps[index]['title'],
    //                           subtitle: topContainerMaps[index]['subtitle'],
    //                           color: topContainerMaps[index]['color']),
    //                     );
    //                   },
    //                 ),
    //               ),
    //               // TabBar.
    //               Material(color: Colors.white, child: tabBar),
    //             ],
    //           ),
    //         ),
    //       ),
    //     ],
    //     body: TabBarView(
    //       children: [
    //         for (final e in _viewMap.entries) e.value,
    //       ],
    //     ),
    //   ),
    // );
  }
}

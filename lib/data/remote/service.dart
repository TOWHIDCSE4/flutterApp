import 'package:dio/dio.dart';
import 'package:gohomy/data/remote/response-request/account/all_noti_user_res.dart';
import 'package:gohomy/data/remote/response-request/address/address_respone.dart';
import 'package:gohomy/data/remote/response-request/admin_manage/admin_badges_res.dart';
import 'package:gohomy/data/remote/response-request/admin_manage/admin_config.dart';
import 'package:gohomy/data/remote/response-request/admin_manage/admin_contact_res.dart';
import 'package:gohomy/data/remote/response-request/admin_manage/admin_discover_item_res.dart';
import 'package:gohomy/data/remote/response-request/admin_manage/admin_discover_res.dart';
import 'package:gohomy/data/remote/response-request/admin_manage/all_admin_category_help_post_res.dart';
import 'package:gohomy/data/remote/response-request/admin_manage/all_admin_discover_item_res.dart';
import 'package:gohomy/data/remote/response-request/admin_manage/all_admin_discover_res.dart';
import 'package:gohomy/data/remote/response-request/admin_manage/all_banner_res.dart';
import 'package:gohomy/data/remote/response-request/admin_manage/all_decentralization_res.dart';
import 'package:gohomy/data/remote/response-request/admin_manage/all_help_post_res.dart';
import 'package:gohomy/data/remote/response-request/admin_manage/all_history_receive_commission_res.dart';
import 'package:gohomy/data/remote/response-request/admin_manage/all_report_post_violation_res.dart';
import 'package:gohomy/data/remote/response-request/admin_manage/all_services_sell_response.dart';
import 'package:gohomy/data/remote/response-request/admin_manage/banner_res.dart';
import 'package:gohomy/data/remote/response-request/admin_manage/category_help_post_res.dart';
import 'package:gohomy/data/remote/response-request/admin_manage/decentralization_res.dart';
import 'package:gohomy/data/remote/response-request/admin_manage/help_post_data_res.dart';
import 'package:gohomy/data/remote/response-request/admin_manage/help_post_res.dart';
import 'package:gohomy/data/remote/response-request/admin_manage/report_post_find_room_res.dart';
import 'package:gohomy/data/remote/response-request/admin_manage/report_post_roommate_res.dart';
import 'package:gohomy/data/remote/response-request/admin_manage/report_violation_post_res.dart';
import 'package:gohomy/data/remote/response-request/admin_manage/service_sell_res.dart';
import 'package:gohomy/data/remote/response-request/auth/login_response.dart';
import 'package:gohomy/data/remote/response-request/chat/box_chat_res.dart';
import 'package:gohomy/data/remote/response-request/chat/chat_admin_helper_res.dart';
import 'package:gohomy/data/remote/response-request/customer_manage/all_post_find_room_res.dart';
import 'package:gohomy/data/remote/response-request/customer_manage/all_post_roommate_res.dart';
import 'package:gohomy/data/remote/response-request/customer_manage/post_find_room.dart';
import 'package:gohomy/data/remote/response-request/customer_manage/post_rommmate_res.dart';
import 'package:gohomy/data/remote/response-request/home_app/home_app_response.dart';
import 'package:gohomy/data/remote/response-request/manage/all_commission_manage_res.dart';
import 'package:gohomy/data/remote/response-request/manage/all_contract_res.dart';
import 'package:gohomy/data/remote/response-request/manage/commission_manage_res.dart';
import 'package:gohomy/data/remote/response-request/manage/motel_post_res.dart';
import 'package:gohomy/data/remote/response-request/manage/tower_res.dart';
import 'package:gohomy/data/remote/response-request/motel_room/all_motal_room_res.dart';
import 'package:gohomy/data/remote/response-request/motel_room/motal_room_res.dart';
import 'package:gohomy/data/remote/response-request/report/report_commission_res.dart';
import 'package:gohomy/data/remote/response-request/report/report_order_res.dart';
import 'package:gohomy/data/remote/response-request/report/report_post_find_room_res.dart';
import 'package:gohomy/data/remote/response-request/report/report_post_roommate_res.dart';
import 'package:gohomy/data/remote/response-request/report/report_potential_to_renter_res.dart';
import 'package:gohomy/data/remote/response-request/report/report_renter_has_motel_res.dart';
import 'package:gohomy/data/remote/response-request/report/report_service_sell_res.dart';
import 'package:gohomy/data/remote/response-request/report/report_static_bill_res.dart';
import 'package:gohomy/data/remote/response-request/report/report_static_contract_res.dart';
import 'package:gohomy/data/remote/response-request/report/report_static_potential_res.dart';
import 'package:gohomy/data/remote/response-request/report/report_users_did_kyc.dart';
import 'package:gohomy/data/remote/response-request/room_post/all_find_fast_motel.dart';
import 'package:gohomy/data/remote/response-request/room_post/all_reservation_motel_res.dart';
import 'package:gohomy/data/remote/response-request/room_post/all_room_post_res.dart';
import 'package:gohomy/data/remote/response-request/room_post/reservation_motel_res.dart';
import 'package:gohomy/data/remote/response-request/room_post/room_post_res.dart';
import 'package:gohomy/data/remote/response-request/service/service_res.dart';
import 'package:gohomy/data/remote/response-request/service_sell/all_address_order_res.dart';
import 'package:gohomy/data/remote/response-request/service_sell/all_category_res.dart';
import 'package:gohomy/data/remote/response-request/service_sell/cart_service_sell_res.dart';
import 'package:gohomy/data/remote/response-request/service_sell/category_res.dart';
import 'package:gohomy/data/remote/response-request/support_manage_motel/all_support_manage_tower_res.dart';
import 'package:gohomy/data/remote/response-request/support_manage_motel/support_manage_tower_res.dart';
import 'package:gohomy/data/remote/response-request/user_manage/all_bills_res.dart';
import 'package:gohomy/data/remote/response-request/user_manage/all_history_potential_res.dart';
import 'package:gohomy/data/remote/response-request/user_manage/all_potential_user_res.dart';
import 'package:gohomy/data/remote/response-request/user_manage/all_request_withdrawals_res.dart';
import 'package:gohomy/data/remote/response-request/user_manage/all_wallet_history_res.dart';
import 'package:gohomy/data/remote/response-request/user_manage/old_bill_res.dart';
import 'package:gohomy/data/remote/response-request/user_manage/potential_user_res.dart';
import 'package:gohomy/data/remote/response-request/user_manage/request_withdrawals_res.dart';
import 'package:gohomy/data/remote/response-request/user_manage/summary_motel_res.dart';
import 'package:gohomy/data/remote/response-request/user_manage/user_bill_res.dart';
import 'package:gohomy/data/remote/response-request/wallet/bank.dart';
import 'package:gohomy/data/remote/response-request/wallet/deposit.dart';
import 'package:gohomy/model/bill.dart';
import 'package:gohomy/screen/profile/deposit_withdraw/domain/deposit_history_model.dart';
import 'package:gohomy/screen/profile/deposit_withdraw/domain/withdraw_history_model.dart';
import 'package:gohomy/screen/profile/deposit_withdraw/domain/inquire_history_model.dart';
import 'package:gohomy/screen/profile/deposit_withdraw/domain/result_history_model.dart';
import 'package:retrofit/retrofit.dart';

import '../../const/api.dart';
import '../../utils/user_info.dart';
import 'response-request/account/all_user_res.dart';
import 'response-request/account/badge_res.dart';
import 'response-request/account/check_apple_res.dart';
import 'response-request/account/user_res.dart';
import 'response-request/auth/register_response.dart';
import 'response-request/chat/all_box_chat_res.dart';
import 'response-request/chat/all_mess_res.dart';
import 'response-request/chat/mess_res.dart';
import 'response-request/device_token/device_token_user_response.dart';
import 'response-request/image/upload_image_response.dart';
import 'response-request/manage/all_motel_post_res.dart';
import 'response-request/manage/all_renter_res.dart';
import 'response-request/manage/all_tower_res.dart';
import 'response-request/manage/bill_res.dart';
import 'response-request/manage/contract_res.dart';
import 'response-request/manage/renter_res.dart';
import 'response-request/notification/all_notification_response.dart';
import 'response-request/report/overview_res.dart';
import 'response-request/report/report_find_fast_motel_res.dart';
import 'response-request/report/report_motel_res.dart';
import 'response-request/report/report_post_badge_res.dart';
import 'response-request/report/report_post_res.dart';
import 'response-request/report/report_renter_res.dart';
import 'response-request/report/report_reservation_motels_res.dart';
import 'response-request/report/summary_motel_res.dart';
import 'response-request/room_post/find_fast_motel_res.dart';
import 'response-request/service/all_service_res.dart';
import 'response-request/service_sell/all_order_res.dart';
import 'response-request/service_sell/order_res.dart';
import 'response-request/success/success_response.dart';
import 'response-request/user_manage/all_problem_res.dart';
import 'response-request/user_manage/problem_res.dart';
import 'response-request/wallet/dashboard.dart';
import 'response-request/wallet/withdraw.dart';

part 'service.g.dart';

@RestApi(
  baseUrl: "$DOMAIN_API_CUSTOMER/api/",
)
abstract class SahaService {
  /// Retrofit factory
  factory SahaService(Dio dio, {String? baseUrl}) => _SahaService(dio,
      baseUrl: UserInfo().getIsRelease() == null
          // ? 'https://rencity-api.ikitech.vn/api/'
          // : 'http://gohomydev.ikitech.vn/api/');
          ? 'https://main-api.rencity.vn/api/'
          : 'https://main-api.rencity.vn/api/');

  ///New domain
  //  ? 'http://main-api.rencity.vn/'
  // : 'http://data-api.rencity.vn/');

  @POST("user/register")
  Future<RegisterResponse> register(@Body() Map<String, dynamic> body);

  @POST("user/login")
  Future<LoginResponse> login(@Body() Map<String, dynamic> body);

  @PUT("user/profile")
  Future<SuccessResponse> updateProfile(@Body() Map<String, dynamic> body);

  @PUT("user/profile/phone_number")
  Future<SuccessResponse> updatePhoneProfile(@Body() Map<String, dynamic> body);

  @PUT("user/host")
  Future<SuccessResponse> updateHost(@Body() Map<String, dynamic> body);

  @POST("user/check_username")
  Future<SuccessResponse> checkExists(@Body() Map<String, dynamic> body);

  @POST("user/send_otp")
  Future<SuccessResponse> sendOtp(@Body() Map<String, dynamic> body);

  @POST("user/reset_password")
  Future<SuccessResponse> resetPassword(@Body() Map<String, dynamic> body);

  @POST("user/change_password")
  Future<SuccessResponse> changePassword(@Body() Map<String, dynamic> body);

  ///

  @POST("user/images")
  Future<UploadImageResponse> uploadImage(@Body() Map<String, dynamic> body);

  @POST("user/videos")
  Future<UploadImageResponse> uploadVideo(@Body() Map<String, dynamic> body);

  @POST("device_token_user")
  Future<UpdateDeviceTokenResponse> updateDeviceTokenUser(
      @Body() Map<String, dynamic> body);

  /// address

  @GET("place/vn/province")
  Future<AddressResponse> getProvince();

  @GET("place/vn/district/{idProvince}")
  Future<AddressResponse> getDistrict(@Path() int? idProvince);

  @GET("place/vn/wards/{idDistrict}")
  Future<AddressResponse> getWard(@Path() int? idDistrict);

  /// service

  @GET("user/manage/services")
  Future<AllServiceRes> getAllService();

  @POST("user/manage/services")
  Future<ServiceRes> addService(
    @Body() Map<String, dynamic> body,
  );

  @PUT("user/manage/services/{serviceId}")
  Future<ServiceRes> updateService(
    @Path("serviceId") int serviceId,
    @Body() Map<String, dynamic> body,
  );

  @DELETE("user/manage/services/{serviceId}")
  Future<SuccessResponse> deleteService(
    @Path("serviceId") int serviceId,
  );

  /// Motel Room
  @GET("user/community/motels")
  Future<AllMotelRoomRes> getUserMotelRoom(
    @Query("page") int numberPage,
    @Query("search") String? search,
    @Query("has_contract") bool? hasContract,
    @Query("status") int? status,
  );

  @GET("user/manage/motels")
  Future<AllMotelRoomRes> getAllMotelRoom(
    @Query("page") int numberPage,
    @Query("search") String? search,
    @Query("has_contract") bool? hasContract,
    @Query("status") int? status,
    @Query("has_post") bool? hasPost,
    @Query("tower_id") int? towerId,
    @Query("is_have_tower") bool? isHaveTower,
    @Query("limit") int? limit,
    @Query("floor_from") int? floorFrom,
    @Query("floor_to") int? floorTo,
    @Query("is_supporter_manage") bool? isSupporterManage,
    @Query("is_have_supporter") bool? isHaveSupperter,
    @Query("manage_supporter_id") int? manageSupporterId,
    @Query("is_supporter") bool? isSupporter,
  );

  @POST("user/manage/motels")
  Future<MotelRoomRes> addMotelRoom(
    @Body() Map<String, dynamic> body,
  );

  @PUT("user/manage/motels/{motelRoomId}")
  Future<MotelRoomRes> updateMotelRoom(
    @Path("motelRoomId") int motelRoomId,
    @Body() Map<String, dynamic> body,
  );

  @DELETE("user/manage/motels/{motelRoomId}")
  Future<SuccessResponse> deleteMotelRoom(
    @Path("motelRoomId") int motelRoomId,
  );

  @GET("user/manage/motels/{motelRoomId}")
  Future<MotelRoomRes> getMotelRoom(
    @Path("motelRoomId") int motelRoomId,
  );

  @GET("user/manage/contracts")
  Future<AllContractRes> getAllContract(
    @Query("page") int page,
    @Query("contract_status") int? contractStatus,
    @Query("search") String? search,
    @Query("represent_name") String? representName,
    @Query("phone_number") String? phoneNumber,
    @Query("date_from") String? dateFrom,
    @Query("date_to") String? dateTo,
      @Query("tower_id") int? towerId
  );

  @GET("user/manage/contracts/{contractId}")
  Future<ContractRes> getContract(
    @Path("contractId") int contractId,
  );

  @POST("user/manage/contracts")
  Future<ContractRes> addContract(
    @Body() Map<String, dynamic> body,
  );

  @PUT("user/manage/contracts/{contractId}")
  Future<ContractRes> updateContract(
    @Path("contractId") int contractId,
    @Body() Map<String, dynamic> body,
  );

  @DELETE("user/manage/contracts/{contractId}")
  Future<SuccessResponse> deleteContract(
    @Path("contractId") int contractId,
  );

  @PUT("user/manage/contracts/status_contracts/{contractId}")
  Future<ContractRes> confirmDeposit(
    @Path("contractId") int contractId,
    @Body() Map<String, dynamic> body,
  );

  /// renters

  @GET("user/manage/renters")
  Future<AllRenterRes> getAllRenter(
    @Query("page") int page,
    @Query("is_rented") bool? isRented,
    @Query("renter_status") int? renterStatus,
    @Query("search") String? search,
    @Query("user_id") int? userId,
    @Query("from_date") String? fromDate,
    @Query("to_date") String? toDate,
  );

  @GET("user/manage/renters/{renterId}")
  Future<RenterRes> getRenter(
    @Path("renterId") int renterId,
  );

  @PUT("user/manage/renters/{renterId}")
  Future<RenterRes> updateRenter(
    @Path("renterId") int renterId,
    @Body() Map<String, dynamic> body,
  );

  @POST("user/manage/renters")
  Future<RenterRes> addRenter(
    @Body() Map<String, dynamic> body,
  );

  @DELETE("user/manage/renters/{renterId}")
  Future<SuccessResponse> deleteRenter(
    @Path("renterId") int renterId,
  );

  ///Room Post
  @GET("user/community/mo_posts")
  Future<AllRoomPost> getAllRoomPost(
    @Query("page") int page,
    @Query("search") String? search,
    @Query("wards") int? wards,
    @Query("district") int? district,
    @Query("province") int? province,
    @Query("has_pet") bool? hasPet,
    @Query("has_tivi") bool? hasTivi,
    @Query("has_wc") bool? hasWc,
    @Query("has_window") bool? hasWindow,
    @Query("has_security") bool? hasSecurity,
    @Query("has_free_move") bool? hasFreeMove,
    @Query("has_own_owner") bool? hasOwnOwner,
    @Query("has_air_conditioner") bool? hasAirConditioner,
    @Query("has_water_heater") bool? hasWaterHeater,
    @Query("has_kitchen") bool? hasKitchen,
    @Query("has_fridge") bool? hasFridge,
    @Query("has_washing_machine") bool? hasWashingMachine,
    @Query("has_mezzanine") bool? hasMezzanine,
    @Query("has_bed") bool? hasBed,
    @Query("has_wardrobe") bool? hasWardrobe,
    @Query("has_balcony") bool? hasBalcony,
    @Query("has_finger_print") bool? hasFingerprint,
    @Query("has_kitchen_stuff") bool? hasKitchenStuff,
    @Query("has_ceiling_fans") bool? hasCeilingFans,
    @Query("has_curtain") bool? hasCurtain,
    @Query("has_decorative_lights") bool? hasDecorativeLights,
    @Query("has_mattress") bool? hasMattress,
    @Query("has_mirror") bool? hasMirror,
    @Query("has_sofa") bool? hasSofa,
    @Query("has_picture") bool? hasPicture,
    @Query("has_pillow") bool? hasPillow,
    @Query("has_table") bool? hasTable,
    @Query("has_shoes_rasks") bool? hasShoesRacks,
    @Query("has_tree") bool? hasTree,
    @Query("money_from") double? fromMoney,
    @Query("money_to") double? maxMoney,
    @Query("descending") bool? descending,
    @Query("sort_by") String? sortBy,
    @Query("phone_number") String? phoneNumber,
    @Query("list_type") String? listType,
  );

  @POST("user/community/post_loca_nearest")
  Future<AllRoomPost> getAllMoPostLocationFind(
    @Query("page") int page,
    @Body() Map<String, dynamic> body,
  );

  @GET("user/community/mo_posts/similar_posts/{postId}")
  Future<AllRoomPost> getAllRoomPostSimilar(
    @Path("postId") int postId,
    @Query("page") int page,
  );

  @GET("user/community/mo_posts/{roomPostId}")
  Future<RoomPostRes> getRoomPost(
    @Path("roomPostId") int roomPostId,
  );

  /////call_report
  @POST("user/community/find_fast_motels")
  Future<FindFastMotelRes> addFindFastMotel(
    @Body() Map<String, dynamic> body,
  );

  /// find fast motel

  @POST("user/community/statistic_call_post/{id}")
  Future<SuccessResponse> callRequest(
    @Path("id") int id,
  );

  @POST("user/community/call_post_find_motel/{id}")
  Future<SuccessResponse> callFindRoom(
    @Path("id") int id,
  );

  @POST("user/community/call_post_roommate/{id}")
  Future<SuccessResponse> callPostRoommate(
    @Path("id") int id,
  );

  /// reservation motel

  @POST("user/community/reservation_motel")
  Future<ReservationMotelRes> addReservationMotel(
    @Body() Map<String, dynamic> body,
  );

  /// report post violation
  @POST("user/community/report_post_violations")
  Future<ReportViolationPostRes> addReportPostViolation(
    @Body() Map<String, dynamic> body,
  );

  ///Post management
  @GET("user/manage/mo_posts")
  Future<AllMotelPostRes> getAllPostManagement(
    @Query("page") int page,
    @Query("status") int? contractStatus,
    @Query("search") String? search,
    @Query("money_from") String? moneyFrom,
    @Query("money_to") String? moneyTo,
    @Query("district") int? district,
    @Query("province") int? province,
  );

  @GET("user/manage/mo_posts/{id}")
  Future<MotelPostRes> getPostManagement(
    @Path("id") int id,
  );

  @POST("user/manage/mo_posts")
  Future<MotelPostRes> addPostManagement(
    @Body() Map<String, dynamic> body,
  );

  @PUT("user/manage/mo_posts/{postManagementId}")
  Future<MotelPostRes> updatePostManagement(
    @Path("postManagementId") int postManagementId,
    @Body() Map<String, dynamic> body,
  );

  @PUT("user/manage/mo_posts/update_status/{postManagementId}")
  Future<MotelPostRes> changePostStatus(
    @Path("postManagementId") int postManagementId,
    @Body() Map<String, dynamic> body,
  );

  @DELETE("user/manage/mo_posts/{postManagementId}")
  Future<SuccessResponse> deletePostManagement(
    @Path("postManagementId") int postManagementId,
  );

  ///Home App
  @GET("user/community/home_app")
  Future<HomeAppRes> getHomeApp(
    @Query("province") int? province,
  );

  ///User Manage
  @GET("user/summary_motel")
  Future<SummaryRes> getSummary();

  @GET("user/community/bills")
  Future<AllBillsRes> getUserAllBill(
    @Query("page") int page,
    @Query("search") String? search,
    @Query("status") int? status,
    @Query("date_from") String? dateFrom,
    @Query("date_to") String? dateTo,
  );

  @PUT("user/community/bills/{billId}")
  Future<Bill> putUserPayment(
    @Path("billId") int billId,
    @Body() Map<String, dynamic> body,
  );

  @GET("user/community/bills/{billId}")
  Future<UserBillRes> getUserBill(
    @Path("billId") int billId,
  );

  @GET("user/manage/bills")
  Future<AllBillsRes> getAllBill(
    @Query("page") int page,
    @Query("search") String? search,
    @Query("status") int? status,
    @Query("date_from") String? dateFrom,
    @Query("date_to") String? dateTo,
  );

  @GET("user/manage/bills/{billId}")
  Future<BillRes> getOneBill(
    @Path("billId") int billId,
  );

  @POST("user/manage/bills")
  Future<BillRes> addBill(
    @Body() Map<String, dynamic> body,
  );

  @PUT("user/manage/bills/{billId}")
  Future<BillRes> updateBill(
    @Path("billId") int billId,
    @Body() Map<String, dynamic> body,
  );

  @PUT("user/manage/bill_status/{billId}")
  Future<BillRes> billStatus(
    @Path("billId") int billId,
    @Body() Map<String, dynamic> body,
  );

  @DELETE("user/manage/bills/{billId}")
  Future<SuccessResponse> deleteBill(
    @Path("billId") int billId,
  );

  @GET("/user/manage/bills_gen/{roomId}")
  Future<OldBillRes> getBillRoom(
    @Path("roomId") int roomId,
  );

  /////Manage commission
  @GET("user/manage/commission_collaborator")
  Future<AllCommissionManageRes> getAllCommissionManage(
    @Query("page") int page,
    @Query("status") int? status,
    @Query("date_from") String? dateFrom,
    @Query("date_to") String? dateTo,
  );

  @GET("user/manage/commission_collaborator/{id}")
  Future<CommissionManageRes> getCommissionManage(
    @Path("id") int id,
  );

  @PUT("user/manage/commission_collaborator/{id}")
  Future<CommissionManageRes> confirmCommissionManage(
    @Path("id") int id,
    @Body() Map<String, dynamic> body,
  );

  ///

  @GET("user/community/report_problem")
  Future<AllProblemRes> getAllProblem(
    @Query("page") int page,
    @Query("date_from") String? dateFrom,
    @Query("date_to") String? dateTo,
    @Query("status") int? status,
  );

  @POST("user/community/report_problem")
  Future<ProblemRes> addProblem(
    @Body() Map<String, dynamic> body,
  );

  @PUT("user/community/report_problem/{problemId}")
  Future<ProblemRes> updateProblem(
    @Path("problemId") int problemId,
    @Body() Map<String, dynamic> body,
  );

  @GET("user/community/report_problem/{problemId}")
  Future<ProblemRes> getProblem(
    @Path("problemId") int problemId,
  );

  @DELETE("user/community/report_problem/{problemId}")
  Future<SuccessResponse> deleteProblem(
    @Path("problemId") int problemId,
  );

  /// Report

  @GET("user/manage/overview")
  Future<OverViewRes> getOverView(
    @Query("date_from") String? startDate,
    @Query("date_to") String? dateTo,
  );

  @GET("user/summary_motel")
  Future<SummaryMotelRes> getSummaryMotel(
    @Query("date_from") String? startDate,
    @Query("date_to") String? dateTo,
  );

  @GET("admin/report_statistic/orders")
  Future<ReportOrderRes> getReportOrder(
    @Query("date_from") String? timeFrom,
    @Query("date_to") String? timeTo,
  );

  @GET("admin/report_statistic/mo_posts")
  Future<ReportPostRes> getReportPost(
    @Query("date_from") String? timeFrom,
    @Query("date_to") String? timeTo,
  );

  @GET("admin/report_statistic/mo_post_find_motels")
  Future<ReportStaticPostFindRoomRes> getReportPostFindRoom(
    @Query("date_from") String? timeFrom,
    @Query("date_to") String? timeTo,
  );

  @GET("admin/report_statistic/mo_post_roommates")
  Future<ReportStaticPostRoommateRes> getReportPostRoommate(
    @Query("date_from") String? timeFrom,
    @Query("date_to") String? timeTo,
  );

  @GET("admin/report_statistic/potentials")
  Future<ReportStaticPotentialRes> getReportStaticPotential(
    @Query("date_from") String? timeFrom,
    @Query("date_to") String? timeTo,
  );

  @GET("admin/report_statistic/potential_has_motels")
  Future<ReportRenterHasMotelRes> getReportRenterHasMotel(
    @Query("date_from") String? timeFrom,
    @Query("date_to") String? timeTo,
  );

  @GET("admin/report_statistic/contracts")
  Future<ReportStaticContractRes> getReportStaticContract(
    @Query("date_from") String? timeFrom,
    @Query("date_to") String? timeTo,
  );

  @GET("admin/report_statistic/bills")
  Future<ReportStaticBillRes> getReportStaticBill(
    @Query("date_from") String? timeFrom,
    @Query("date_to") String? timeTo,
  );

  @GET("admin/report_statistic/bills")
  Future<ReportPotentialToRenterRes> getReportPotentialToRenter(
    @Query("date_from") String? timeFrom,
    @Query("date_to") String? timeTo,
  );

  @GET("admin/report_statistic/mo_post_badges")
  Future<ReportPostBadgeRes> getReportPostBadge(
    @Query("date_from") String? timeFrom,
    @Query("date_to") String? timeTo,
  );

  @GET("admin/report_statistic/service_sell")
  Future<ReportServiceSellRes> getServiceSellReport(
    @Query("date_from") String? timeFrom,
    @Query("date_to") String? timeTo,
  );

  @GET("admin/report_statistic/renters")
  Future<ReportRenterRes> getReportRenter(
    @Query("date_from") String? timeFrom,
    @Query("date_to") String? timeTo,
  );

  @GET("admin/report_statistic/find_fast_motels")
  Future<ReportFindFastMotelRes> getReportFindFastMotel(
    @Query("date_from") String? timeFrom,
    @Query("date_to") String? timeTo,
  );

  @GET("admin/report_statistic/reservation_motels")
  Future<ReportReservationMotelRes> getReportReservationMotel(
    @Query("date_from") String? timeFrom,
    @Query("date_to") String? timeTo,
  );

  @GET("admin/report_statistic/motels")
  Future<ReportMotelRes> getReportMotel(
    @Query("date_from") String? timeFrom,
    @Query("date_to") String? timeTo,
  );

  @GET("admin/report_statistic/commission_admin")
  Future<ReportCommissionRes> getReportCommission(
    @Query("date_from") String? timeFrom,
    @Query("date_to") String? timeTo,
  );

  @GET("admin/report_statistic/kyc_user_data")
  Future<ReportStaticUsersDidKycRes> getReportUsersDidKyc(
      @Query("date_from") String? timeFrom,
      @Query("date_to") String? timeTo,
      );

  /// Chat

  @GET("admin/person_chat/{userId}")
  Future<AllBoxChatRes> getAllBoxChatAdmin(
    @Query("page") int? currentPage,
    @Query("search") String? search,
    @Path("userId") int userId,
  );

  @GET("admin/person_chat/{personId}/messages")
  Future<AllMessRes> getAllMessAdmin(
    @Path("personId") int personId,
    @Query("page") int? currentPage,
  );

  @GET("user/community/person_chat")
  Future<AllBoxChatRes> getAllBoxChat(
    @Query("page") int? currentPage,
    @Query("search") String? search,
  );

  @GET("user/community/person_chat/{idBoxChat}")
  Future<BoxChatRes> getBoxChat(
    @Path("idBoxChat") int idBoxChat,
  );

  @GET("user/community/person_chat/admin_my_host")
  Future<ChatAdminHelperRes> getChatAdminHelper(
    @Query("search") String? search,
  );

  @GET("user/community/person_chat/{personId}/messages")
  Future<AllMessRes> getAllMess(
    @Path("personId") int personId,
    @Query("page") int? currentPage,
  );

  @POST("user/community/person_chat/{personId}/messages")
  Future<MessRes> chatPerson(
      @Path("personId") int personId, @Body() Map<String, dynamic> body);

  @POST("user/search_user/one")
  Future<UserRes> searchUser(@Body() Map<String, dynamic> body);

  @GET("user/search_users")
  Future<AllUserRes> searchAllUser(
    @Query("search") String? search,
  );

  @GET("user/person_chat/{userId}/messages/recall/{messId}")
  Future<SuccessResponse> reCallUser(
    @Path("userId") int userId,
    @Path("messId") String messId,
  );

  @DELETE("user/person_chat/{userId}")
  Future<SuccessResponse> deleteBoxUSer(
    @Path("userId") int userId,
  );

  /// badge

  @GET("user/badges")
  Future<BadgesRes> getBadge();

  @GET("user/login_apple")
  Future<CheckAppleRes> getCheckApple();

  /// owner

  @GET("user/manage/report_problem")
  Future<AllProblemRes> getAllProblemOwner(
    @Query("page") int page,
    @Query("date_from") String? dateFrom,
    @Query("date_to") String? dateTo,
    @Query("status") int? status,
  );

  @PUT("user/manage/report_problem/{problemId}")
  Future<ProblemRes> updateProblemOwner(
    @Path("problemId") int problemId,
    @Body() Map<String, dynamic> body,
  );

  @DELETE("user/manage/report_problem/{problemId}")
  Future<SuccessResponse> deleteProblemOwner(
    @Path("problemId") int problemId,
  );

  @GET("user/manage/report_problem/{problemId}")
  Future<ProblemRes> getProblemOwner(
    @Path("problemId") int problemId,
  );

  /// contract user

  @GET("user/community/contracts")
  Future<AllContractRes> getAllContractUser(
    @Query("page") int page,
    @Query("contract_status") int? contractStatus,
    @Query("search") String? search,
    @Query("date_from") String? dateFrom,
    @Query("date_to") String? dateTo,
  );

  @GET("user/community/contracts/{contractId}")
  Future<ContractRes> getContractUser(
    @Path("contractId") int contractId,
  );

  @PUT("user/community/contracts/{contractId}")
  Future<ContractRes> updateContractUser(
    @Path("contractId") int contractId,
    @Body() Map<String, dynamic> body,
  );

  ///Favourite Post
  @GET("user/community/favorite_mo_posts")
  Future<AllRoomPost> getAllFavouritePost(
    @Query("page") int page,
  );

  @POST("user/community/favorite_mo_posts/{id}")
  Future<RoomPostRes> setFavourite(
    @Path("id") int id,
    @Body() Map<String, dynamic> body,
  );

  /// service sell

  @GET("user/community/service_sells")
  Future<AllServiceSellRes> getAllServiceSellUser(
    @Query("page") int page,
    @Query("category_service_sell_ids") int? categoryId,
  );

  @GET("user/community/service_sells/{id}")
  Future<ServiceSellRes> getServiceSellUser(
    @Path("id") int id,
  );

  @POST("user/community/cart_service_sells")
  Future<CartServiceSellsRes> addItemToCart(
    @Body() Map<String, dynamic> body,
  );

  @PUT("user/community/cart_service_sells")
  Future<CartServiceSellsRes> updateItemToCart(
    @Body() Map<String, dynamic> body,
  );

  @GET("user/community/cart_service_sells")
  Future<CartServiceSellsRes> getCartInfo();

  @POST("user/community/order_service_sells/send")
  Future<OrderRes> order(
    @Body() Map<String, dynamic> body,
  );

  @GET("user/community/order_service_sells")
  Future<AllOrderRes> getAllOrder(
    @Query("page") int page,
    @Query("search") String? search,
    @Query("order_status") int orderStatus,
  );

  @GET("user/community/order_service_sells/{id}")
  Future<OrderRes> getOneOrder(@Path("id") String? id);

  ///help post community
  @GET("user/community/category_help_post")
  Future<AllAdminCategoryHelpPostRes> getAllCategoryHelpPost(
    @Query("page") int page,
    @Query("search") String? search,
  );

  @GET("user/community/help_post")
  Future<AllHelpPostRes> getAllHelpPost(
    @Query("page") int page,
    @Query("type_category") int? typeCategory,
    @Query("search") String? search,
  );

  @GET("user/community/help_post/{id}")
  Future<HelpPostDataRes> getOneHelpPost(
    @Path("id") int id,
  );

  /// reservation motel

  @GET("user/manage/reservation_motel")
  Future<AllReservationMotelRes> getReservationMotelHost(
    @Query("page") int numberPage,
    @Query("status") int? status,
    @Query("search") String? search,
  );

  @PUT("user/manage/reservation_motel/{reservationId}")
  Future<ReservationMotelRes> updateReservationMotel(
    @Path("reservationId") int reservationId,
    @Body() Map<String, dynamic> body,
  );

  @DELETE("user/manage/reservation_motel/{reservationId}")
  Future<SuccessResponse> deleteReservationMotel(
    @Path("reservationId") int reservationId,
  );

  //////E-Wallet
  @GET("user/community/e_wallet_histories")
  Future<AllWalletHistoryRes> getAllWalletHistories(
    @Query("page") int numberPage,
  );

  @POST("user/community/request_withdrawals")
  Future<RequestWithdrawalsRes> requestWithdrawal(
    @Body() Map<String, dynamic> body,
  );

  @GET("user/community/request_withdrawals")
  Future<AllRequestWithdrawalsRes> getAllRequestWithdrawal(
    @Query("page") int numberPage,
  );

  @GET("user/community/request_withdrawals/{id}")
  Future<RequestWithdrawalsRes> getWithdrawalUser(@Path("id") int id);

  @PUT("user/community/request_withdrawals/{id}")
  Future<RequestWithdrawalsRes> updateWithdrawal(
    @Path("id") int id,
    @Body() Map<String, dynamic> body,
  );

  @DELETE("/user/community/request_withdrawals/{id}")
  Future<SuccessResponse> deleteWithdrawalUser(
    @Path("id") int id,
  );

  //////////////////////////////////////////////////////////////////////////////// Admin

  @GET("admin/report_statistic/badges")
  Future<AdminBadgesRes> getAdminBadges();

  @GET("admin/motels")
  Future<AllMotelRoomRes> getAllAdminMotelRoom(
    @Query("page") int numberPage,
    @Query("status") int? status,
    @Query("search") String? search,
    @Query("user_id") int? userId,
    @Query("has_contract") bool? hasContract,
    @Query("tower_id") int? towerId,
    @Query("is_have_tower") bool? isHaveTower,
    @Query("is_supporter") bool? isSupporter,
  );

  @GET("admin/motels/{id}")
  Future<MotelRoomRes> getAdminMotelRoom(@Path("id") int? id);

  @DELETE("admin/motels/{id}")
  Future<SuccessResponse> deleteAdminMotelRoom(
    @Path("id") int id,
  );

  @GET("admin/get-all-tower/{user_id}")
  Future<AllTowerRes> getAllAdminTowers(
    @Query("page") int numberPage,
    @Path("user_id") int userId,
  );

  @POST("admin/update-towetmotel-byroom")
  Future<MotelRoomRes> updateMotelHiddenStatus(
      @Body() Map<String, dynamic> body);

  @GET("admin/users")
  Future<AllUserRes> getAllUsers(
    @Query("sort_by") String? ranked,
    @Query("page") int? page,
    @Query("is_host") bool? isHost,
    @Query("search") String? search,
    @Query("is_rented") bool? isRented,
    @Query("is_admin") bool? isAdmin,
  );

  @GET("admin/users/{userId}")
  Future<UserRes> getUsers(
    @Path("userId") int userId,
  );

  @DELETE("admin/users/{id}")
  Future<SuccessResponse> deleteUser(
    @Path("id") int id,
  );

  @GET("admin/service_sells")
  Future<AllServiceSellRes> getAllServiceSell(
    @Query("page") int page,
    @Query("category_service_sell_ids") int? categoryId,
  );

  @POST("admin/service_sells")
  Future<ServiceSellRes> addServiceSell(@Body() Map<String, dynamic> body);

  @GET("admin/service_sells/{id}")
  Future<ServiceSellRes> getServiceSell(
    @Path("id") int id,
  );

  @PUT("admin/service_sells/{id}")
  Future<ServiceSellRes> updateServiceSell(
    @Path("id") int id,
    @Body() Map<String, dynamic> body,
  );

  @DELETE("admin/service_sells/{id}")
  Future<SuccessResponse> deleteServiceSell(
    @Path("id") int id,
  );

  @GET("admin/mo_posts")
  Future<AllRoomPost> getAllMotelPost(
    @Query("page") int? page,
    @Query("status") int? status,
    @Query("search") String? search,
    @Query("user_id") int? userId,
  );

  @GET("admin/mo_posts/{id}")
  Future<RoomPostRes> getMotelPost(
    @Path("id") int id,
  );

  @DELETE("admin/mo_posts/{id}")
  Future<SuccessResponse> deleteMotelPost(
    @Path("id") int id,
  );

  @PUT("admin/mo_posts/{id}")
  Future<RoomPostRes> approvePost(
    @Path("id") int id,
    @Body() Map<String, dynamic> body,
  );

  @GET("admin/banners")
  Future<AllBannerRes> getAllBanner(
    @Query("page") int? page,
  );

  @GET("admin/banners/{id}")
  Future<BannerRes> getBanner(
    @Path("id") int id,
  );

  @POST("admin/banners")
  Future<AllBannerRes> addBanner(@Body() Map<String, dynamic> body);

  @PUT("admin/banners/{id}")
  Future<BannerRes> updateBanner(
    @Path("id") int id,
    @Body() Map<String, dynamic> body,
  );

  @DELETE("admin/banners")
  Future<SuccessResponse> deleteBanner(
    @Body() Map<String, dynamic> body,
  );

  @GET("admin/admin_discovers")
  Future<AllAdminDiscoverRes> getAllAdminDiscover();

  @GET("admin/admin_discover_items")
  Future<AllAdminDiscoverItemRes> getAllAdminDiscoverItem(
    @Query("admin_discover_id") int? id,
  );

  @POST("admin/admin_discovers")
  Future<AdminDiscoverRes> addDiscover(
    @Body() Map<String, dynamic> body,
  );

  @DELETE("admin/admin_discovers")
  Future<SuccessResponse> deleteDiscover(
    @Body() Map<String, dynamic> body,
  );

  @POST("admin/admin_discover_items")
  Future<AdminDiscoverItemRes> addDiscoverItem(
    @Body() Map<String, dynamic> body,
  );

  @DELETE("admin/admin_discover_items")
  Future<SuccessResponse> deleteDiscoverItem(
    @Body() Map<String, dynamic> body,
  );

  @GET("admin/admin_discover_items/{id}")
  Future<AdminDiscoverItemRes> getDiscoverItem(
    @Path("id") int id,
  );

  @PUT("admin/admin_discover_items/{id}")
  Future<AdminDiscoverItemRes> updateDiscoverItem(
    @Path("id") int id,
    @Body() Map<String, dynamic> body,
  );

  @PUT("admin/admin_discovers/{id}")
  Future<AdminDiscoverRes> updateDiscover(
    @Path("id") int id,
    @Body() Map<String, dynamic> body,
  );

  @GET("admin/admin_contact")
  Future<AdminContactRes> getAdminContact();

  @PUT("admin/admin_contact")
  Future<AdminContactRes> updateAdminContact(
    @Body() Map<String, dynamic> body,
  );

  @PUT("admin/users/{id}")
  Future<UserRes> updateUser(
    @Path("id") int id,
    @Body() Map<String, dynamic> body,
  );

  @GET("admin/order_service_sell")
  Future<AllOrderRes> getAllOrderAdmin(
    @Query("page") int page,
    @Query("search") String? search,
    @Query("order_status") int orderStatus,
  );

  @GET("admin/order_service_sell/{id}")
  Future<OrderRes> getOrderAdmin(
    @Path("id") int id,
  );

  @PUT("admin/order_service_sell/{orderId}")
  Future<OrderRes> updateOrderAdmin(
    @Path("orderId") int orderId,
    @Body() Map<String, dynamic> body,
  );

  @DELETE("admin/order_service_sell/{orderId}")
  Future<SuccessResponse> deleteOrderAdmin(
    @Path("orderId") int orderId,
  );

  @GET("admin/category_help_post")
  Future<AllAdminCategoryHelpPostRes> getAllAdminCategoryHelpPost(
    @Query("page") int page,
  );

  @POST("admin/category_help_post")
  Future<CategoryHelpPostRes> addCategoryHelpPost(
    @Body() Map<String, dynamic> body,
  );

  @GET("admin/help_post")
  Future<AllHelpPostRes> getAllAdminHelpPost(
    @Query("page") int page,
  );

  @POST("admin/help_post")
  Future<SuccessResponse> addHelpPost(
    @Body() Map<String, dynamic> body,
  );

  @GET("admin/help_post/{id}")
  Future<HelpPostDataRes> getHelpPost(
    @Path("id") int id,
  );

  @PUT("admin/help_post/{id}")
  Future<HelpPostRes> updateHelpPost(
    @Path("id") int id,
    @Body() Map<String, dynamic> body,
  );

  @DELETE("admin/help_post/{id}")
  Future<SuccessResponse> deleteHelpPost(
    @Path("id") int id,
  );

  @GET("admin/category_help_post/{id}")
  Future<CategoryHelpPostRes> getCategoryHelp(
    @Path("id") int id,
  );

  @PUT("admin/category_help_post/{id}")
  Future<CategoryHelpPostRes> updateCategoryHelp(
    @Path("id") int id,
    @Body() Map<String, dynamic> body,
  );

  @DELETE("admin/category_help_post/{id}")
  Future<SuccessResponse> deleteCategoryHelp(
    @Path("id") int id,
  );

  @GET("admin/renters")
  Future<AllRenterRes> getAllAdminRenter(
    @Query("page") int page,
    @Query("is_rented") bool? isRented,
    @Query("search") String? search,
    @Query("user_id") int? userId,
    @Query("from_date") String? fromDate,
    @Query("to_date") String? toDate,
  );

  @POST("admin/notifications")
  Future<SuccessResponse> sendAdminNotification(
    @Body() Map<String, dynamic> body,
  );

  //decentralization
  @GET("admin/system_permissions")
  Future<AllDecentralizationRes> getAllDecentralization(
      @Query('page') int page);

  @POST("admin/system_permissions")
  Future<DecentralizationRes> addDecentralization(
    @Body() Map<String, dynamic> body,
  );

  @GET("admin/system_permissions/{id}")
  Future<DecentralizationRes> getDecentralization(@Path("id") int id);

  @PUT("admin/system_permissions/{id}")
  Future<DecentralizationRes> updateDecentralization(
    @Path("id") int id,
    @Body() Map<String, dynamic> body,
  );

  @DELETE("admin/system_permissions/{id}")
  Future<SuccessResponse> deleteDecentralization(
    @Path("id") int id,
  );

  @PUT("admin/user_permissions")
  Future<SuccessResponse> decentralizationAdmin(
    @Body() Map<String, dynamic> body,
  );

  ///////commission admin

  @GET("admin/commission_collaborator")
  Future<AllCommissionManageRes> getAllCommissionAdmin(
    @Query("page") int page,
    @Query("status") int? status,
    @Query("status_commission_collaborator") int? statusCommissionCollaborator,
    @Query("date_from") String? dateTo,
    @Query("date_to") String? dateFrom,
  );

  @GET("admin/commission_collaborator/{id}")
  Future<CommissionManageRes> getCommissionAdmin(
    @Path("id") int id,
  );

  @PUT("admin/commission_collaborator/confirm_paid_admin/{id}")
  Future<CommissionManageRes> confirmCommissionAdmin(
    @Path("id") int id,
    @Body() Map<String, dynamic> body,
  );

  @PUT("admin/commission_collaborator/confirm_user/{id}")
  Future<CommissionManageRes> confirmCommissionUser(
    @Path("id") int id,
    @Body() Map<String, dynamic> body,
  );

  /// noti

  @GET("user/notifications_history")
  Future<AllNotificationResponse> historyNotification(
    @Query("page") int numberPage,
  );

  @POST("user/notifications_history")
  Future<SuccessResponse> readAllNotification();

  @POST("user/notifications_history/{notiId}")
  Future<SuccessResponse> readNotification(
    @Path("notiId") int notiId,
  );

  /// find fast motel

  @GET("admin/find_fast_motels")
  Future<AllFindFastMotelRes> getAllFindFastMotel(
    @Query("page") int numberPage,
    @Query("status") int? status,
    @Query("search") String? search,
  );

  @GET("admin/find_fast_motels/{findFastMotelId}")
  Future<FindFastMotelRes> getFindFastMotel(
    @Path("findFastMotelId") int findFastMotelId,
  );

  @PUT("admin/find_fast_motels/{findFastMotelId}")
  Future<FindFastMotelRes> updateFindFastMotel(
    @Path("findFastMotelId") int findFastMotelId,
    @Body() Map<String, dynamic> body,
  );

  @DELETE("admin/find_fast_motels/{findFastMotelId}")
  Future<SuccessResponse> deleteFindFastMotel(
    @Path("findFastMotelId") int findFastMotelId,
  );

  /// reservation motel

  @GET("admin/reservation_motel")
  Future<AllReservationMotelRes> getReservationMotelAdmin(
    @Query("page") int numberPage,
    @Query("status") int? status,
    @Query("search") String? search,
    @Query("user_id") int? userId,
  );

  /// report violation
  @GET("admin/report_post_violations")
  Future<AllReportPostViolationRes> getAllReportViolationPost(
    @Query("page") int numberPage,
    @Query("status") int? status,
    @Query("search") String? search,
  );

  @DELETE("admin/report_post_violations/{id}")
  Future<SuccessResponse> deleteReportPostViolation(
    @Path("id") int id,
  );

  @PUT("admin/report_post_violations/{id}")
  Future<ReportViolationPostRes> updateReportPostViolation(
    @Path("id") int id,
    @Body() Map<String, dynamic> body,
  );

  /// bill admin

  @GET("admin/bills")
  Future<AllBillsRes> getAllBillAdmin(
    @Query("page") int page,
    @Query("search") String? search,
    @Query("status") int? status,
    @Query("date_from") String? dateFrom,
    @Query("date_to") String? dateTo,
    @Query("user_id") int? userId,
  );

  /// contract admin

  @GET("admin/contracts")
  Future<AllContractRes> getAllContractAdmin(
    @Query("page") int page,
    @Query("contract_status") int? contractStatus,
    @Query("search") String? search,
    @Query("represent_name") String? representName,
    @Query("phone_number") String? phoneNumber,
    @Query("date_from") String? dateFrom,
    @Query("date_to") String? dateTo,
    @Query("user_id") int? userId,
  );

  /// problem

  @GET("admin/report_problem")
  Future<AllProblemRes> getAllProblemAdmin(
    @Query("page") int page,
    @Query("date_from") String? dateFrom,
    @Query("date_to") String? dateTo,
    @Query("status") int? status,
    @Query("user_id") int? userId,
  );

  ///withdrawal admin

  @GET("admin/request_withdrawals")
  Future<AllRequestWithdrawalsRes> getAllWithdrawalAdmin(
    @Query("page") int page,
    @Query("status") int? status,
    @Query("date_from") String? dateFrom,
    @Query("date_to") String? dateTo,
  );

  @GET("admin/request_withdrawals/{id}")
  Future<RequestWithdrawalsRes> getWithdrawalAdmin(@Path("id") int id);

  @PUT("admin/request_withdrawals/{id}")
  Future<RequestWithdrawalsRes> verifyWithdrawal(
    @Path("id") int id,
    @Body() Map<String, dynamic> body,
  );

  @DELETE("admin/request_withdrawals/{id}")
  Future<SuccessResponse> deleteWithdrawal(
    @Path("id") int id,
  );

  /////////Referral Admin

  @GET("admin/referrals")
  Future<AllUserRes> getAllReferral(
    @Query("page") int page,
  );

  @GET("admin/referrals/referred/{code}")
  Future<AllUserRes> getAllUserReferral(
      @Query("page") int page, @Path("code") String? code);

  @GET("admin/history_balance_change_collaborator/{id}")
  Future<AllWalletHistoryRes> getAllHistoriesCollaborator(
      @Query("page") int numberPage, @Path("id") int? id);

  @GET("admin/history_receive_commission")
  Future<AllHistoryReceiveCommissionRes> getAllHistoryReceiveCommission(
    @Query("page") int page,
  );

  //device token

  @POST("device_token_user")
  Future<SuccessResponse> sendDeviceToken(
    @Body() Map<String, dynamic> body,
  );

  /////potential user
  @GET("user/manage/potential_user")
  Future<AllPotentialUserRes> getAllPotentialUser(
    @Query("page") int page,
    @Query("status") int? status,
    @Query("search") String? textSearch,
  );

  @GET("user/manage/potential_user/{id}")
  Future<PotentialUserRes> getPotentialUser(@Path("id") int id);

  @GET("user/manage/history_potential_user")
  Future<AllHistoryPotentialRes> getAllHistoryPotential(
    @Query("page") int page,
    @Query("user_guest_id") int? userGuestId,
  );

  @PUT("user/manage/potential_user/{id}")
  Future<PotentialUserRes> updatePotentialUser(
    @Path("id") int idPotential,
    @Body() Map<String, dynamic> body,
  );

  @POST("user/community/potential_user")
  Future<PotentialUserRes> addPotentialUser(
    @Body() Map<String, dynamic> body,
  );

  @DELETE("user/manage/potential_user/{id}")
  Future<SuccessResponse> deletePotentialUser(
    @Path("id") int idPotential,
  );

  @GET("user/manage/towers")
  Future<AllTowerRes> getAllTower(
    @Query("page") int page,
    @Query("search") String? search,
  );

  @POST("user/manage/towers")
  Future<TowerRes> addTower(
    @Body() Map<String, dynamic> body,
  );

  @GET("user/manage/towers/{id}")
  Future<TowerRes> getTower(
    @Path("id") int towerId,
  );

  @PUT("user/manage/towers/{id}")
  Future<TowerRes> updateTower(
    @Path("id") int towerId,
    @Body() Map<String, dynamic> body,
  );

  @DELETE("user/manage/towers/{id}")
  Future<SuccessResponse> deleteTower(
    @Path("id") int towerId,
  );

  ///////customer post manage
  @GET("user/community/mo_post_roommates")
  Future<AllPostRoommateRes> getAllPostRoommate(
    @Query("page") int page,
    @Query("search") String? search,
    @Query("wards") int? wards,
    @Query("district") int? district,
    @Query("province") int? province,
    @Query("has_pet") bool? hasPet,
    @Query("has_tivi") bool? hasTivi,
    @Query("has_wc") bool? hasWc,
    @Query("has_window") bool? hasWindow,
    @Query("has_security") bool? hasSecurity,
    @Query("has_free_move") bool? hasFreeMove,
    @Query("has_own_owner") bool? hasOwnOwner,
    @Query("has_air_conditioner") bool? hasAirConditioner,
    @Query("has_water_heater") bool? hasWaterHeater,
    @Query("has_kitchen") bool? hasKitchen,
    @Query("has_fridge") bool? hasFridge,
    @Query("has_washing_machine") bool? hasWashingMachine,
    @Query("has_mezzanine") bool? hasMezzanine,
    @Query("has_bed") bool? hasBed,
    @Query("has_wardrobe") bool? hasWardrobe,
    @Query("has_balcony") bool? hasBalcony,
    @Query("has_finger_print") bool? hasFingerprint,
    @Query("has_kitchen_stuff") bool? hasKitchenStuff,
    @Query("has_ceiling_fans") bool? hasCeilingFans,
    @Query("has_curtain") bool? hasCurtain,
    @Query("has_decorative_lights") bool? hasDecorativeLights,
    @Query("has_mattress") bool? hasMattress,
    @Query("has_mirror") bool? hasMirror,
    @Query("has_sofa") bool? hasSofa,
    @Query("has_picture") bool? hasPicture,
    @Query("has_pillow") bool? hasPillow,
    @Query("has_table") bool? hasTable,
    @Query("has_shoes_rasks") bool? hasShoesRacks,
    @Query("has_tree") bool? hasTree,
    @Query("money_from") double? fromMoney,
    @Query("money_to") double? maxMoney,
    @Query("descending") bool? descending,
    @Query("sort_by") String? sortBy,
    @Query("phone_number") String? phoneNumber,
    @Query("list_type") String? listType,
    @Query("status") int? status,
    @Query("is_all") bool? isAll,
  );

  @GET("user/community/mo_post_roommates/{id}")
  Future<PostRoommateRes> getPostRoommate(
    @Path("id") int postRoommateId,
  );

  @POST("user/community/mo_post_roommates")
  Future<PostRoommateRes> addPostRoommate(
    @Body() Map<String, dynamic> body,
  );

  @PUT("user/community/mo_post_roommates/{id}")
  Future<PostRoommateRes> updatePostRoommate(
    @Path("id") int postRoommateId,
    @Body() Map<String, dynamic> body,
  );

  @GET("user/community/mo_post_find_motels")
  Future<AllPostFindRoomRes> getAllPostFindRoom(
    @Query("page") int page,
    @Query("status") int? status,
    @Query("province") int? province,
    @Query("district") int? district,
    @Query("wards") int? wards,
    @Query("search") String? search,
    @Query("is_all") bool? isAll,
    @Query("phone_number") String? phoneNumber,
    @Query("has_pet") bool? hasPet,
    @Query("has_tivi") bool? hasTivi,
    @Query("has_wc") bool? hasWc,
    @Query("has_window") bool? hasWindow,
    @Query("has_security") bool? hasSecurity,
    @Query("has_free_move") bool? hasFreeMove,
    @Query("has_own_owner") bool? hasOwnOwner,
    @Query("has_air_conditioner") bool? hasAirConditioner,
    @Query("has_water_heater") bool? hasWaterHeater,
    @Query("has_kitchen") bool? hasKitchen,
    @Query("has_fridge") bool? hasFridge,
    @Query("has_washing_machine") bool? hasWashingMachine,
    @Query("has_mezzanine") bool? hasMezzanine,
    @Query("has_bed") bool? hasBed,
    @Query("has_wardrobe") bool? hasWardrobe,
    @Query("has_balcony") bool? hasBalcony,
    @Query("has_finger_print") bool? hasFingerprint,
    @Query("has_kitchen_stuff") bool? hasKitchenStuff,
    @Query("has_ceiling_fans") bool? hasCeilingFans,
    @Query("has_curtain") bool? hasCurtain,
    @Query("has_decorative_lights") bool? hasDecorativeLights,
    @Query("has_mattress") bool? hasMattress,
    @Query("has_mirror") bool? hasMirror,
    @Query("has_sofa") bool? hasSofa,
    @Query("has_picture") bool? hasPicture,
    @Query("has_pillow") bool? hasPillow,
    @Query("has_table") bool? hasTable,
    @Query("has_shoes_rasks") bool? hasShoesRacks,
    @Query("has_tree") bool? hasTree,
    @Query("money_from") double? fromMoney,
    @Query("money_to") double? maxMoney,
    @Query("descending") bool? descending,
    @Query("sort_by") String? sortBy,
    @Query("list_type") String? listType,
  );

  @GET("user/community/mo_post_find_motels/{id}")
  Future<PostFindRoomRes> getPostFindRoom(
    @Path("id") int postFindRoomId,
  );

  @POST("user/community/mo_post_find_motels")
  Future<PostFindRoomRes> addPostFindRoom(
    @Body() Map<String, dynamic> body,
  );

  @PUT("user/community/mo_post_find_motels/{id}")
  Future<PostFindRoomRes> updatePostFindRoom(
    @Path("id") int postFindRoomId,
    @Body() Map<String, dynamic> body,
  );

  ////admin post
  @GET("admin/mo_post_find_motels")
  Future<AllPostFindRoomRes> getAllAdminPostFindRoom(
    @Query("page") int page,
    @Query("status") int? status,
  );

  @GET("admin/mo_post_find_motels/{id}")
  Future<PostFindRoomRes> getAdminPostFindRoom(
    @Path("id") int postFindRoomId,
  );

  @PUT("admin/mo_post_find_motels/{id}")
  Future<PostFindRoomRes> updateAdminPostFindRoom(
    @Path("id") int postFindRoomId,
    @Body() Map<String, dynamic> body,
  );

  @PUT("admin/mo_post_find_motels/{id}/update_status")
  Future<PostFindRoomRes> updateStatusAdminPostFindRoom(
    @Path("id") int postFindRoomId,
    @Body() Map<String, dynamic> body,
  );

  @DELETE("admin/mo_post_find_motels/{id}")
  Future<SuccessResponse> deleteAdminPostFindRoom(
    @Path("id") int postFindRoomId,
  );

  ///
  @GET("admin/mo_post_roommates")
  Future<AllPostRoommateRes> getAllAdminPostRoommate(
    @Query("page") int page,
    @Query("status") int? status,
  );

  @GET("admin/mo_post_roommates/{id}")
  Future<PostRoommateRes> getAdminPostRoommate(
    @Path("id") int postFindRoomId,
  );

  @PUT("admin/mo_post_roommates/{id}")
  Future<PostRoommateRes> updateAdminPostRoommate(
    @Path("id") int postFindRoomId,
    @Body() Map<String, dynamic> body,
  );

  @PUT("admin/mo_post_roommates/{id}/update_status")
  Future<PostRoommateRes> updateStatusAdminPostRoommate(
    @Path("id") int postFindRoomId,
    @Body() Map<String, dynamic> body,
  );

  @DELETE("admin/mo_post_roommates/{id}")
  Future<SuccessResponse> deleteAdminPostRoommate(
    @Path("id") int postFindRoomId,
  );

  ///report post find room and post roommate
  @POST("user/community/report_post_find_motel_violations")
  Future<ReportPostFindRoomRes> reportPostFindRoom(
    @Body() Map<String, dynamic> body,
  );

  @POST("user/community/report_post_find_motel_violations")
  Future<ReportPostRoommateRes> reportPostRoommate(
    @Body() Map<String, dynamic> body,
  );

  @DELETE("device_token_user")
  Future<SuccessResponse> deleteToken(
    @Body() Map<String, dynamic> body,
  );

  @POST("admin/config_admins")
  Future<AdminConfigRes> addConfig(
    @Body() Map<String, dynamic> body,
  );

  @GET("user/config_admins")
  Future<AdminConfigRes> getAdminConfig();

  @GET("admin/category_service_sells")
  Future<AllCategoryRes> getAllAdminCategory(
    @Query("page") int page,
  );

  @POST("admin/category_service_sells")
  Future<CategoryRes> addCategory(
    @Body() Map<String, dynamic> body,
  );

  @GET("admin/category_service_sells/{id}")
  Future<CategoryRes> getAdminCategory(
    @Path("id") int categoryId,
  );

  @PUT("admin/category_service_sells/{id}")
  Future<CategoryRes> updateAdminCategory(
    @Path("id") int categoryId,
    @Body() Map<String, dynamic> body,
  );

  @DELETE("admin/category_service_sells/{id}")
  Future<SuccessResponse> deleteAdminCategory(
    @Path("id") int categoryId,
  );

  @GET("user/community/category_service_sells")
  Future<AllCategoryRes> getAllCategory(
    @Query("page") int page,
  );

  @PUT("user/community/order_service_sells/{orderCode}")
  Future<OrderRes> updateStatusOrder(
    @Path("orderCode") String orderCode,
    @Body() Map<String, dynamic> body,
  );

  @GET("user/community/address_additions")
  Future<AllAddressOrderRes> getAllAddressOrder(
    @Query("page") int page,
  );

  @POST("user/community/order_service_sells/send_immediate")
  Future<OrderRes> orderImmediate(
    @Body() Map<String, dynamic> body,
  );

  @GET("user/noti_unread")
  Future<AllNotiUserRes> getAllNotiUser(
    @Query("user_ids") String userIds,
  );

  @POST("user/community/order_service_sells/{orderCode}/reorder")
  Future<OrderRes> reOrder(
    @Path("orderCode") String orderCode,
  );

  @GET("user/manage/supporter_manage_towers")
  Future<AllSupportManageTowerRes> getAllSupportManageTower(
    @Query("page") int page,
  );

  @POST("user/manage/supporter_manage_towers")
  Future<SupportManageTowerRes> addSupportManageTower(
    @Body() Map<String, dynamic> body,
  );

  @GET("user/manage/supporter_manage_towers/{id}")
  Future<SupportManageTowerRes> getSupportManageTower(
    @Path("id") int supportId,
  );

  @PUT("user/manage/supporter_manage_towers/{id}")
  Future<SupportManageTowerRes> updateSupportManageTower(
    @Path("id") int supportId,
    @Body() Map<String, dynamic> body,
  );

  @DELETE("user/manage/supporter_manage_towers")
  Future<SuccessResponse> deleteSupportManageTower(
    @Body() Map<String, dynamic> body,
  );

  @DELETE("user/manage/supporter_manage_towers/delete_towers")
  Future<SuccessResponse> deleteTowerSupportManage(
    @Body() Map<String, dynamic> body,
  );

  @GET("user/manage/supporter_manage_motels")
  Future<AllMotelRoomRes> getAllMotelSupport(
    @Query("page") int numberPage,
    @Query("search") String? search,
    @Query("has_contract") bool? hasContract,
    @Query("status") int? status,
    @Query("has_post") bool? hasPost,
    @Query("tower_id") int? towerId,
    @Query("is_have_tower") bool? isHaveTower,
    @Query("limit") int? limit,
    @Query("floor_from") int? floorFrom,
    @Query("floor_to") int? floorTo,
    @Query("is_supporter_manage") bool? isSupporterManage,
    @Query("is_have_supporter") bool? isHaveSupperter,
    @Query("manage_supporter_id") int? manageSupporterId,
    @Query("is_supporter") bool? isSupporter,
  );

  /// Deposit List
  @GET("admin/deposits")
  Future<ListDepositsRes> getDepositHistoryData(@Query("page") int page);

  /// Withdraw List
  @GET("admin/withdraws")
  Future<ListWithdrawsRes> getWithdrawHistoryData(@Query("page") int page);

  ///Renter Registration
  @POST("admin/renters")
  Future<ResponseModel> renterRegistration(
    @Body() Map<String, dynamic> body,
  );

  ///Master Registration
  @POST("admin/masters")
  Future<ResponseModel> masterRegistration(
    @Body() Map<String, dynamic> body,
  );

  @POST("deposits")
  Future<DepositRes> createDepositRequest(
    @Body() Map<String, dynamic> body,
  );

  @GET("getUserBankListbyUserId/{id}")
  Future<ListBankInfoRes> getListBankUser(
      @Query("page") int page, @Path("id") int userId);

  @POST("admin/withdraws")
  Future<WithdrawRes> createWithdrawRequest(
    @Body() Map<String, dynamic> body,
  );

  /// Payment Create
  @POST("/payments-create")
  Future<ResponseModel> paymentCreate(
    @Body() Map<String, dynamic> body,
  );

  /// Get inquire
  @GET("/inquire")
  Future<InquireHistoryModel> getInquireHistoryData();

  /// Refunds Create
  @POST("/refunds-create")
  Future<ResponseModel> refundsCreate(
    @Body() Map<String, dynamic> body,
  );

  /// Get result
  @GET("/result")
  Future<ResultHistoryModel> getResultHistoryData();

  @GET("admin/dashboard")
  Future<DashboardRes> getDashboard();

  /// Deposit List
  @GET("admin/getAllWalletDeposit/{id}")
  Future<ListDepositsRes> getUserDepositHistory(
      @Query("page") int page, @Path("id") int userId);

  /// Withdraw List
  @GET("admin/getAllWalletWithdraw/{id}")
  Future<ListWithdrawsRes> getUserWithdrawHistory(
      @Query("page") int page, @Path("id") int userId);

  @POST("admin/confirm-payment-status")
  Future<WithdrawRes> confirmPaymentStatus(
    @Body() Map<String, dynamic> body,
  );

  @GET("admin/wallet-data-for-graph")
  Future<GraphRes> getDataForGraph(
    @Query("year") int? year,
    @Query("type") String? type,
  );
}

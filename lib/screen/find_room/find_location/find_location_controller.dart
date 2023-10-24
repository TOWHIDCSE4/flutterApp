import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import '../../../components/arlert/saha_alert.dart';
import '../../../data/remote/response-request/manage/motel_post_req.dart';
import '../../../data/remote/response-request/room_post/location_find_req.dart';
import '../../../data/repository/repository_manager.dart';
import '../../../model/location_address.dart';
import '../../../model/motel_post.dart';
import '../../choose_address_customer_screen/choose_address_customer_controller.dart';

class FindLocationController extends GetxController {
  var listAllRoomPost = RxList<MotelPost>();
  var changeHeight = 35.0.obs;
  var opacity = .0.obs;
  int currentPage = 1;
  bool isEnd = false;
  var isLoading = false.obs;
  String? textSearch;
  double? fromMoney;
  double? maxMoney;
  String? phoneNumber;
  var loading = false.obs;
  var motelPostFilter = MotelPostReq().obs;
  var heightFilter = 50.0.obs;
  var locationProvince = LocationAddress().obs;
  var locationDistrict = LocationAddress().obs;
  var locationWard = LocationAddress().obs;
  var locationFindReq = LocationFindReq().obs;

  void changeOpacitySearch(double va) {
    opacity.value = va;
  }

  void changeHeightAppbar(double va) {
    changeHeight.value = va;
  }

  TypeAddress? typeAddress;
  LocationAddress? locationProvinceInput;
  LocationAddress? locationDistrictInput;

  String location = 'Null, Press Button';
  var address = ''.obs;

  FindLocationController(
      {this.typeAddress,
      this.locationDistrictInput,
      this.locationProvinceInput,
      this.phoneNumber}) {
    if (locationDistrictInput != null) {
      locationDistrict.value = locationDistrictInput!;
    }

    if (locationProvinceInput != null) {
      locationProvince.value = locationProvinceInput!;
    }
    initFind();
    //getAllRoomPost(isRefresh: true);
  }

  void initFind() async {
    loading.value = true;
    Position position = await _getGeoLocationPosition();
    location = 'Lat: ${position.latitude} , Long: ${position.longitude}';
    GetAddressFromLatLong(position);
  }

  Future<Position> _getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      SahaAlert.showError(message: 'Chưa bật dịch vụ định vị');
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        SahaAlert.showError(
            message: 'Thiết bị chưa cho phép quyền truy cập vị trí');
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      SahaAlert.showError(
          message:
              'Quyền vị trí bị từ chối vĩnh viễn, chúng tôi không thể yêu cầu quyền');
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  Future<void> GetAddressFromLatLong(Position position) async {
    try {
      List<Placemark> placeMarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      if (placeMarks.isNotEmpty) {
        print(placeMarks);
        Placemark place = placeMarks[0];
        address.value =
            '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.locality}, ${place.country}';
        locationFindReq(LocationFindReq(
          name: place.name,
          street: place.street,
          isoCountryCode: place.isoCountryCode,
          country: place.country,
          postalcode: place.postalCode,
          administrativeArea: place.administrativeArea,
          subadministrativeArea: place.subAdministrativeArea,
          locality: place.locality,
          sublocality: place.subLocality,
          thoroughfare: place.thoroughfare,
          subthoroughfare: place.subThoroughfare,
        ));
        getAllMoPostLocationFind(isRefresh: true);
      }
    } catch (err) {
      SahaAlert.showError(message: "Không thể tìm thấy vị");
    }

    print(address.value);
    loading.value = false;
  }

  Future<void> getAllMoPostLocationFind({
    bool? isRefresh,
  }) async {
    if (isRefresh == true) {
      currentPage = 1;
      isEnd = false;
    }

    try {
      if (isEnd == false) {
        isLoading.value = true;
        var data = await RepositoryManager.roomPostRepository
            .getAllMoPostLocationFind(
                page: currentPage, locationFindReq: locationFindReq.value);
        if (isRefresh == true) {
          listAllRoomPost(data!.data!.data!);
          listAllRoomPost.refresh();
        } else {
          listAllRoomPost.addAll(data!.data!.data!);
        }

        if (data.data!.nextPageUrl == null) {
          isEnd = true;
        } else {
          isEnd = false;
          currentPage = currentPage + 1;
        }
      }
      isLoading.value = false;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }
}

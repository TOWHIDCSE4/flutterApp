import 'package:get/get.dart';

import '../../../../components/arlert/saha_alert.dart';
import '../../../../data/repository/repository_manager.dart';
import '../../../../model/motel_post.dart';

class FavouriteDetailsController extends GetxController {
  var isLoading = false.obs;
  var isLoading2 = false.obs;
  var roomPost = MotelPost().obs;
  int roomPostId;
  int currentPage = 1;
  bool isEnd = false;
  var isFavourite = true.obs;
  var listSimilarPost = RxList<MotelPost>();
  var hourOpen = DateTime(0, 0, 0, 0, 0, 0).obs;
  var hourClose = DateTime(0, 0, 0, 0, 0, 0).obs;
  FavouriteDetailsController({required this.roomPostId}) {
    getRoomPost();
    getAllRoomPostSimilar(isRefresh: true);
  }

  Future<void> getRoomPost() async {
    isLoading.value = true;
    try {
      var res = await RepositoryManager.roomPostRepository
          .getRoomPost(roomPostId: roomPostId);
      roomPost.value = res!.data!;
      hourOpen.value = DateTime(0, 0, 0, roomPost.value.hourOpen ?? 0,
          roomPost.value.minuteOpen ?? 0);
      hourClose.value = DateTime(0, 0, 0, roomPost.value.hourClose ?? 0,
          roomPost.value.minuteClose ?? 0);
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isLoading.value = false;
  }

  Future<void> setFavouritePost({required int id}) async {
    try {
      var res = await RepositoryManager.userManageRepository
          .setFavouritePost(id: id, isFavourite: isFavourite.value);
      if (isFavourite == true) {
        SahaAlert.showSuccess(message: "Đã thêm vào bài đăng yêu thích");
      } else {
        SahaAlert.showSuccess(message: "Đã bỏ bài đăng yêu thích");
      }
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> getAllRoomPostSimilar({
    bool? isRefresh,
  }) async {
    if (isRefresh == true) {
      currentPage = 1;
      isEnd = false;
    }

    try {
      if (isEnd == false) {
        isLoading2.value = true;
        var data =
            await RepositoryManager.roomPostRepository.getAllRoomPostSimilar(
          page: currentPage,
          postId: roomPostId,
        );
        if (isRefresh == true) {
          listSimilarPost(data!.data!.data!);
          listSimilarPost.refresh();
        } else {
          listSimilarPost.addAll(data!.data!.data!);
        }

        if (data.data!.nextPageUrl == null) {
          isEnd = true;
        } else {
          isEnd = false;
          currentPage = currentPage + 1;
        }
      }
      isLoading2.value = false;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }
}

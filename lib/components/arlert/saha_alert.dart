import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart' as FLToast;
import 'package:get/get.dart';

class SahaAlert {
  static void showError(
      {String? message, Color? color, Color? textColor}) async {
    FLToast.Fluttertoast.showToast(
      msg: message!,
      toastLength: FLToast.Toast.LENGTH_SHORT,
      gravity: FLToast.ToastGravity.CENTER,
      timeInSecForIosWeb: 3,

      backgroundColor: color ?? Colors.red,
      textColor: textColor ?? Colors.white,
      fontSize: 16.0,
    );
  }

  static void showWarning({
    String message = "",
    String title = "Saha",
  }) {
    FLToast.Fluttertoast.showToast(msg: message);
    // showFlash(
    //   duration: Duration(milliseconds: 2000),
    //   context: Get.context!,
    //   builder: (_, controller) {
    //     return Flash(
    //       controller: controller,
    //       position: FlashPosition.bottom,
    //       borderRadius: BorderRadius.circular(8.0),
    //       borderColor: Colors.amber,
    //       boxShadows: kElevationToShadow[8],
    //       backgroundGradient: RadialGradient(
    //         colors: [Colors.black87, Colors.black87],
    //         center: Alignment.topLeft,
    //         radius: 2,
    //       ),
    //       onTap: () => controller.dismiss(),
    //       forwardAnimationCurve: Curves.easeInCirc,
    //       reverseAnimationCurve: Curves.bounceIn,
    //       child: DefaultTextStyle(
    //         style: TextStyle(color: Colors.white),
    //         child: FlashBar(
    //           title: Text('$title'),
    //           content: Text('$message'),
    //           indicatorColor: Colors.yellow,
    //           icon: Icon(Icons.info_outline),
    //           primaryAction: TextButton(
    //             onPressed: () => controller.dismiss(),
    //             child: Text('Đóng'),
    //           ),
    //         ),
    //       ),
    //     );
    //   },
    // );
  }

  static void showSuccess({
    String message = "",
    String title = "Saha",
  }) {
    FLToast.Fluttertoast.showToast(msg: message,
      toastLength: FLToast.Toast.LENGTH_SHORT,
      gravity: FLToast.ToastGravity.CENTER,
      timeInSecForIosWeb: 2,

      backgroundColor:Colors.green,
      textColor:  Colors.white,
      fontSize: 16.0,
    );
    // showFlash(
    //   duration: Duration(milliseconds: 1000),
    //   context: Get.context!,
    //   builder: (_, controller) {
    //     return Flash(
    //       controller: controller,
    //       position: FlashPosition.bottom,
    //       borderRadius: BorderRadius.circular(8.0),
    //       borderColor: Colors.blue,
    //       boxShadows: kElevationToShadow[8],
    //       backgroundGradient: RadialGradient(
    //         colors: [Colors.black87, Colors.black87],
    //         center: Alignment.topLeft,
    //         radius: 2,
    //       ),
    //       onTap: () => controller.dismiss(),
    //       forwardAnimationCurve: Curves.easeInCirc,
    //       reverseAnimationCurve: Curves.bounceIn,
    //       child: DefaultTextStyle(
    //         style: TextStyle(color: Colors.white),
    //         child: FlashBar(
    //           title: Text('$title'),
    //           content: Text('$message'),
    //           indicatorColor: Colors.green,
    //           icon: Icon(Icons.check),
    //         ),
    //       ),
    //     );
    //   },
    // );
  }

  static void showBasicsFlash(
    String message, {
    Duration? duration,
  }) {
    showFlash(
      context: Get.context!,
      duration: duration,
      builder: (context, controller) {
        return Flash(
          controller: controller,
          boxShadows: kElevationToShadow[4],
          position: FlashPosition.bottom,
          horizontalDismissDirection: HorizontalDismissDirection.horizontal,
          child: FlashBar(
            content: Text(message),
          ),
        );
      },
    );
  }

  void showNotificationTopFlash(String? title, String? body, BuildContext context) {
    showFlash(
      duration: const Duration(milliseconds: 3500),
      context:context,
      persistent: true,
      builder: (_, controller) {
        return Flash(
          controller: controller,
          borderRadius: BorderRadius.circular(8.0),
          borderColor: Colors.green,
          boxShadows: kElevationToShadow[8],
          position: FlashPosition.bottom,
          behavior: FlashBehavior.floating,
          backgroundGradient: const RadialGradient(
            colors: [Colors.white, Colors.white],
            center: Alignment.topLeft,
            radius: 2,
          ),
          onTap: () => controller.dismiss(),
          forwardAnimationCurve: Curves.easeInCirc,
          reverseAnimationCurve: Curves.bounceIn,
          child: DefaultTextStyle(
            style: const TextStyle(color: Colors.black87),
            child: FlashBar(
              title: Text('$title'),
              content: Text('$body'),
              indicatorColor: Colors.green,
              icon: const Icon(Icons.notifications_active),
              primaryAction: TextButton(
                onPressed: () => controller.dismiss(),
                child: const Text('Đóng'),
              ),
            ),
          ),
        );
      },
    );
  }

  static void showTopFlash() {
    showFlash(
      context: Get.context!,
      duration: const Duration(seconds: 2),
      persistent: false,
      builder: (_, controller) {
        return Flash(
          controller: controller,
          backgroundColor: Colors.white,
          brightness: Brightness.light,
          boxShadows: const [BoxShadow(blurRadius: 4)],
          barrierBlur: 3.0,
          barrierColor: Colors.black38,
          barrierDismissible: true,
          position: FlashPosition.top,
          child: FlashBar(
            title: const Text('Title'),
            content: const Text('Hello world!'),
            showProgressIndicator: true,
            primaryAction: TextButton(
              onPressed: () => controller.dismiss(),
              child: const Text('Đóng', style: TextStyle(color: Colors.amber)),
            ),
          ),
        );
      },
    );
  }

  static void showBottomFlash(
      {bool persistent = true, EdgeInsets margin = EdgeInsets.zero}) {
    showFlash(
      context: Get.context!,
      persistent: persistent,
      builder: (_, controller) {
        return Flash(
          controller: controller,
          margin: margin,
          position: FlashPosition.bottom,
          borderRadius: BorderRadius.circular(8.0),
          borderColor: Colors.blue,
          boxShadows: kElevationToShadow[8],
          backgroundGradient: const RadialGradient(
            colors: [Colors.amber, Colors.black87],
            center: Alignment.topLeft,
            radius: 2,
          ),
          onTap: () => controller.dismiss(),
          forwardAnimationCurve: Curves.easeInCirc,
          reverseAnimationCurve: Curves.bounceIn,
          child: DefaultTextStyle(
            style: const TextStyle(color: Colors.white),
            child: FlashBar(
              title: const Text('Hello Flash'),
              content: const Text('You can put any message of any length here.'),
              indicatorColor: Colors.red,
              icon: const Icon(Icons.info_outline),
              primaryAction: TextButton(
                onPressed: () => controller.dismiss(),
                child: const Text('Đóng'),
              ),
              actions: <Widget>[
                TextButton(
                    onPressed: () => controller.dismiss('Yes, I do!'),
                    child: const Text('YES')),
                TextButton(
                    onPressed: () => controller.dismiss('No, I do not!'),
                    child: const Text('NO')),
              ],
            ),
          ),
        );
      },
    ).then((_) {
      if (_ != null) {
        _showMessage(_.toString());
      }
    });
  }

  static void showInputFlash({
    bool persistent = true,
    WillPopCallback? onWillPop,
  }) {
    var editingController = TextEditingController();
    showFlash(
      context: Get.context!,
      persistent: persistent,
      onWillPop: onWillPop,
      builder: (_, controller) {
        return Flash.bar(
          controller: controller,
          position: FlashPosition.bottom,
          barrierColor: Colors.black54,
          borderWidth: 3,
          forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
          child: FlashBar(
            title: const Text('Hello Flash', style: TextStyle(fontSize: 24.0)),
            content: Column(
              children: [
                const Text('You can put any message of any length here.'),
                Form(
                  child: TextFormField(
                    controller: editingController,
                    autofocus: true,
                  ),
                ),
              ],
            ),
            indicatorColor: Colors.red,
            primaryAction: IconButton(
              onPressed: () {
                if (editingController.text.isEmpty) {
                  controller.dismiss();
                } else {
                  var message = editingController.text;
                  _showMessage(message);
                  editingController.text = '';
                }
              },
              icon: const Icon(Icons.send, color: Colors.amber),
            ),
          ),
        );
      },
    );
  }

  static void showCenterFlash({
    FlashPosition? position,
    Alignment? alignment,
  }) {
    showFlash(
      context: Get.context!,
      duration: const Duration(seconds: 5),
      builder: (_, controller) {
        return Flash(
          controller: controller,
          backgroundColor: Colors.black87,
          borderRadius: BorderRadius.circular(8.0),
          borderColor: Colors.blue,
          position: position,
          alignment: alignment,
          onTap: () => controller.dismiss(),
          child: const Padding(
            padding: EdgeInsets.all(12.0),
            child: DefaultTextStyle(
              style: TextStyle(color: Colors.white),
              child: Text(
                'You can put any message of any length here.',
              ),
            ),
          ),
        );
      },
    ).then((_) {
      if (_ != null) {
        _showMessage(_.toString());
      }
    });
  }

  static void _showMessage(String message) {
    showFlash(
        context: Get.context!,
        duration: const Duration(seconds: 3),
        builder: (_, controller) {
          return Flash(
            controller: controller,
            position: FlashPosition.top,
            child: FlashBar(
              icon: const Icon(
                Icons.face,
                size: 36.0,
                color: Colors.black,
              ),
              content: Text(message),
            ),
          );
        });
  }

  static void showToastMiddle(
      {String? message, Color? color, Color? textColor}) {
    FLToast.Fluttertoast.showToast(
        msg: message!,
        toastLength: FLToast.Toast.LENGTH_SHORT,
        gravity: FLToast.ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: color ?? Colors.red,
        textColor: textColor ?? Colors.white,
        fontSize: 16.0);
  }
}

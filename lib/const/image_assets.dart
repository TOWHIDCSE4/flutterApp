class ImageAssets {
  const ImageAssets._();

  //::::::::::::::::::::::::::::::: Image ASSETS :::::::::::::::::::::::::::::::
  static String get imgCard => 'card'.png;
  static String get imgFrontCard => 'front_card'.png;
  static String get imgBackCard => 'back_card'.png;
  static String get imgCaptureImage => 'capture_image'.png;
  static String get tickCircle => 'tick_circle'.png;
  static String get paymentProcessing => 'processing'.png;
  static String get renren => 'renren'.png;
  static String get goldCoin => 'gold_coin'.png;
  static String get silverCoin => 'silver_coin'.png;
  static String get imgRobot1 => 'img_robot1'.png;
  static String get imgRobot2 => 'img_robot2'.png;
  // static String get imgSummary => 'img_summary'.png;
  static String get imgBanner => 'img_banner'.png;
  static String get imgDeposit => 'deposit'.png;
  static String get imgWithdraw => 'withdraw'.png;
  static String get logoBee => 'logo_bee'.png;
  //::::::::::::::::::::::::::::::: ICON ASSETS ::::::::::::::::::::::::::::::::
  static String get icBank1 => 'ic_bank1'.png;
  static String get editIcon => 'edit_icon'.svg;
  static String get profileCamera => 'profile_camera'.svg;
  static String get icTick => 'tick'.svg;
  static String get icCross => 'cross'.svg;
  static String get curvedButton => 'curved_button'.svg;
  static String get paymentSuccessful => 'payment_successful'.png;
}

extension on String {
  String get png => 'assets/images/$this.png';
  String get svg => 'assets/images/$this.svg';
}


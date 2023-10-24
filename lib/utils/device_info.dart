class DeviceInfo {
  static final DeviceInfo _singleton = DeviceInfo._internal();

  factory DeviceInfo() {
    return _singleton;
  }

  DeviceInfo._internal();

  String? deviceCode;

}
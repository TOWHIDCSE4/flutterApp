
class FlowData {
  static final FlowData _singleton = FlowData._internal();

  bool _isOnline = false;

  factory FlowData() {
    return _singleton;
  }

  void setIsOnline(bool status) {
    _isOnline = status;
  }

  bool getStatusData() {
    return _isOnline;
  }

  FlowData._internal();

  isOnline() {
    return _isOnline;
  }
}

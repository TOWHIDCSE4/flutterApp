class UploadImageResponse {
  int? code;
  bool? success;
  String? msgCode;
  String? data;

  UploadImageResponse({this.code, this.success, this.msgCode, this.data});

  UploadImageResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    success = json['success'];
    msgCode = json['msg_code'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['success'] = success;
    data['msg_code'] = msgCode;
    data['data'] = this.data;
    return data;
  }
}
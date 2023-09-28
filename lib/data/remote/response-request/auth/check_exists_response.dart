class ExistsLoginResponse {
  int? code;
  bool? success;
  String? msgCode;
  String? msg;
  List<ExistsLogin>? data;

  ExistsLoginResponse(
      {this.code, this.success, this.msgCode, this.msg, this.data});

  ExistsLoginResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    success = json['success'];
    msgCode = json['msg_code'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data!.add(ExistsLogin.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['success'] = success;
    data['msg_code'] = msgCode;
    data['msg'] = msg;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ExistsLogin {
  String? name;
  bool? value;

  ExistsLogin({this.name, this.value});

  ExistsLogin.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['value'] = value;
    return data;
  }
}
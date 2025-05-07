import 'record.dart';

class UserVo {
  UserVo({
    this.status,
    this.message,
    this.id,
    this.token,
    this.role,
    this.record,
  });

  UserVo.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    id = json['id'];
    token = json['token'];
    role = json['role'];
    record = json['record'] != null ? Record.fromJson(json['record']) : null;
  }

  int? status;
  String? message;
  String? id;
  String? token;
  String? role;
  Record? record;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    map['id'] = id;
    map['token'] = token;
    map['role'] = role;
    if (record != null) {
      map['record'] = record?.toJson();
    }
    return map;
  }
}

import 'language.dart';
import 'parent_childs.dart';

class Record {
  Record({
    this.id,
    this.role,
    this.username,
    this.dateFormat,
    this.timezone,
    this.schName,
    this.currencySymbol,
    this.language,
    this.isRtl,
    this.theme,
    this.image,
    this.startWeek,
    this.parentChilds,
  });

  Record.fromJson(dynamic json) {
    id = json['id'];
    role = json['role'];
    username = json['username'];
    dateFormat = json['date_format'];
    timezone = json['timezone'];
    schName = json['sch_name'];
    currencySymbol = json['currency_symbol'];
    language =
        json['language'] != null ? Language.fromJson(json['language']) : null;
    isRtl = json['is_rtl'];
    theme = json['theme'];
    image = json['image'];
    startWeek = json['start_week'];
    if (json['parent_childs'] != null) {
      parentChilds = [];
      json['parent_childs'].forEach((v) {
        parentChilds?.add(ParentChilds.fromJson(v));
      });
    }
    studentId = json['student_id'];
    classname = json['class'];
    section = json['section'];
  }

  String? id;
  String? role;
  String? username;
  String? dateFormat;
  String? timezone;
  String? schName;
  String? currencySymbol;
  Language? language;
  String? isRtl;
  String? theme;
  String? image;
  String? startWeek;
  List<ParentChilds>? parentChilds;
  String? studentId;
  String? classname;
  String? section;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['role'] = role;
    map['username'] = username;
    map['date_format'] = dateFormat;
    map['timezone'] = timezone;
    map['sch_name'] = schName;
    map['currency_symbol'] = currencySymbol;
    if (language != null) {
      map['language'] = language?.toJson();
    }
    map['is_rtl'] = isRtl;
    map['theme'] = theme;
    map['image'] = image;
    map['start_week'] = startWeek;
    if (parentChilds != null) {
      map['parent_childs'] = parentChilds?.map((v) => v.toJson()).toList();
    }
    map['student_id'] = studentId;
    map['class'] = classname;
    map['section'] = section;
    return map;
  }
}

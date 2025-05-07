import 'dart:convert';

class ParentChilds {
  ParentChilds(
      {this.studentId,
      this.classname,
      this.section,
      this.classId,
      this.sectionId,
      this.name,
      this.image,
      this.grno});

  ParentChilds.fromJson(dynamic json) {
    studentId = json['student_id'];
    classname = json['class'];
    section = json['section'];
    classId = json['class_id'];
    sectionId = json['section_id'];
    name = json['name'];
    image = json['image'];
    grno = json['grno'];
  }

  String? studentId;
  String? classname;
  String? section;
  String? classId;
  String? sectionId;
  String? name;
  String? image;
  String? grno;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['student_id'] = studentId;
    map['class'] = classname;
    map['section'] = section;
    map['class_id'] = classId;
    map['section_id'] = sectionId;
    map['name'] = name;
    map['image'] = image;
    map['grno'] = grno;
    return map;
  }

  static String encode(List<ParentChilds> parentChild) => json.encode(
        parentChild
            .map<Map<String, dynamic>>((parentChild) => parentChild.toJson())
            .toList(),
      );

  static List<ParentChilds> decode(String parentChild) =>
      (json.decode(parentChild) as List<dynamic>)
          .map<ParentChilds>((item) => ParentChilds.fromJson(item))
          .toList();
}

class Language {
  Language({
    this.langId,
    this.language,
  });

  Language.fromJson(dynamic json) {
    langId = json['lang_id'];
    language = json['language'];
  }

  String? langId;
  String? language;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['lang_id'] = langId;
    map['language'] = language;
    return map;
  }
}

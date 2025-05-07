import 'dart:convert';

class ConfigVo {
  String? url;
  String? siteUrl;
  String? appLogo;
  String? appprimaryColorCode;
  String? appSecondaryColorCode;
  String? langCode;
  String? privacyPolicy;

  ConfigVo(
      {this.url,
      this.siteUrl,
      this.appLogo,
      this.appprimaryColorCode,
      this.appSecondaryColorCode,
      this.langCode,
      this.privacyPolicy});

  factory ConfigVo.fromMap(Map<String, dynamic> data) => ConfigVo(
        url: data['url'] as String?,
        siteUrl: data['site_url'] as String?,
        appLogo: data['app_logo'] as String?,
        appprimaryColorCode: data['app_primary_color_code'] as String?,
        appSecondaryColorCode: data['app_secondary_color_code'] as String?,
        langCode: data['lang_code'] as String?,
        privacyPolicy: data['privacy_policy'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'url': url,
        'site_url': siteUrl,
        'app_logo': appLogo,
        'app_primary_color_code': appprimaryColorCode,
        'app_secondary_color_code': appSecondaryColorCode,
        'lang_code': langCode,
        'privacy_policy': privacyPolicy,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [ConfigVo].
  factory ConfigVo.fromJson(String data) {
    return ConfigVo.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [ConfigVo] to a JSON string.
  String toJson() => json.encode(toMap());
}

import 'package:coupon_app/domain/entities/ad_banner_entity.dart';

adBannerEntityFromJson(AdBannerEntity data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id'] is String
				? int.tryParse(json['id'])
				: json['id'].toInt();
	}
	if (json['ad_title'] != null) {
		data.adTitle = json['ad_title'].toString();
	}
	if (json['web_banner'] != null) {
		data.webBanner = json['web_banner'].toString();
	}
	if (json['mobile_banner'] != null) {
		data.mobileBanner = json['mobile_banner'].toString();
	}
	if (json['banner_link'] != null) {
		data.bannerLink = json['banner_link'].toString();
	}
	if (json['lang_type'] != null) {
		data.langType = json['lang_type'] is String
				? int.tryParse(json['lang_type'])
				: json['lang_type'].toInt();
	}
	if (json['country'] != null) {
		data.country = json['country'] is String
				? int.tryParse(json['country'])
				: json['country'].toInt();
	}
	return data;
}

Map<String, dynamic> adBannerEntityToJson(AdBannerEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['ad_title'] = entity.adTitle;
	data['web_banner'] = entity.webBanner;
	data['mobile_banner'] = entity.mobileBanner;
	data['banner_link'] = entity.bannerLink;
	data['lang_type'] = entity.langType;
	data['country'] = entity.country;
	return data;
}
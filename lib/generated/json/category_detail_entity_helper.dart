import 'package:coupon_app/domain/entities/category_detail_entity.dart';

categoryDetailEntityFromJson(CategoryDetailEntity data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id'] is String
				? int.tryParse(json['id'])
				: json['id'].toInt();
	}
	if (json['name'] != null) {
		data.name = json['name'].toString();
	}
	if (json['slug'] != null) {
		data.slug = json['slug'].toString();
	}
	if (json['mobile_image'] != null) {
		data.mobileImage = json['mobile_image'].toString();
	}
	if (json['website_image'] != null) {
		data.websiteImage = json['website_image'].toString();
	}
	if (json['lang_type'] != null) {
		data.langType = json['lang_type'] is String
				? int.tryParse(json['lang_type'])
				: json['lang_type'].toInt();
	}
	if (json['category'] != null) {
		data.category = json['category'] is String
				? int.tryParse(json['category'])
				: json['category'].toInt();
	}
	return data;
}

Map<String, dynamic> categoryDetailEntityToJson(CategoryDetailEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['name'] = entity.name;
	data['slug'] = entity.slug;
	data['mobile_image'] = entity.mobileImage;
	data['website_image'] = entity.websiteImage;
	data['lang_type'] = entity.langType;
	data['category'] = entity.category;
	return data;
}
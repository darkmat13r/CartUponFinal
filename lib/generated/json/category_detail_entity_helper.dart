import 'package:coupon_app/domain/entities/coupons/category_detail_entity.dart';

categoryDetailEntityFromJson(CategoryDetailEntity data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id'] is String
				? int.tryParse(json['id'])
				: json['id'].toInt();
	}
	if (json['name'] != null) {
		data.name = json['name'].toString();
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
	if (json['slug'] != null) {
		data.slug = json['slug'].toString();
	}
	if (json['category'] != null) {
		data.category = new CategoryDetailCategory().fromJson(json['category']);
	}
	return data;
}

Map<String, dynamic> categoryDetailEntityToJson(CategoryDetailEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['name'] = entity.name;
	data['mobile_image'] = entity.mobileImage;
	data['website_image'] = entity.websiteImage;
	data['lang_type'] = entity.langType;
	data['slug'] = entity.slug;
	if (entity.category != null) {
		data['category'] = entity.category.toJson();
	}
	return data;
}

categoryDetailCategoryFromJson(CategoryDetailCategory data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id'] is String
				? int.tryParse(json['id'])
				: json['id'].toInt();
	}
	if (json['category_title'] != null) {
		data.categoryTitle = json['category_title'].toString();
	}
	if (json['slug'] != null) {
		data.slug = json['slug'].toString();
	}
	return data;
}

Map<String, dynamic> categoryDetailCategoryToJson(CategoryDetailCategory entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['category_title'] = entity.categoryTitle;
	data['slug'] = entity.slug;
	return data;
}
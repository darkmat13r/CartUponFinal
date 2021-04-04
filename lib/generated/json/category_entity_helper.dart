import 'package:coupon_app/domain/entities/category_entity.dart';

categoryEntityFromJson(CategoryEntity data, Map<String, dynamic> json) {
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
		data.category = CategoryCategory().fromJson(json['category']);
	}
	return data;
}

Map<String, dynamic> categoryEntityToJson(CategoryEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['name'] = entity.name;
	data['mobile_image'] = entity.mobileImage;
	data['website_image'] = entity.websiteImage;
	data['lang_type'] = entity.langType;
	data['slug'] = entity.slug;
	data['category'] = entity.category?.toJson();
	return data;
}

categoryCategoryFromJson(CategoryCategory data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id'] is String
				? int.tryParse(json['id'])
				: json['id'].toInt();
	}
	if (json['category_title'] != null) {
		data.categoryTitle = json['category_title'].toString();
	}
	if (json['category_uid'] != null) {
		data.categoryUid = json['category_uid'].toString();
	}
	if (json['slug'] != null) {
		data.slug = json['slug'].toString();
	}
	if (json['category_status'] != null) {
		data.categoryStatus = json['category_status'];
	}
	if (json['category_type'] != null) {
		data.categoryType = json['category_type'];
	}
	if (json['country'] != null) {
		data.country = json['country'] is String
				? int.tryParse(json['country'])
				: json['country'].toInt();
	}
	return data;
}

Map<String, dynamic> categoryCategoryToJson(CategoryCategory entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['category_title'] = entity.categoryTitle;
	data['category_uid'] = entity.categoryUid;
	data['slug'] = entity.slug;
	data['category_status'] = entity.categoryStatus;
	data['category_type'] = entity.categoryType;
	data['country'] = entity.country;
	return data;
}
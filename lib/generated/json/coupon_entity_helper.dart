import 'package:coupon_app/domain/entities/coupons/coupon_entity.dart';

couponEntityFromJson(CouponEntity data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id'] is String
				? int.tryParse(json['id'])
				: json['id'].toInt();
	}
	if (json['name'] != null) {
		data.name = json['name'].toString();
	}
	if (json['short_description'] != null) {
		data.shortDescription = json['short_description'].toString();
	}
	if (json['full_description'] != null) {
		data.fullDescription = json['full_description'].toString();
	}
	if (json['meta_title'] != null) {
		data.metaTitle = json['meta_title'].toString();
	}
	if (json['meta_desc'] != null) {
		data.metaDesc = json['meta_desc'].toString();
	}
	if (json['lang_type'] != null) {
		data.langType = json['lang_type'] is String
				? int.tryParse(json['lang_type'])
				: json['lang_type'].toInt();
	}
	if (json['slug'] != null) {
		data.slug = json['slug'].toString();
	}
	if (json['coupon_id'] != null) {
		data.couponId = new CouponCouponId().fromJson(json['coupon_id']);
	}
	return data;
}

Map<String, dynamic> couponEntityToJson(CouponEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['name'] = entity.name;
	data['short_description'] = entity.shortDescription;
	data['full_description'] = entity.fullDescription;
	data['meta_title'] = entity.metaTitle;
	data['meta_desc'] = entity.metaDesc;
	data['lang_type'] = entity.langType;
	data['slug'] = entity.slug;
	if (entity.couponId != null) {
		data['coupon_id'] = entity.couponId.toJson();
	}
	return data;
}

couponCouponIdFromJson(CouponCouponId data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id'] is String
				? int.tryParse(json['id'])
				: json['id'].toInt();
	}
	if (json['uid'] != null) {
		data.uid = json['uid'].toString();
	}
	if (json['title'] != null) {
		data.title = json['title'].toString();
	}
	if (json['thumb_img'] != null) {
		data.thumbImg = json['thumb_img'].toString();
	}
	if (json['price'] != null) {
		data.price = json['price'].toString();
	}
	if (json['stock'] != null) {
		data.stock = json['stock'] is String
				? int.tryParse(json['stock'])
				: json['stock'].toInt();
	}
	if (json['valid_from'] != null) {
		data.validFrom = json['valid_from'].toString();
	}
	if (json['valid_to'] != null) {
		data.validTo = json['valid_to'].toString();
	}
	if (json['coupon_status'] != null) {
		data.couponStatus = json['coupon_status'] is String
				? int.tryParse(json['coupon_status'])
				: json['coupon_status'].toInt();
	}
	if (json['admin_status'] != null) {
		data.adminStatus = json['admin_status'] is String
				? int.tryParse(json['admin_status'])
				: json['admin_status'].toInt();
	}
	if (json['category_id'] != null) {
		data.categoryId = json['category_id'] is String
				? int.tryParse(json['category_id'])
				: json['category_id'].toInt();
	}
	if (json['seller_id'] != null) {
		data.sellerId = json['seller_id'] is String
				? int.tryParse(json['seller_id'])
				: json['seller_id'].toInt();
	}
	return data;
}

Map<String, dynamic> couponCouponIdToJson(CouponCouponId entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['uid'] = entity.uid;
	data['title'] = entity.title;
	data['thumb_img'] = entity.thumbImg;
	data['price'] = entity.price;
	data['stock'] = entity.stock;
	data['valid_from'] = entity.validFrom;
	data['valid_to'] = entity.validTo;
	data['coupon_status'] = entity.couponStatus;
	data['admin_status'] = entity.adminStatus;
	data['category_id'] = entity.categoryId;
	data['seller_id'] = entity.sellerId;
	return data;
}
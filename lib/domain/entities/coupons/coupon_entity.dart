import 'package:coupon_app/domain/entities/cart_addable.dart';
import 'package:coupon_app/generated/json/base/json_convert_content.dart';
import 'package:coupon_app/generated/json/base/json_field.dart';

class CouponEntity with JsonConvert<CouponEntity> {
	int id;
	String name;
	@JSONField(name: "short_description")
	String shortDescription;
	@JSONField(name: "full_description")
	String fullDescription;
	@JSONField(name: "meta_title")
	String metaTitle;
	@JSONField(name: "meta_desc")
	String metaDesc;
	@JSONField(name: "lang_type")
	int langType;
	String slug;
	@JSONField(name: "coupon_id")
	CouponCouponId couponId;
}

class CouponCouponId with JsonConvert<CouponCouponId> {
	int id;
	String uid;
	String title;
	@JSONField(name: "thumb_img")
	String thumbImg;
	String price;
	int stock;
	@JSONField(name: "valid_from")
	String validFrom;
	@JSONField(name: "valid_to")
	String validTo;
	@JSONField(name: "coupon_status")
	int couponStatus;
	@JSONField(name: "admin_status")
	int adminStatus;
	@JSONField(name: "category_id")
	int categoryId;
	@JSONField(name: "seller_id")
	int sellerId;
}

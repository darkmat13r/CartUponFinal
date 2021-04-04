import 'package:coupon_app/domain/entities/product_entity.dart';
import 'package:coupon_app/generated/json/base/json_convert_content.dart';
import 'package:coupon_app/generated/json/base/json_field.dart';

class CategoryEntity with JsonConvert<CategoryEntity> {
	int id;
	String name;
	@JSONField(name: "mobile_image")
	String mobileImage;
	@JSONField(name: "website_image")
	String websiteImage;
	@JSONField(name: "lang_type")
	int langType;
	String slug;
	CategoryCategory category;
}

class CategoryCategory with JsonConvert<CategoryCategory> {
	int id;
	@JSONField(name: "category_title")
	String categoryTitle;
	@JSONField(name: "category_uid")
	String categoryUid;
	String slug;
	@JSONField(name: "category_status")
	bool categoryStatus;
	@JSONField(name: "category_type")
	bool categoryType;
	int country;
	@JSONField(name : "products")
	List<ProductProductId> products;
}

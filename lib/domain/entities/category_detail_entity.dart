import 'package:coupon_app/generated/json/base/json_convert_content.dart';
import 'package:coupon_app/generated/json/base/json_field.dart';

class CategoryDetailEntity with JsonConvert<CategoryDetailEntity> {
	int id;
	String name;
	String slug;
	@JSONField(name: "mobile_image")
	String mobileImage;
	@JSONField(name: "website_image")
	String websiteImage;
	@JSONField(name: "lang_type")
	int langType;
	int category;
}

import 'package:coupon_app/generated/json/base/json_convert_content.dart';
import 'package:coupon_app/generated/json/base/json_field.dart';

class ProductEntity with JsonConvert<ProductEntity> {
	String id;
	String createdAt;
	String name;
	String description;
	@JSONField(name: "full_description")
	String fullDescription;
	String price;
	List<String> images;
}

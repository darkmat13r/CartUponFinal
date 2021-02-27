import 'package:coupon_app/generated/json/base/json_convert_content.dart';

class CategoryEntity with JsonConvert<CategoryEntity> {
	String name;
	String icon;
  CategoryEntity({this.name, this.icon});
}

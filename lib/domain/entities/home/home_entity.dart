import 'package:coupon_app/domain/entities/category_entity.dart';
import 'package:coupon_app/domain/entities/product_entity.dart';
import 'package:coupon_app/generated/json/base/json_convert_content.dart';
import 'package:coupon_app/generated/json/base/json_field.dart';
import 'package:coupon_app/domain/entities/slider_banner_entity.dart';
import 'package:coupon_app/domain/entities/ad_banner_entity.dart';
export 'package:coupon_app/domain/extensions/HomeEntityExtension.dart';
class HomeEntity with JsonConvert<HomeEntity>{

  @JSONField(name : 'sliders')
  List<SliderBannerEntity> sliders;
  @JSONField(name : 'adbanners')
  List<AdBannerEntity> adBanners;
  @JSONField(name : 'sections')
  List<CategoryEntity> sections;

  @JSONField(name : 'Featured_products')
  List<ProductProductId> featuredProducts;




}
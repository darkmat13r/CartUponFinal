import 'package:coupon_app/generated/json/base/json_convert_content.dart';
import 'package:coupon_app/generated/json/base/json_field.dart';

class AdBannerEntity with JsonConvert<AdBannerEntity> {
	int id;
	@JSONField(name: "ad_title")
	String adTitle;
	@JSONField(name: "web_banner")
	String webBanner;
	@JSONField(name: "mobile_banner")
	String mobileBanner;
	@JSONField(name: "banner_link")
	String bannerLink;
	@JSONField(name: "lang_type")
	int langType;
	int country;
}

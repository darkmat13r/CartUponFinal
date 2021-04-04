import 'package:coupon_app/domain/entities/home/home_entity.dart';
import 'package:coupon_app/domain/entities/slider_banner_entity.dart';

homeEntityFromJson(HomeEntity data, Map<String, dynamic> json) {
	if (json['sliders'] != null) {
		data.sliders = (json['sliders'] as List).map((v) => SliderBannerEntity().fromJson(v)).toList();
	}
	return data;
}

Map<String, dynamic> homeEntityToJson(HomeEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['sliders'] =  entity.sliders?.map((v) => v.toJson())?.toList();
	return data;
}
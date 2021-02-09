import 'package:coupon_app/domain/entities/user_entity.dart';

userEntityFromJson(UserEntity data, Map<String, dynamic> json) {
	if (json['key'] != null) {
		data.key = json['key'].toString();
	}
	return data;
}

Map<String, dynamic> userEntityToJson(UserEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['key'] = entity.key;
	return data;
}
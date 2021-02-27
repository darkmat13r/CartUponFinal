import 'package:coupon_app/domain/entities/product_entity.dart';

productEntityFromJson(ProductEntity data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id'].toString();
	}
	if (json['createdAt'] != null) {
		data.createdAt = json['createdAt'].toString();
	}
	if (json['name'] != null) {
		data.name = json['name'].toString();
	}
	if (json['description'] != null) {
		data.description = json['description'].toString();
	}
	if (json['full_description'] != null) {
		data.fullDescription = json['full_description'].toString();
	}
	if (json['price'] != null) {
		data.price = json['price'].toString();
	}
	if (json['images'] != null) {
		data.images = json['images']?.map((v) => v.toString())?.toList()?.cast<String>();
	}
	return data;
}

Map<String, dynamic> productEntityToJson(ProductEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['createdAt'] = entity.createdAt;
	data['name'] = entity.name;
	data['description'] = entity.description;
	data['full_description'] = entity.fullDescription;
	data['price'] = entity.price;
	data['images'] = entity.images;
	return data;
}
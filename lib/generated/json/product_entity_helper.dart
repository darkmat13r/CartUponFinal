import 'package:coupon_app/domain/entities/product_entity.dart';

productEntityFromJson(ProductEntity data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id'] is String
				? int.tryParse(json['id'])
				: json['id'].toInt();
	}
	if (json['name'] != null) {
		data.name = json['name'].toString();
	}
	if (json['short_description'] != null) {
		data.shortDescription = json['short_description'].toString();
	}
	if (json['full_description'] != null) {
		data.fullDescription = json['full_description'].toString();
	}
	if (json['meta_title'] != null) {
		data.metaTitle = json['meta_title'].toString();
	}
	if (json['meta_desc'] != null) {
		data.metaDesc = json['meta_desc'].toString();
	}
	if (json['lang_type'] != null) {
		data.langType = json['lang_type'] is String
				? int.tryParse(json['lang_type'])
				: json['lang_type'].toInt();
	}
	if (json['slug'] != null) {
		data.slug = json['slug'].toString();
	}
	if (json['product_id'] != null) {
		data.productId = ProductProductId().fromJson(json['product_id']);
	}
	return data;
}

Map<String, dynamic> productEntityToJson(ProductEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['name'] = entity.name;
	data['short_description'] = entity.shortDescription;
	data['full_description'] = entity.fullDescription;
	data['meta_title'] = entity.metaTitle;
	data['meta_desc'] = entity.metaDesc;
	data['lang_type'] = entity.langType;
	data['slug'] = entity.slug;
	data['product_id'] = entity.productId?.toJson();
	return data;
}

productProductIdFromJson(ProductProductId data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id'] is String
				? int.tryParse(json['id'])
				: json['id'].toInt();
	}
	if (json['title'] != null) {
		data.title = json['title'].toString();
	}
	if (json['uid'] != null) {
		data.uid = json['uid'].toString();
	}
	if (json['thumb_img'] != null) {
		data.thumbImg = json['thumb_img'].toString();
	}
	if (json['price'] != null) {
		data.price = json['price'].toString();
	}
	if (json['sale_price'] != null) {
		data.salePrice = json['sale_price'].toString();
	}
	if (json['dis_per'] != null) {
		data.disPer = json['dis_per'].toString();
	}
	if (json['stock'] != null) {
		data.stock = json['stock'] is String
				? int.tryParse(json['stock'])
				: json['stock'].toInt();
	}
	if (json['sku'] != null) {
		data.sku = json['sku'].toString();
	}
	if (json['valid_from'] != null) {
		data.validFrom = json['valid_from'].toString();
	}
	if (json['valid_to'] != null) {
		data.validTo = json['valid_to'].toString();
	}
	if (json['category_type'] != null) {
		data.categoryType = json['category_type'];
	}
	if (json['product_gallery'] != null) {
		data.productGallery = (json['product_gallery'] as List).map((v) => ProductProductIdProductGallery().fromJson(v)).toList();
	}
	if (json['product_variants'] != null) {
		data.productVariants = (json['product_variants'] as List).map((v) => ProductProductIdProductVariants().fromJson(v)).toList();
	}
	return data;
}

Map<String, dynamic> productProductIdToJson(ProductProductId entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['title'] = entity.title;
	data['uid'] = entity.uid;
	data['thumb_img'] = entity.thumbImg;
	data['price'] = entity.price;
	data['sale_price'] = entity.salePrice;
	data['dis_per'] = entity.disPer;
	data['stock'] = entity.stock;
	data['sku'] = entity.sku;
	data['valid_from'] = entity.validFrom;
	data['valid_to'] = entity.validTo;
	data['category_type'] = entity.categoryType;
	data['product_gallery'] =  entity.productGallery?.map((v) => v.toJson())?.toList();
	data['product_variants'] =  entity.productVariants?.map((v) => v.toJson())?.toList();
	return data;
}

productProductIdProductGalleryFromJson(ProductProductIdProductGallery data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id'] is String
				? int.tryParse(json['id'])
				: json['id'].toInt();
	}
	if (json['image'] != null) {
		data.image = json['image'].toString();
	}
	if (json['product_id'] != null) {
		data.productId = json['product_id'] is String
				? int.tryParse(json['product_id'])
				: json['product_id'].toInt();
	}
	return data;
}

Map<String, dynamic> productProductIdProductGalleryToJson(ProductProductIdProductGallery entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['image'] = entity.image;
	data['product_id'] = entity.productId;
	return data;
}

productProductIdProductVariantsFromJson(ProductProductIdProductVariants data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id'] is String
				? int.tryParse(json['id'])
				: json['id'].toInt();
	}
	if (json['name'] != null) {
		data.name = json['name'].toString();
	}
	if (json['required'] != null) {
		data.required = json['required'];
	}
	if (json['display_as'] != null) {
		data.displayAs = json['display_as'].toString();
	}
	if (json['product_variant_values'] != null) {
		data.productVariantValues = (json['product_variant_values'] as List).map((v) => ProductProductIdProductVariantsProductVariantValues().fromJson(v)).toList();
	}
	return data;
}

Map<String, dynamic> productProductIdProductVariantsToJson(ProductProductIdProductVariants entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['name'] = entity.name;
	data['required'] = entity.required;
	data['display_as'] = entity.displayAs;
	data['product_variant_values'] =  entity.productVariantValues?.map((v) => v.toJson())?.toList();
	return data;
}

productProductIdProductVariantsProductVariantValuesFromJson(ProductProductIdProductVariantsProductVariantValues data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id'] is String
				? int.tryParse(json['id'])
				: json['id'].toInt();
	}
	if (json['value'] != null) {
		data.value = json['value'].toString();
	}
	if (json['price'] != null) {
		data.price = json['price'].toString();
	}
	if (json['stock'] != null) {
		data.stock = json['stock'] is String
				? int.tryParse(json['stock'])
				: json['stock'].toInt();
	}
	if (json['image'] != null) {
		data.image = json['image'].toString();
	}
	if (json['variant_id'] != null) {
		data.variantId = json['variant_id'] is String
				? int.tryParse(json['variant_id'])
				: json['variant_id'].toInt();
	}
	return data;
}

Map<String, dynamic> productProductIdProductVariantsProductVariantValuesToJson(ProductProductIdProductVariantsProductVariantValues entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['value'] = entity.value;
	data['price'] = entity.price;
	data['stock'] = entity.stock;
	data['image'] = entity.image;
	data['variant_id'] = entity.variantId;
	return data;
}
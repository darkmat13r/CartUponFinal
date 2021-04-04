import 'package:coupon_app/generated/json/base/json_convert_content.dart';
import 'package:coupon_app/generated/json/base/json_field.dart';

class ProductEntity with JsonConvert<ProductEntity> {
	int id;
	String name;
	@JSONField(name: "short_description")
	String shortDescription;
	@JSONField(name: "full_description")
	String fullDescription;
	@JSONField(name: "meta_title")
	String metaTitle;
	@JSONField(name: "meta_desc")
	String metaDesc;
	@JSONField(name: "lang_type")
	int langType;
	String slug;
	@JSONField(name: "product_id")
	ProductProductId productId;
}

class ProductProductId with JsonConvert<ProductProductId> {
	int id;
	String title;
	String uid;
	@JSONField(name: "thumb_img")
	String thumbImg;
	String price;
	@JSONField(name: "sale_price")
	String salePrice;
	@JSONField(name: "dis_per")
	String disPer;
	int stock;
	String sku;
	@JSONField(name: "valid_from")
	String validFrom;
	@JSONField(name: "valid_to")
	String validTo;
	@JSONField(name: "category_type")
	bool categoryType;
	@JSONField(name: "product_gallery")
	List<ProductProductIdProductGallery> productGallery;
	@JSONField(name: "product_variants")
	List<ProductProductIdProductVariants> productVariants;
}

class ProductProductIdProductGallery with JsonConvert<ProductProductIdProductGallery> {
	int id;
	String image;
	@JSONField(name: "product_id")
	int productId;
}

class ProductProductIdProductVariants with JsonConvert<ProductProductIdProductVariants> {
	int id;
	String name;
	bool required;
	@JSONField(name: "display_as")
	String displayAs;
	@JSONField(name: "product_variant_values")
	List<ProductProductIdProductVariantsProductVariantValues> productVariantValues;
}

class ProductProductIdProductVariantsProductVariantValues with JsonConvert<ProductProductIdProductVariantsProductVariantValues> {
	int id;
	String value;
	String price;
	int stock;
	String image;
	@JSONField(name: "variant_id")
	int variantId;
}

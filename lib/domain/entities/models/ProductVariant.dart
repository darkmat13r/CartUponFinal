import 'package:coupon_app/domain/entities/models/ProductVariantValue.dart';

class ProductVariant {
    String display_as;
    int id;
    String name;
    List<ProductVariantValue> product_variant_values;
    bool required;

    ProductVariant({this.display_as, this.id, this.name, this.product_variant_values, this.required});

    factory ProductVariant.fromJson(Map<String, dynamic> json) {
        return ProductVariant(
            display_as: json['display_as'], 
            id: json['id'], 
            name: json['name'], 
            product_variant_values: json['product_variant_values'] != null ? (json['product_variant_values'] as List).map((i) => ProductVariantValue.fromJson(i)).toList() : null, 
            required: json['required'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['display_as'] = this.display_as;
        data['id'] = this.id;
        data['name'] = this.name;
        data['required'] = this.required;
        if (this.product_variant_values != null) {
            data['product_variant_values'] = this.product_variant_values.map((v) => v.toJson()).toList();
        }
        return data;
    }
}
class ProductVariantValue {
    int id;
    String image;
    String price;
    int stock;
    String value;
    int variant_id;

    ProductVariantValue({this.id, this.image, this.price, this.stock, this.value, this.variant_id});

    factory ProductVariantValue.fromJson(Map<String, dynamic> json) {
        return ProductVariantValue(
            id: json['id'], 
            image: json['image'], 
            price: json['price'], 
            stock: json['stock'], 
            value: json['value'], 
            variant_id: json['variant_id'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['id'] = this.id;
        data['image'] = this.image;
        data['price'] = this.price;
        data['stock'] = this.stock;
        data['value'] = this.value;
        data['variant_id'] = this.variant_id;
        return data;
    }
}
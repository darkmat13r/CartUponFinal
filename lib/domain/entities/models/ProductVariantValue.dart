class ProductVariantValue {
    int id;
    String image;
    String price;
    String costPrice;
    String salePrice;
    String offerPrice;
    int stock;
    String value;
    int variantId;

    ProductVariantValue({this.id, this.image, this.price, this.stock, this.value, this.variantId, this.costPrice, this.salePrice, this.offerPrice});

    factory ProductVariantValue.fromJson(Map<String, dynamic> json) {
        return ProductVariantValue(
            id: json['id'], 
            image: json['image'], 
            price: json['price'], 
            stock: json['stock'], 
            costPrice: json['cost_price'],
            salePrice: json['sale_price'],
            offerPrice: json['offer_price'],
            value: json['value'],
            variantId: json['variant_id'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['id'] = this.id;
        data['image'] = this.image;
        data['price'] = this.price;
        data['stock'] = this.stock;
        data['value'] = this.value;
        data['cost_price'] = this.costPrice;
        data['sale_price'] = this.salePrice;
        data['offer_price'] = this.offerPrice;
        data['variant_id'] = this.variantId;
        return data;
    }


}
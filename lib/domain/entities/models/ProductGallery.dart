class ProductGallery {
    int id;
    String image;
    int product_id;

    ProductGallery({this.id, this.image, this.product_id});

    factory ProductGallery.fromJson(Map<String, dynamic> json) {
        return ProductGallery(
            id: json['id'], 
            image: json['image'], 
            product_id: json['product_id'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['id'] = this.id;
        data['image'] = this.image;
        data['product_id'] = this.product_id;
        return data;
    }
}
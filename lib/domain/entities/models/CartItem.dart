class CartItem {
    int id;
    int is_type;
    int product_id;
    int qty;
    int user_id;
    int variant_id;

    CartItem({this.id, this.is_type, this.product_id, this.qty, this.user_id, this.variant_id});

    factory CartItem.fromJson(Map<String, dynamic> json) {
        return CartItem(
            id: json['id'], 
            is_type: json['is_type'], 
            product_id: json['product_id'], 
            qty: json['qty'], 
            user_id: json['user_id'], 
            variant_id: json['variant_id'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['id'] = this.id;
        data['is_type'] = this.is_type;
        data['product_id'] = this.product_id;
        data['qty'] = this.qty;
        data['user_id'] = this.user_id;
        data['variant_id'] = this.variant_id;
        return data;
    }
}
class Seller {
    String account_holder;
    String account_no;
    String address;
    String bank_name;
    String contact_no;
    int country;
    String iban;
    int id;
    String seller_name;
    int user_id;
    String latitude;
    String longitude;

    Seller({this.account_holder, this.account_no, this.address, this.bank_name, this.contact_no, this.country, this.iban, this.id, this.seller_name, this.user_id, this.latitude, this.longitude});

    factory Seller.fromJson(Map<String, dynamic> json) {
        return Seller(
            account_holder: json['account_holder'], 
            account_no: json['account_no'], 
            address: json['address'], 
            bank_name: json['bank_name'], 
            contact_no: json['contact_no'], 
            country: json['country'], 
            iban: json['iban'], 
            id: json['id'], 
            latitude: json['latitude'],
            longitude: json['longitude'],
            seller_name: json['seller_name'],
            user_id: json['user_id'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['account_holder'] = this.account_holder;
        data['account_no'] = this.account_no;
        data['address'] = this.address;
        data['bank_name'] = this.bank_name;
        data['contact_no'] = this.contact_no;
        data['country'] = this.country;
        data['iban'] = this.iban;
        data['id'] = this.id;
        data['latitude'] = this.latitude;
        data['longitude'] = this.longitude;
        data['seller_name'] = this.seller_name;
        data['user_id'] = this.user_id;
        return data;
    }
}
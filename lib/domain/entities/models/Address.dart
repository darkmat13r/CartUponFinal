class Address {
    String address;
    String area;
    String block;
    String building;
    String floor_flat;
    int id;
    bool is_default;
    String phone_no;
    int user;

    Address({this.address, this.area, this.block, this.building, this.floor_flat, this.id, this.is_default, this.phone_no, this.user});

    factory Address.fromJson(Map<String, dynamic> json) {
        return Address(
            address: json['address'], 
            area: json['area'], 
            block: json['block'], 
            building: json['building'], 
            floor_flat: json['floor_flat'], 
            id: json['id'], 
            is_default: json['is_default'], 
            phone_no: json['phone_no'], 
            user: json['user'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['address'] = this.address;
        data['area'] = this.area;
        data['block'] = this.block;
        data['building'] = this.building;
        data['floor_flat'] = this.floor_flat;
        data['id'] = this.id;
        data['is_default'] = this.is_default;
        data['phone_no'] = this.phone_no;
        data['user'] = this.user;
        return data;
    }
}
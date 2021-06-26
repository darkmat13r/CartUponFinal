import 'package:coupon_app/domain/entities/models/Area.dart';
import 'package:coupon_app/domain/entities/models/Block.dart';

class Address {
    String first_name;
    String last_name;
    String address;
    Area area;
    Block block;
    String building;
    String floor_flat;
    int id;
    bool is_default;
    String phone_no;
    String email;
    String countryCode;
    int user;

    Address({this.first_name, this.last_name,this.address, this.area, this.block, this.building, this.floor_flat, this.id, this.is_default, this.phone_no, this.user, this.email, this.countryCode});

    factory Address.fromJson(Map<String, dynamic> json) {
        return Address(
            first_name: json['first_name'],
            last_name: json['last_name'],
            address: json['address'],
            area: (json['area'] !=  null && json['area'] is Map) ? Area.fromJson(json['area']) : null,
            block: (json['block'] !=  null && json['block'] is Map) ? Block.fromJson(json['block']) : null,
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
        data['first_name'] = this.first_name;
        data['last_name'] = this.last_name;
        data['address'] = this.address;
        data['area'] = this.area != null ? this.area.toJson() : "";
        data['block'] = this.block != null ?  this.block : "";
        data['building'] = this.building;
        data['floor_flat'] = this.floor_flat;
        data['id'] = this.id;
        data['is_default'] = this.is_default;
        data['phone_no'] = this.phone_no;
        data['user'] = this.user;
        return data;
    }
}
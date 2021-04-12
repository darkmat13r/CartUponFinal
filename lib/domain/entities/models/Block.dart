import 'package:coupon_app/domain/entities/models/Area.dart';

class Block {
    String block_name;
    bool block_status;
    int id;

    Block({this.block_name, this.block_status, this.id});

    factory Block.fromJson(Map<String, dynamic> json) {
        return Block(
            block_name: json['block_name'],
            block_status: json['block_status'], 
            id: json['id'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['block_name'] = this.block_name;
        data['block_status'] = this.block_status;
        data['id'] = this.id;
        return data;
    }
}
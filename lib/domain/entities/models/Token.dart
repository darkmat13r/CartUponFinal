import 'package:coupon_app/domain/entities/models/User.dart';

class Token {
    String country_code;
    String date_of_birth;
    int id;
    String key;
    String token;
    String mobile_no;
    int nationality;
    int gender;
    int title;
    User user;

    Token({this.country_code, this.date_of_birth, this.id, this.key,this.token, this.mobile_no, this.user, this.nationality, this.gender, this.title});

    factory Token.fromJson(Map<String, dynamic> json) {
        return Token(
            country_code: json['country_code'] ?? "",
            date_of_birth: json['date_of_birth'] ?? "",
            id: json['id'] ?? 0,
            key: json['key'] ?? "",
            token: json['token'] ?? "",
            nationality: json['nationlity'] ?? 0,
            gender: json['gender'] ?? 0,
            title: json['title'] ?? 0,
            mobile_no: json['mobile_no'] ?? "",
            user: json['user'] != null ? User.fromJson(json['user']) : null, 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['country_code'] = this.country_code;
        data['date_of_birth'] = this.date_of_birth;
        data['id'] = this.id;
        data['key'] = this.key;
        data['mobile_no'] = this.mobile_no;
        data['nationlity'] = this.nationality;
        data['gender'] = this.gender;
        data['title'] = this.title;
        if (this.user != null) {
            data['user'] = this.user.toJson();
        }
        return data;
    }
}
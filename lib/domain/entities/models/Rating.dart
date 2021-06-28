import 'package:coupon_app/domain/entities/models/OrderDetail.dart';

class Rating {
    String created;
    int orderdetail;
    int rating;
    String review;
    String updated;

    Rating({this.created, this.orderdetail, this.rating, this.review, this.updated});

    factory Rating.fromJson(Map<String, dynamic> json) {
        return Rating(
            created: json['created'] != null ?json['created'] : null,
            orderdetail: json['orderdetail'] != null ? json['orderdetail'] : null,
            rating: json['rating'] != null ? json['rating'] : null,
            review: json['review'], 
            updated: json['updated'] != null ? json['updated'] : null,
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['review'] = this.review;
        data['created'] = this.created;
        data['orderdetail'] = this.orderdetail;
        data['rating'] = this.rating;
        data['updated'] = this.updated;
        return data;
    }
}
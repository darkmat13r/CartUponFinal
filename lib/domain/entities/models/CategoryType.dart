import 'package:coupon_app/domain/entities/models/Category.dart';

class CategoryType {
    Category category;
    int id;
    int lang_type;
    String mobile_image;
    String name;
    String slug;
    String website_image;

    CategoryType({this.category, this.id, this.lang_type, this.mobile_image, this.name, this.slug, this.website_image});

    factory CategoryType.fromJson(Map<String, dynamic> json) {
        return CategoryType(
            category: json['category'] != null ? Category.fromJson(json['category']) : null,
            id: json['id'], 
            lang_type: json['lang_type'], 
            mobile_image: json['mobile_image'], 
            name: json['name'], 
            slug: json['slug'], 
            website_image: json['website_image'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['id'] = this.id;
        data['lang_type'] = this.lang_type;
        data['mobile_image'] = this.mobile_image;
        data['name'] = this.name;
        data['slug'] = this.slug;
        data['website_image'] = this.website_image;
        if (this.category != null) {
            data['category'] = this.category.toJson();
        }
        return data;
    }
}
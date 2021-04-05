import 'package:coupon_app/domain/entities/models/Category.dart';

class Section {
    Category category;
    int id;
    int lang_type;
    String name;
    String slug;

    Section({this.category, this.id, this.lang_type, this.name, this.slug});

    factory Section.fromJson(Map<String, dynamic> json) {
        return Section(
            category: json['category'] != null ? Category.fromJson(json['category']) : null, 
            id: json['id'], 
            lang_type: json['lang_type'], 
            name: json['name'], 
            slug: json['slug'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['id'] = this.id;
        data['lang_type'] = this.lang_type;
        data['name'] = this.name;
        data['slug'] = this.slug;
        if (this.category != null) {
            data['category'] = this.category.toJson();
        }
        return data;
    }
}
import 'package:coupon_app/domain/entities/models/Adbanner.dart';
import 'package:coupon_app/domain/entities/models/BannerSlider.dart';
import 'package:coupon_app/domain/entities/models/Product.dart';
import 'package:coupon_app/domain/entities/models/ProductDetail.dart';
import 'package:coupon_app/domain/entities/models/Section.dart';

class HomeData {
    List<Adbanner> adbanners;
    List<ProductDetail> featured_products;
    List<Section> sections;
    List<BannerSlider> sliders;

    HomeData({this.adbanners, this.featured_products, this.sections, this.sliders});

    factory HomeData.fromJson(Map<String, dynamic> json) {
        return HomeData(
            adbanners: json['adbanners'] != null ? (json['adbanners'] as List).map((i) => Adbanner.fromJson(i)).toList() : null, 
            featured_products: json['Featured_products'] != null ? (json['Featured_products'] as List).map((i) => ProductDetail.fromJson(i)).toList() : null,
            sections: json['sections'] != null ? (json['sections'] as List).map((i) => Section.fromJson(i)).toList() : null,
            sliders: json['sliders'] != null ? (json['sliders'] as List).map((i) => BannerSlider.fromJson(i)).toList() : null,
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        if (this.adbanners != null) {
            data['adbanners'] = this.adbanners.map((v) => v.toJson()).toList();
        }
        if (this.featured_products != null) {
            data['Featured_products'] = this.featured_products.map((v) => v.toJson()).toList();
        }
        if (this.sections != null) {
            data['sections'] = this.sections.map((v) => v.toJson()).toList();
        }
        if (this.sliders != null) {
            data['sliders'] = this.sliders.map((v) => v.toJson()).toList();
        }
        return data;
    }
}
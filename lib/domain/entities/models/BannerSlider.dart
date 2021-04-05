class BannerSlider {
    Object banner_link;
    int country;
    int id;
    int lang_type;
    String mobile_banner;
    String slider_title;
    String web_banner;

    BannerSlider({this.banner_link, this.country, this.id, this.lang_type, this.mobile_banner, this.slider_title, this.web_banner});

    factory BannerSlider.fromJson(Map<String, dynamic> json) {
        return BannerSlider(
            banner_link: json['banner_link'] != null ? json['banner_link'] : null,
            country: json['country'], 
            id: json['id'], 
            lang_type: json['lang_type'], 
            mobile_banner: json['mobile_banner'], 
            slider_title: json['slider_title'], 
            web_banner: json['web_banner'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['country'] = this.country;
        data['id'] = this.id;
        data['lang_type'] = this.lang_type;
        data['mobile_banner'] = this.mobile_banner;
        data['slider_title'] = this.slider_title;
        data['web_banner'] = this.web_banner;
        if (this.banner_link != null) {
            data['banner_link'] = this.banner_link;
        }
        return data;
    }
}
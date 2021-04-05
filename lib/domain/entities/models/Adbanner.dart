class Adbanner {
    String ad_title;
    Object banner_link;
    int country;
    int id;
    int lang_type;
    String mobile_banner;
    String web_banner;

    Adbanner({this.ad_title, this.banner_link, this.country, this.id, this.lang_type, this.mobile_banner, this.web_banner});

    factory Adbanner.fromJson(Map<String, dynamic> json) {
        return Adbanner(
            ad_title: json['ad_title'], 
            banner_link: json['banner_link'] != null ? json['banner_link'] : null,
            country: json['country'], 
            id: json['id'], 
            lang_type: json['lang_type'], 
            mobile_banner: json['mobile_banner'], 
            web_banner: json['web_banner'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['ad_title'] = this.ad_title;
        data['country'] = this.country;
        data['id'] = this.id;
        data['lang_type'] = this.lang_type;
        data['mobile_banner'] = this.mobile_banner;
        data['web_banner'] = this.web_banner;
        if (this.banner_link != null) {
            data['banner_link'] = this.banner_link;
        }
        return data;
    }
}
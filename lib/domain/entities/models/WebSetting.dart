class WebSetting {
    String address;
    String business_name;
    String fb_link;
    int id;
    String instagram_link;
    String linkedin_link;
    String logo;
    String pintrest_link;
    String support_email;
    String support_phoneno;
    String twitter_link;
    String youtube;

    WebSetting({this.address, this.business_name, this.fb_link, this.id, this.instagram_link, this.linkedin_link, this.logo, this.pintrest_link, this.support_email, this.support_phoneno, this.twitter_link, this.youtube});

    factory WebSetting.fromJson(Map<String, dynamic> json) {
        return WebSetting(
            address: json['address'], 
            business_name: json['business_name'], 
            fb_link: json['fb_link'], 
            id: json['id'], 
            instagram_link: json['instagram_link'], 
            linkedin_link: json['linkedin_link'], 
            logo: json['logo'], 
            pintrest_link: json['pintrest_link'], 
            support_email: json['support_email'], 
            support_phoneno: json['support_phoneno'], 
            twitter_link: json['twitter_link'], 
            youtube: json['youtube'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['address'] = this.address;
        data['business_name'] = this.business_name;
        data['fb_link'] = this.fb_link;
        data['id'] = this.id;
        data['instagram_link'] = this.instagram_link;
        data['linkedin_link'] = this.linkedin_link;
        data['logo'] = this.logo;
        data['pintrest_link'] = this.pintrest_link;
        data['support_email'] = this.support_email;
        data['support_phoneno'] = this.support_phoneno;
        data['twitter_link'] = this.twitter_link;
        data['youtube'] = this.youtube;
        return data;
    }
}
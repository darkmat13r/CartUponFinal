class Country {
  String country_code;
  String country_name_ar;
  String country_currency;
  String country_currency_symbol;
  String country_name;
  String dial_code;
  int id;

  Country(
      {this.country_code,
      this.country_name_ar,
      this.country_currency,
      this.country_currency_symbol,
      this.country_name,
      this.dial_code,
      this.id});

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      country_code: json['country_code'],
      country_name_ar: json['country_name_ar'],
      country_currency: json['country_currency'],
      country_currency_symbol: json['country_currency_symbol'],
      country_name: json['country_name'],
      dial_code: json['dial_code'],
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['country_code'] = this.country_code;
    data['country_currency'] = this.country_currency;
    data['country_currency_symbol'] = this.country_currency_symbol;
    data['country_name'] = this.country_name;
    data['dial_code'] = this.dial_code;
    data['id'] = this.id;
    return data;
  }
}

class Country {
    String country_code;
    String country_currency;
    String country_currency_symbol;
    String country_name;
    int id;

    Country({this.country_code, this.country_currency, this.country_currency_symbol, this.country_name, this.id});

    factory Country.fromJson(Map<String, dynamic> json) {
        return Country(
            country_code: json['country_code'], 
            country_currency: json['country_currency'], 
            country_currency_symbol: json['country_currency_symbol'], 
            country_name: json['country_name'], 
            id: json['id'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['country_code'] = this.country_code;
        data['country_currency'] = this.country_currency;
        data['country_currency_symbol'] = this.country_currency_symbol;
        data['country_name'] = this.country_name;
        data['id'] = this.id;
        return data;
    }
}
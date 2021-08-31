class Nationality {
  String country_name;
  String country_name_ar;
  int id;

  Nationality({this.country_name, this.country_name_ar, this.id});

  factory Nationality.fromJson(Map<String, dynamic> json) {
    return Nationality(
      country_name: json['country_name'],
      country_name_ar: json['country_name_ar'],
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['country_name'] = this.country_name;
    data['id'] = this.id;
    return data;
  }
}

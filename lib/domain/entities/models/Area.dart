class Area {
    String area_name;
    bool area_status;
    int id;

    Area({this.area_name, this.area_status, this.id});

    factory Area.fromJson(Map<String, dynamic> json) {
        return Area(
            area_name: json['area_name'], 
            area_status: json['area_status'], 
            id: json['id'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['area_name'] = this.area_name;
        data['area_status'] = this.area_status;
        data['id'] = this.id;
        return data;
    }
}
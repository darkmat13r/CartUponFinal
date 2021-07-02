class IPDetectResponse {
    String provider;
    String city;
    String country;
    String countryCode;
    String isp;
    double lat;
    double lon;
    String org;
    String query;
    String region;
    String regionName;
    String status;
    String timezone;
    String zip;

    IPDetectResponse({this.provider, this.city, this.country, this.countryCode, this.isp, this.lat, this.lon, this.org, this.query, this.region, this.regionName, this.status, this.timezone, this.zip});

    factory IPDetectResponse.fromJson(Map<String, dynamic> json) {
        return IPDetectResponse(
            provider: json['`as`'],
            city: json['city'], 
            country: json['country'], 
            countryCode: json['countryCode'], 
            isp: json['isp'], 
            lat: json['lat'], 
            lon: json['lon'], 
            org: json['org'], 
            query: json['query'], 
            region: json['region'], 
            regionName: json['regionName'], 
            status: json['status'], 
            timezone: json['timezone'], 
            zip: json['zip'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['`as`'] = this.provider;
        data['city'] = this.city;
        data['country'] = this.country;
        data['countryCode'] = this.countryCode;
        data['isp'] = this.isp;
        data['lat'] = this.lat;
        data['lon'] = this.lon;
        data['org'] = this.org;
        data['query'] = this.query;
        data['region'] = this.region;
        data['regionName'] = this.regionName;
        data['status'] = this.status;
        data['timezone'] = this.timezone;
        data['zip'] = this.zip;
        return data;
    }
}
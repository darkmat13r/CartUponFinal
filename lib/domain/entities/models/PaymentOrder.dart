class PlaceOrderResponse {
    String paymentURL;
    String status;

    PlaceOrderResponse({this.paymentURL, this.status});

    factory PlaceOrderResponse.fromJson(Map<String, dynamic> json) {
        return PlaceOrderResponse(
            paymentURL: json['paymentURL'], 
            status: json['status'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['paymentURL'] = this.paymentURL;
        data['status'] = this.status;
        return data;
    }
}
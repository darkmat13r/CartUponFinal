class CancelOrderResponse {
    String msg;
    String status;

    CancelOrderResponse({this.msg, this.status});

    factory CancelOrderResponse.fromJson(Map<String, dynamic> json) {
        return CancelOrderResponse(
            msg: json['msg'], 
            status: json['status'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['msg'] = this.msg;
        data['status'] = this.status;
        return data;
    }
}
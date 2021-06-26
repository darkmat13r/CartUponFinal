class VerificationResponse {
    String msg;

    VerificationResponse({this.msg});

    factory VerificationResponse.fromJson(Map<String, dynamic> json) {
        return VerificationResponse(
            msg: json['msg'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['msg'] = this.msg;
        return data;
    }
}
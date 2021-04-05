class Token {
    String key;

    Token({this.key});

    factory Token.fromJson(Map<String, dynamic> json) {
        return Token(
            key: json['key'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['key'] = this.key;
        return data;
    }
}
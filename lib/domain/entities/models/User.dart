class User {
    String first_name;
    int id;
    bool is_active;
    String last_name;
    String password;
    int user_type;
    String username;
    String email;

    User({this.first_name, this.id, this.is_active, this.last_name, this.password, this.user_type, this.username, this.email});

    factory User.fromJson(Map<String, dynamic> json) {
        return User(
            first_name: json['first_name'], 
            id: json['id'], 
            is_active: json['is_active'], 
            last_name: json['last_name'], 
            password: json['password'], 
            user_type: json['user_type'], 
            username: json['username'],
            email: json['username'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['first_name'] = this.first_name;
        data['id'] = this.id;
        data['is_active'] = this.is_active;
        data['last_name'] = this.last_name;
        data['password'] = this.password;
        data['user_type'] = this.user_type;
        data['username'] = this.username;
        data['email'] = this.email;
        return data;
    }
}
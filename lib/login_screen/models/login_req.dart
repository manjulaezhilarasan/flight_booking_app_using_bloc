// ignore_for_file: public_member_api_docs, sort_constructors_first
class LoginReqModel {
  String email;
  String password;

  LoginReqModel({
    required this.email,
    required this.password,
  });

  static LoginReqModel getInstance() {
    return LoginReqModel(
      email: "",
      password: "",
    );
  }

  LoginReqModel copyWith({
    String? email,
    String? password,
  }) {
    return LoginReqModel(
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'password': password,
    };
  }

  factory LoginReqModel.fromMap(Map<String, dynamic> map) {
    return LoginReqModel(
      email: map['email'] as String,
      password: map['password'] as String,
    );
  }
}

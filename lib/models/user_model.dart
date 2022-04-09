class UserModel {
  String email, password, phone, userId, userName;

  UserModel({
    required this.email,
    required this.password,
    required this.phone,
    required this.userId,
    required this.userName,
  });

  Map<String, dynamic> toMap() {
    return {
      'email': this.email,
      'password': this.password,
      'phone': this.phone,
      'userId': this.userId,
      'userName': this.userName,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      email: map['email'] as String,
      password: map['password'] as String,
      phone: map['phone'] as String,
      userId: map['id'] as String,
      userName: map['username'] as String,
    );
  }
}

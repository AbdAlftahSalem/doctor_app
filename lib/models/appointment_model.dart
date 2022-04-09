class AppointmentModel {
  String date, idAppointment, idUser, painUser, time, userImage, userName;

  AppointmentModel({
    required this.date,
    required this.idAppointment,
    required this.idUser,
    required this.painUser,
    required this.time,
    required this.userImage,
    required this.userName,
  });

  Map<String, dynamic> toMap() {
    return {
      'date': this.date,
      'idAppointment': this.idAppointment,
      'idUser': this.idUser,
      'painUser': this.painUser,
      'time': this.time,
      'userImage': this.userImage,
      'userName': this.userName,
    };
  }

  factory AppointmentModel.fromMap(Map<String, dynamic> map) {
    return AppointmentModel(
      date: map['date'] as String,
      idAppointment: map['idAppointment'] as String,
      idUser: map['idUser'] as String,
      painUser: map['painUser'] as String,
      time: map['time'] as String,
      userImage: map['userImage'] as String,
      userName: map['userName'] as String,
    );
  }
}

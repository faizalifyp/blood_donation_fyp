class BloodRequest {
  final String requestId;
  final String uid;
  final String city;
  final String hospital;
  final String bloodType;
  final String mobile;
  final String note;
  String status;
  String acceptingUserUid;

  BloodRequest({
    required this.requestId,
    required this.uid,
    required this.city,
    required this.hospital,
    required this.bloodType,
    required this.mobile,
    required this.note,
    required this.status,
    required this.acceptingUserUid,
  });

  Map<String, dynamic> toJson() {
    return {
      'requestId': requestId,
      'uid': uid,
      'city': city,
      'hospital': hospital,
      'bloodType': bloodType,
      'mobile': mobile,
      'note': note,
      'status': status,
      'acceptingUserUid': acceptingUserUid,
    };
  }

  factory BloodRequest.fromJson(Map<String, dynamic> json) {
    return BloodRequest(
      requestId: json['requestId'],
      uid: json['uid'],
      city: json['city'],
      hospital: json['hospital'],
      bloodType: json['bloodType'],
      mobile: json['mobile'],
      note: json['note'],
      status: json['status'],
      acceptingUserUid: json['acceptingUserUid'],
    );
  }
}

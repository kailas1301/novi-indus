class Patient {
  final int id;
  final String name;
  final String? dateTime;
  final String? treatmentName;

  Patient({
    required this.id,
    required this.name,
    this.dateTime,
    this.treatmentName,
  });

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      id: json['id'],
      name: json['name'],
      dateTime: json['date_nd_time'] as String?,
      treatmentName:
          (json['patientdetails_set'] as List<dynamic>?)?.isNotEmpty == true
              ? json['patientdetails_set'][0]['treatment_name'] as String?
              : null,
    );
  }
}

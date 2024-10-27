class Model {
  final String jobId;
  final String approveName;
  final String iconName;

  Model(
      {required this.jobId, required this.approveName, required this.iconName});

  factory Model.fromJson(Map<String, dynamic> json) {
    return Model(
      jobId: json['job_id'],
      approveName: json['approve_name'].toString().split('-').first,
      iconName: json['approve_name'].toString().split('-').last,
    );
  }
}

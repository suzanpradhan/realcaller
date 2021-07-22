class SpamReportModel {
  final String toFirstname;
  final String toLastname;
  final String toPhoneNumber;
  final String fromFirstname;
  final String fromLastname;
  final String toUserID;
  final String fromUserID;

  SpamReportModel(
      {required this.fromFirstname,
      required this.fromLastname,
      required this.fromUserID,
      required this.toFirstname,
      required this.toLastname,
      required this.toPhoneNumber,
      required this.toUserID});
}

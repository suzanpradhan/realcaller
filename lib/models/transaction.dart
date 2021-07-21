class Transaction {
  String type;
  int id;
  int userId;
  int amount;
  DateTime date;
  bool status;
  String flow;

  Transaction(
      {required this.type,
      required this.id,
      required this.userId,
      required this.amount,
      required this.date,
      required this.status,
      required this.flow});
}

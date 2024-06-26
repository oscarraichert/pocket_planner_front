class Transaction {
  final Map<String, dynamic> id;
  final String value;
  final String description;
  final String date;

  Transaction(this.id, this.value, this.description, this.date);

  Transaction.fromJson(Map<String, dynamic> json)
      : id = json['id'] as Map<String, dynamic>,
        value = json['value'] as String,
        description = json['description'] as String,
        date = json['date'] as String;

  @override
  String toString() {
    return """{
      "value" : $value,
      "description" : $description,
      "date" : $date
    }""";
  }
}

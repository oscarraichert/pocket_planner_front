class ExtractEntryModel {
  final String value;
  final String description;
  final String date;

  ExtractEntryModel(this.value, this.description, this.date);

  ExtractEntryModel.fromJson(Map<String, dynamic> json)
      : value = json['value'] as String,
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

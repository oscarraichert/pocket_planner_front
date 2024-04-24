class NewExtractEntryModel {
  final String description;
  final String value;
  List<String>? tags;

  NewExtractEntryModel(this.description, this.value, {List<String>? tags});

  static Map<String, dynamic> toJson(NewExtractEntryModel obj) => {
        'description': obj.description,
        'value': obj.value,
        'tags': obj.tags ?? [],
      };
}

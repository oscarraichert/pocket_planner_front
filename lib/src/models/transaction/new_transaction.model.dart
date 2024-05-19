class NewTransaction {
  final String description;
  final String value;
  List<String>? tags;

  NewTransaction(this.description, this.value, {List<String>? tags});

  static Map<String, dynamic> toJson(NewTransaction obj) => {
        'description': obj.description,
        'value': obj.value,
        'tags': obj.tags ?? [],
      };
}

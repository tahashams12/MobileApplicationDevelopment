class Symptom {
  final int id;
  final String name;
  
  Symptom({
    required this.id,
    required this.name,
  });
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Symptom && other.id == id;
  }
  
  @override
  int get hashCode => id.hashCode;
}

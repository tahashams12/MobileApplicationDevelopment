class DiagnosisResult {
  final String diseaseName;
  final double confidence;
  final List<String> medications;
  final List<String> precautions;
  final List<String> dietRecommendations;
  
  DiagnosisResult({
    required this.diseaseName,
    required this.confidence,
    required this.medications,
    required this.precautions,
    required this.dietRecommendations,
  });
}

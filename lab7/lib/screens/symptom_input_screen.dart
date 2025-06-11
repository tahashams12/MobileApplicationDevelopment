import 'package:flutter/material.dart';
import '../widgets/gradient_background.dart';
import '../widgets/glowing_button.dart';
import '../widgets/glass_card.dart';
import '../models/symptom.dart';
import '../services/diagnosis_service.dart';
import 'result_screen.dart';

class SymptomInputScreen extends StatefulWidget {
  const SymptomInputScreen({super.key});

  @override
  State<SymptomInputScreen> createState() => _SymptomInputScreenState();
}

class _SymptomInputScreenState extends State<SymptomInputScreen> {
  final TextEditingController _searchController = TextEditingController();
  final List<Symptom> _selectedSymptoms = [];
  bool _isLoading = false;
  
  // Sample symptoms list - in a real app, this would come from an API
  final List<Symptom> _allSymptoms = [
    Symptom(id: 1, name: 'Fever'),
    Symptom(id: 2, name: 'Cough'),
    Symptom(id: 3, name: 'Headache'),
    Symptom(id: 4, name: 'Fatigue'),
    Symptom(id: 5, name: 'Nausea'),
    Symptom(id: 6, name: 'Dizziness'),
    Symptom(id: 7, name: 'Shortness of breath'),
    Symptom(id: 8, name: 'Chest pain'),
    Symptom(id: 9, name: 'Sore throat'),
    Symptom(id: 10, name: 'Runny nose'),
    Symptom(id: 11, name: 'Body aches'),
    Symptom(id: 12, name: 'Chills'),
    Symptom(id: 13, name: 'Loss of taste'),
    Symptom(id: 14, name: 'Loss of smell'),
    Symptom(id: 15, name: 'Diarrhea'),
  ];
  
  List<Symptom> _filteredSymptoms = [];
  
  @override
  void initState() {
    super.initState();
    _filteredSymptoms = List.from(_allSymptoms);
    _searchController.addListener(_filterSymptoms);
  }
  
  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
  
  void _filterSymptoms() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        _filteredSymptoms = List.from(_allSymptoms);
      } else {
        _filteredSymptoms = _allSymptoms
            .where((symptom) => symptom.name.toLowerCase().contains(query))
            .toList();
      }
    });
  }
  
  void _toggleSymptom(Symptom symptom) {
    setState(() {
      if (_selectedSymptoms.contains(symptom)) {
        _selectedSymptoms.remove(symptom);
      } else {
        _selectedSymptoms.add(symptom);
      }
    });
  }
  
  Future<void> _submitDiagnosis() async {
    if (_selectedSymptoms.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select at least one symptom'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }
    
    setState(() {
      _isLoading = true;
    });
    
    try {
      final diagnosisService = DiagnosisService();
      final result = await diagnosisService.getDiagnosis(
        _selectedSymptoms.map((s) => s.name).toList(),
      );
      
      if (!mounted) return;
      
      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => 
            ResultScreen(diagnosisResult: result),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            const curve = Curves.easeInOutCubic;
            var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            var offsetAnimation = animation.drive(tween);
            return SlideTransition(position: offsetAnimation, child: child);
          },
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: ${e.toString()}'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Symptom Input'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: GradientBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'What symptoms are you experiencing?',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                Text(
                  'Select all that apply',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 24),
                GlassCard(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search symptoms...',
                      prefixIcon: Icon(
                        Icons.search,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                if (_selectedSymptoms.isNotEmpty) ...[
                  Text(
                    'Selected Symptoms:',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: _selectedSymptoms.map((symptom) {
                      return Chip(
                        label: Text(symptom.name),
                        deleteIcon: const Icon(Icons.close, size: 18),
                        onDeleted: () => _toggleSymptom(symptom),
                        backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                        side: BorderSide(
                          color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                        ),
                        labelStyle: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 16),
                ],
                Expanded(
                  child: GlassCard(
                    child: ListView.builder(
                      itemCount: _filteredSymptoms.length,
                      itemBuilder: (context, index) {
                        final symptom = _filteredSymptoms[index];
                        final isSelected = _selectedSymptoms.contains(symptom);
                        
                        return ListTile(
                          title: Text(symptom.name),
                          trailing: isSelected
                              ? Icon(
                                  Icons.check_circle,
                                  color: Theme.of(context).colorScheme.primary,
                                )
                              : Icon(
                                  Icons.add_circle_outline,
                                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
                                ),
                          onTap: () => _toggleSymptom(symptom),
                          selected: isSelected,
                          selectedTileColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                GlowingButton(
                  text: 'Submit',
                  icon: Icons.send_rounded,
                  isLoading: _isLoading,
                  onPressed: _submitDiagnosis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

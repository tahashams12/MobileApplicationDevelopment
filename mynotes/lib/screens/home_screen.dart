// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/note.dart';
import '../services/database_helper.dart';
import 'note_editor_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  final TextEditingController _searchController = TextEditingController();
  List<Note> _notes = [];
  List<Note> _filteredNotes = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadNotes();
    _searchController.addListener(_filterNotes);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // Load all notes from database
  Future<void> _loadNotes() async {
    setState(() => _isLoading = true);
    try {
      final notes = await _databaseHelper.getAllNotes();
      setState(() {
        _notes = notes;
        _filteredNotes = notes;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      _showErrorSnackBar('Error loading notes: $e');
    }
  }

  // Filter notes based on search query
  void _filterNotes() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        _filteredNotes = _notes;
      } else {
        _filteredNotes = _notes.where((note) {
          return note.title.toLowerCase().contains(query) ||
              note.content.toLowerCase().contains(query);
        }).toList();
      }
    });
  }

  // Navigate to note editor
  Future<void> _navigateToNoteEditor({Note? note}) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NoteEditorScreen(note: note),
      ),
    );

    // Reload notes if a note was saved or deleted
    if (result == true) {
      _loadNotes();
    }
  }

  // Show error message
  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  // Get preview text (first 2 lines)
  String _getPreviewText(String content) {
    final lines = content.split('\n');
    if (lines.length >= 2) {
      return '${lines[0]}\n${lines[1]}';
    } else if (lines.length == 1) {
      return lines[0];
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MyNotes'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Search Bar
          Container(
            padding: EdgeInsets.all(16.0),
            color: Colors.blue.shade50,
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search notes...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.white,
                contentPadding: EdgeInsets.symmetric(vertical: 8),
              ),
            ),
          ),

          // Notes List
          Expanded(
            child: _isLoading
                ? Center(child: CircularProgressIndicator())
                : _filteredNotes.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.note_alt_outlined,
                              size: 64,
                              color: Colors.grey,
                            ),
                            SizedBox(height: 16),
                            Text(
                              _searchController.text.isEmpty
                                  ? 'No notes yet.\nTap + to create your first note!'
                                  : 'No notes found for "${_searchController.text}"',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                      )
                    : RefreshIndicator(
                        onRefresh: _loadNotes,
                        child: ListView.builder(
                          padding: EdgeInsets.all(8),
                          itemCount: _filteredNotes.length,
                          itemBuilder: (context, index) {
                            final note = _filteredNotes[index];
                            return Card(
                              margin: EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              child: ListTile(
                                title: Text(
                                  note.title.isEmpty ? 'Untitled' : note.title,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 4),
                                    Text(
                                      _getPreviewText(note.content),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: Colors.grey.shade700,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      DateFormat('MMM dd, yyyy - hh:mm a')
                                          .format(note.updatedAt),
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey.shade500,
                                      ),
                                    ),
                                  ],
                                ),
                                onTap: () => _navigateToNoteEditor(note: note),
                                contentPadding: EdgeInsets.all(16),
                              ),
                            );
                          },
                        ),
                      ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToNoteEditor(),
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
    );
  }
}

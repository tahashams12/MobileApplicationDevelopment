import 'package:flutter/material.dart';
import '../models/note.dart';
import '../services/database_helper.dart';

class NoteEditorScreen extends StatefulWidget {
  final Note? note;

  const NoteEditorScreen({Key? key, this.note}) : super(key: key);

  @override
  _NoteEditorScreenState createState() => _NoteEditorScreenState();
}

class _NoteEditorScreenState extends State<NoteEditorScreen> {
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  bool _isLoading = false;
  bool _hasUnsavedChanges = false;

  @override
  void initState() {
    super.initState();

    // If editing an existing note, populate the fields
    if (widget.note != null) {
      _titleController.text = widget.note!.title;
      _contentController.text = widget.note!.content;
    }

    // Listen for changes to track unsaved changes
    _titleController.addListener(() => _hasUnsavedChanges = true);
    _contentController.addListener(() => _hasUnsavedChanges = true);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  // Save the note
  Future<void> _saveNote() async {
    final title = _titleController.text.trim();
    final content = _contentController.text.trim();

    // Don't save if both title and content are empty
    if (title.isEmpty && content.isEmpty) {
      _showSnackBar('Cannot save empty note', Colors.orange);
      return;
    }

    setState(() => _isLoading = true);

    try {
      final now = DateTime.now();

      if (widget.note == null) {
        // Create new note
        final newNote = Note(
          title: title,
          content: content,
          createdAt: now,
          updatedAt: now,
        );
        await _databaseHelper.insertNote(newNote);
        _showSnackBar('Note saved successfully!', Colors.green);
      } else {
        // Update existing note
        final updatedNote = widget.note!.copyWith(
          title: title,
          content: content,
          updatedAt: now,
        );
        await _databaseHelper.updateNote(updatedNote);
        _showSnackBar('Note updated successfully!', Colors.green);
      }

      setState(() {
        _isLoading = false;
        _hasUnsavedChanges = false;
      });

      // Return to home screen and refresh the list
      Navigator.pop(context, true);
    } catch (e) {
      setState(() => _isLoading = false);
      _showSnackBar('Error saving note: $e', Colors.red);
    }
  }

  // Delete the note
  Future<void> _deleteNote() async {
    if (widget.note == null) return;

    final confirmed = await _showDeleteConfirmationDialog();
    if (!confirmed) return;

    setState(() => _isLoading = true);

    try {
      await _databaseHelper.deleteNote(widget.note!.id!);
      _showSnackBar('Note deleted successfully!', Colors.green);
      Navigator.pop(context, true);
    } catch (e) {
      setState(() => _isLoading = false);
      _showSnackBar('Error deleting note: $e', Colors.red);
    }
  }

  // Show delete confirmation dialog
  Future<bool> _showDeleteConfirmationDialog() async {
    return await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Delete Note'),
            content: Text(
                'Are you sure you want to delete this note? This action cannot be undone.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                style: TextButton.styleFrom(foregroundColor: Colors.red),
                child: Text('Delete'),
              ),
            ],
          ),
        ) ??
        false;
  }

  // Show snackbar message
  void _showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: color),
    );
  }

  // Handle back button press
  Future<bool> _onWillPop() async {
    if (!_hasUnsavedChanges) return true;

    final shouldDiscard = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Discard Changes?'),
        content:
            Text('You have unsaved changes. Are you sure you want to go back?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text('Stay'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: Text('Discard'),
          ),
        ],
      ),
    );

    return shouldDiscard ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.note == null ? 'New Note' : 'Edit Note'),
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          actions: [
            if (widget.note != null)
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: _isLoading ? null : _deleteNote,
              ),
            IconButton(
              icon: Icon(Icons.save),
              onPressed: _isLoading ? null : _saveNote,
            ),
          ],
        ),
        body: _isLoading
            ? Center(child: CircularProgressIndicator())
            : Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    // Title input field
                    TextField(
                      controller: _titleController,
                      decoration: InputDecoration(
                        hintText: 'Note title...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        contentPadding: EdgeInsets.all(16),
                      ),
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 16),

                    // Content input field
                    Expanded(
                      child: TextField(
                        controller: _contentController,
                        decoration: InputDecoration(
                          hintText: 'Start writing your note...',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          contentPadding: EdgeInsets.all(16),
                        ),
                        maxLines: null,
                        expands: true,
                        textAlignVertical: TextAlignVertical.top,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),

                    SizedBox(height: 16),

                    // Save button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: _isLoading ? null : _saveNote,
                        icon: Icon(Icons.save),
                        label: Text(
                          widget.note == null ? 'Save Note' : 'Update Note',
                          style: TextStyle(fontSize: 16),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:som_note/models/DatabaseHelper.dart';
import 'package:som_note/models/notes.dart';

class NoteDetailScreen extends StatelessWidget {
  final Note? note;

  NoteDetailScreen({this.note});

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController(text: note?.title);
    final contentController = TextEditingController(text: note?.content);

    return Scaffold(
      backgroundColor: Color(0xFFF7EBE5),
      appBar: AppBar(title: Text(note == null ? 'New Note' : 'Edit Note'),backgroundColor: Color(0xFFF7EBE5),),
      body: SingleChildScrollView( // Wrap with SingleChildScrollView
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // Align to the start
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: 'Title'),
              ),
              SizedBox(height: 20), // Add space between fields
              TextField(
                controller: contentController,
                decoration: InputDecoration(labelText: 'Content'),
                maxLines: 10,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  final title = titleController.text;
                  final content = contentController.text;

                  if (title.isEmpty || content.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Title and content cannot be empty')),
                    );
                    return;
                  }

                  final newNote = Note(
                    id: note?.id, // Keep the same ID if editing
                    title: title,
                    content: content,
                    date: DateTime.now(),
                  );

                  if (note == null) {
                    await DatabaseHelper().insertNote(newNote);
                  } else {
                    await DatabaseHelper().updateNote(newNote);
                  }

                  Navigator.pop(context);
                },
                child: Center(child: Text('Save',selectionColor: Color(0xFFF7EBE5),)),
                
              ),
            ],
          ),
        ),
      ),
    );
  }
}

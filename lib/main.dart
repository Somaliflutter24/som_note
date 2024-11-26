import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart'; // Import flutter_native_splash
import 'package:som_note/Settingsscreen.dart';
import 'package:som_note/models/notes.dart';
import 'package:som_note/notescreen.dart';

import 'models/DatabaseHelper.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding); // Ensures splash screen is preserved
  await Future.delayed(const Duration(seconds: 1)); // Add appropriate delay for splash
  FlutterNativeSplash.remove(); // Remove splash screen
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Some Note',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Note> notes = [];

  @override
  void initState() {
    super.initState();
    _loadNotes();
  }

  Future<void> _loadNotes() async {
    final fetchedNotes = await DatabaseHelper().getNotes();
    setState(() {
      notes = fetchedNotes;
    });
  }

  Future<void> _deleteNote(int id) async {
    await DatabaseHelper().deleteNote(id);
    _loadNotes(); // Refresh the list after deletion
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Note deleted')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7EBE5),
      appBar: AppBar(
        title: Text('Some Note'),
        backgroundColor: Color(0xFFF7EBE5),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SettingsPage(),
                ),
              );
            },
            icon: Icon(
              Icons.settings,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: notes.isEmpty
          ? Center(child: Text('No notes found'))
          : ListView.builder(
              itemCount: notes.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(notes[index].title),
                  subtitle: Text(notes[index].date.toString()),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NoteDetailScreen(note: notes[index]),
                      ),
                    ).then((_) => _loadNotes());
                  },
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      _deleteNote(notes[index].id!); // Use note's ID
                    },
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NoteDetailScreen(),
            ),
          ).then((_) => _loadNotes());
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.deepPurple, // A more contrasting background color
      ),
    );
  }
}

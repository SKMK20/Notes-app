import 'package:flutstar/services/auth/auth_service.dart';
import 'package:flutstar/services/crud/notes_service.dart';
import 'package:flutstar/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  late final NotesService _notesService;
  String get userEmail => AuthService.firebase().currentUser!.email!;

  @override
  void initState() {
    _notesService = NotesService();
    super.initState();
  }

  @override
  void dispose() {
    _notesService.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: false,
        title: const Text(
          'Notebook',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        actions: [
          // Edit Icon button
          IconButton(
            onPressed: () {},
            icon: const Icon(
              CupertinoIcons.ellipsis_vertical,
            ),
          ),
        ],
      ),
      body: FutureBuilder(
        future: _notesService.getOrCreateUser(email: userEmail),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              return StreamBuilder(
                stream: _notesService.allNotes,
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return const Text('waiting for all notes to appear...');
                    default:
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                  }
                },
              );
            default:
              return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      // Floating action button
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 5, right: 5),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pushNamed(newNoteRoute);
          },
          backgroundColor: Colors.deepPurple.shade200,
          elevation: 2,
          child: const Icon(CupertinoIcons.add, color: Colors.black),
        ),
      ),
    );
  }
}

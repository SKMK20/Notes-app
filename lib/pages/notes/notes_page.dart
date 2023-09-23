import 'package:flutstar/pages/notes/notes_list_view.dart';
import 'package:flutstar/services/auth/auth_service.dart';
import 'package:flutstar/services/cloud/cloud_note.dart';
import 'package:flutstar/services/cloud/firebase_cloud_storage.dart';
import 'package:flutstar/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  late final FirebaseCloudStorage _notesService;
  String get userId => AuthService.firebase().currentUser!.id;

  @override
  void initState() {
    _notesService = FirebaseCloudStorage();
    super.initState();
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
      body: StreamBuilder(
        stream: _notesService.allNotes(ownerUserId: userId),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
            case ConnectionState.active:
              if (snapshot.hasData) {
                final allNotes = snapshot.data as Iterable<CloudNote>;
                return NotesListView(
                  notes: allNotes,
                  onDeleteNote: (note) async {
                    await _notesService.deleteNote(documentId: note.documentId);
                  },
                  onTap: (note) {
                    Navigator.of(context).pushNamed(
                      createOrUpdateNoteRoute,
                      arguments: note,
                    );
                  },
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            default:
              return const Center(
                child: CircularProgressIndicator(),
              );
          }
        },
      ),
      // Floating action button
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 5, right: 5),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pushNamed(createOrUpdateNoteRoute);
          },
          backgroundColor: Colors.deepPurple.shade200,
          elevation: 2,
          child: const Icon(CupertinoIcons.add, color: Colors.black),
        ),
      ),
    );
  }
}

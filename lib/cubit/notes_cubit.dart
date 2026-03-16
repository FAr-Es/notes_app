import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../model/notes_model.dart';
part 'notes_state.dart';

class NotesCubit extends Cubit<NotesCubitState> {
  NotesCubit() : super(NotesCubitInitial());

  final _collection = FirebaseFirestore.instance.collection('notes');
  StreamSubscription? _subscription;

  void getNotes() {
    emit(NotesCubitLoading());
    _subscription = _collection
        .orderBy('createdAt', descending: true)
        .snapshots()
        .listen((snapshot) {
          final notes = snapshot.docs
              .map((doc) => NoteModel.fromFirestore(doc))
              .toList();
          emit(NotesCubitSuccess(notes: notes));
        });
  }

  Future<void> addNote(String title, String content) async {
    final newNote = NoteModel(
      id: '',
      title: title,
      content: content,
      createdAt: DateTime.now(),
    );

    await _collection.add(newNote.toMap());
  }

  Future<void> deleteNote(String id) async {
    await _collection.doc(id).delete();
  }

  Future<void> updateNote(String id, String title, String content) async {
    await _collection.doc(id).update({'title': title, 'content': content});
  }
}

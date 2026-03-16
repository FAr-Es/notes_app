import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notes_app/edit_note.dart';
import 'package:notes_app/model/notes_model.dart';

class NoteDetails extends StatelessWidget {
  const NoteDetails({super.key, required this.noteItem});
  final NoteModel noteItem;
  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat(
      'MM/dd/yyyy HH:mm',
    ).format(noteItem.createdAt);
    return Scaffold(
      backgroundColor: Color(0xFFF7FCFC),

      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EditNote(noteItem: noteItem)),
                );
              },
              child: Image.asset("assets/edit_icon.png"),
            ),
          ),
        ],
        backgroundColor: Color(0xFFF7FCFC),
        title: Text(
          "Notes Details",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Color(0xFF0D1C1C),
          ),
        ),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              noteItem.title,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: Color(0xFF0D1C1C),
              ),
            ),
            SizedBox(height: 12),
            Text(
              noteItem.content,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Color(0xFF0D1C1C),
              ),
            ),
            SizedBox(height: 12),
            Text(
              "Created At: $formattedDate",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Color(0xFF4A9C9C),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

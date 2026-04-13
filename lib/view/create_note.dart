import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/cubit/notes_cubit.dart';
import 'package:notes_app/view/custom_button.dart';
import 'package:notes_app/view/custom_textfield.dart';
import 'package:notes_app/view/notes_list.dart';

class CreateNote extends StatefulWidget {
  const CreateNote({super.key});

  @override
  State<CreateNote> createState() => _CreateNoteState();
}

class _CreateNoteState extends State<CreateNote> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final notesCubit = context.read<NotesCubit>();

    return Scaffold(
      backgroundColor: Color(0xFFF7FCFC),
      appBar: AppBar(
        backgroundColor: Color(0xFFF7FCFC),
        title: Text(
          "Create Note",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Color(0xFF0D1C1C),
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 16, right: 16, top: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Note Title",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF0D1C1C),
                ),
              ),
              SizedBox(height: 8),
              CustomTextField(
                controller: titleController,
                hintText: "Enter note title",
              ),

              SizedBox(height: 24),
              Text(
                "Content",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF0D1C1C),
                ),
              ),
              SizedBox(
                height: 144,
                child: CustomTextField(
                  controller: contentController,
                  hintText: "Enter note content",
                  height: 144,
                  expands: true,
                ),
              ),

              Spacer(),
              SizedBox(height: 12),
              CustomButton(
                text: "Save Note",
                onTap: () {
                  notesCubit.addNote(
                    titleController.text,
                    contentController.text,
                  );
                  titleController.clear();
                  contentController.clear();
                },
              ),
              SizedBox(height: 12),
              CustomButton(
                buttonColor: Colors.white,
                text: "View Notes",
                textStyle: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  color: Color(0xFF0D1C1C),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NotesList()),
                  );
                },
              ),

              SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}

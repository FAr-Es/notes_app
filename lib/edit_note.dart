import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/cubit/notes_cubit.dart';
import 'package:notes_app/model/notes_model.dart';

class EditNote extends StatefulWidget {
  const EditNote({super.key, required this.noteItem});
  final NoteModel noteItem;
  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    titleController.text = widget.noteItem.title;
    contentController.text = widget.noteItem.content;
  }

  @override
  Widget build(BuildContext context) {
    final notesCubit = context.read<NotesCubit>();

    return Scaffold(
      backgroundColor: Color(0xFFF7FCFC),
      appBar: AppBar(
        backgroundColor: Color(0xFFF7FCFC),
        title: Text(
          "Edit Note",
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
              TextFormField(
                controller: titleController,
                decoration: InputDecoration(
                  hintText: "Enter  note title",
                  hintStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF4A9C9C),
                  ),

                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFCFE8E8), width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFFCFE8E8),
                      width: 2.0,
                    ),
                  ),
                ),
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
                child: TextFormField(
                  controller: contentController,
                  maxLines: null,
                  minLines: null,
                  expands: true,
                  textAlignVertical: TextAlignVertical.top,
                  decoration: InputDecoration(
                    hintText: 'Enter note content',
                    hintStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF4A9C9C),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Color(0xFFCFE8E8)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: Color(0xFFCFE8E8),
                        width: 1,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: Color(0xFFCFE8E8),
                        width: 2,
                      ),
                    ),
                  ),
                ),
              ),

              Spacer(),
              SizedBox(height: 12),
              GestureDetector(
                child: Button(text: "Save Note"),
                onTap: () {
                  notesCubit.updateNote(
                    widget.noteItem.id,
                    titleController.text,
                    contentController.text,
                  );
                  Navigator.pop(context);
                  Navigator.pop(context);
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

class Button extends StatelessWidget {
  const Button({
    super.key,
    this.isfill = true,
    this.textStyle,
    required this.text,
  });
  final bool isfill;
  final TextStyle? textStyle;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 48,
      decoration: BoxDecoration(
        color: isfill ? Color(0xFF0AD9D9) : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(
          text,
          style:
              textStyle ??
              TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 16,
                color: Color(0xFFFFFFFF),
              ),
        ),
      ),
    );
  }
}

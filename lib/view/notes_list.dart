import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/cubit/notes_cubit.dart';
import 'package:notes_app/view/note_details.dart';

class NotesList extends StatefulWidget {
  const NotesList({super.key});

  @override
  State<NotesList> createState() => _NotesListState();
}

class _NotesListState extends State<NotesList> {
  @override
  void initState() {
    super.initState();
    context.read<NotesCubit>().getNotes(); // ✅ refresh every time screen opens
  }
  @override
  Widget build(BuildContext context) {
    final notesCubit = context.read<NotesCubit>();
    return Scaffold(
      backgroundColor: Color(0xFFF7FCFC),
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back),
        ),
        backgroundColor: Color(0xFFF7FCFC),
        title: Text(
          "Notes List",
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

          child: BlocBuilder<NotesCubit, NotesCubitState>(
            builder: (context, state) {
              if (state is NotesCubitLoading) {
                return Center(child: CircularProgressIndicator());
              }
              if (state is NotesCubitSuccess) {
                return ListView.separated(
                  itemCount: state.notes.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                NoteDetails(noteItem: state.notes[index]),
                          ),
                        );
                      },
                      child: ListTile(
                        title: Text(
                          state.notes[index].title,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF0D1C1C),
                          ),
                        ),
                        subtitle: Text(
                          state.notes[index].content,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF4A9C9C),
                          ),
                          maxLines: 2,
                        ),
                        trailing: GestureDetector(
                          child: Image.asset("assets/delete_icon.png"),
                          onTap: () {
                            notesCubit.deleteNote(state.notes[index].id);
                          },
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) =>
                      Padding(padding: EdgeInsets.only(bottom: 8)),
                );
              }
              return Center(
                child: Text("No Notes yet", style: TextStyle(fontSize: 60)),
              );
            },
          ),
        ),
      ),
    );
  }
}

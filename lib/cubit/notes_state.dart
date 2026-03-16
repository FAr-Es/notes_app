part of 'notes_cubit.dart';

@immutable
sealed class NotesCubitState {}

final class NotesCubitInitial extends NotesCubitState {}
final class NotesCubitLoading extends NotesCubitState {}
final class NotesCubitSuccess extends NotesCubitState {
  final List<NoteModel> notes;
  NotesCubitSuccess({required this.notes});
}
final class NotesCubitFailed extends NotesCubitState {}

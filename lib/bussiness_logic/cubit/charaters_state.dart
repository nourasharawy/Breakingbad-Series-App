part of 'charaters_cubit.dart';

@immutable
abstract class CharatersState {}

class CharatersInitial extends CharatersState {}

class CharactersLoaded extends CharatersState {
  final List<Character> characters;

  CharactersLoaded(this.characters);
}

class QuotesLoaded extends CharatersState {
  final List<Quote> quotes;

  QuotesLoaded(this.quotes);
}
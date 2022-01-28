import 'package:bloc/bloc.dart';
import 'package:bloc_breaking_trianing/data/models/charaters.dart';
import 'package:bloc_breaking_trianing/data/models/quote.dart';
import 'package:bloc_breaking_trianing/data/repoistory/character_repoistory.dart';
import 'package:meta/meta.dart';

part 'charaters_state.dart';

class CharatersCubit extends Cubit<CharatersState> {
  final CharactersRepoistory charactersRepoistory;
  CharatersCubit(this.charactersRepoistory) : super(CharatersInitial());
  List<Character>characters =[];

  List<Character>getAllCharacters(){
    charactersRepoistory.getAllCharacters().then((characters) {
      emit(CharactersLoaded(characters));
      this.characters = characters ;
    });
    return characters;
  }

  void getQuotes(String charName){
    charactersRepoistory.getCharactersQuotes(charName).then((quote) => {
      emit(QuotesLoaded(quote))
    });
  }
}

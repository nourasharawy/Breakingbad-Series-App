import 'package:bloc_breaking_trianing/data/models/charaters.dart';
import 'package:bloc_breaking_trianing/data/models/quote.dart';
import 'package:bloc_breaking_trianing/data/web_services/characters_web_services.dart';

class CharactersRepoistory{
  final CharactersWebServices charactersWebServices ;

  CharactersRepoistory(this.charactersWebServices);


  Future <List<Character>> getAllCharacters() async{
    final characters = await charactersWebServices.getAllCharacters();
    return characters.map((character) => Character.fromJson(character)).toList();
  }

  Future <List<Quote>> getCharactersQuotes(String charName) async{
    final quotes = await charactersWebServices.getCharacterQuotes(charName);
    return quotes.map((charQuotes) => Quote.fromJson(charQuotes)).toList();
  }
}
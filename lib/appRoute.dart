import 'package:bloc_breaking_trianing/bussiness_logic/cubit/charaters_cubit.dart';
import 'package:bloc_breaking_trianing/data/repoistory/character_repoistory.dart';
import 'package:bloc_breaking_trianing/data/web_services/characters_web_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'constants/strings.dart';
import 'data/models/charaters.dart';
import 'presentation/screens/character_details_screen.dart';
import 'presentation/screens/characters_screen.dart';

class AppRouter {
  late CharactersRepoistory charactersRepoistory;

  late CharatersCubit charatersCubit;

  AppRouter() {
    charactersRepoistory = CharactersRepoistory(CharactersWebServices());
    charatersCubit = CharatersCubit(charactersRepoistory);
  }

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case charactersScreen:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (BuildContext context) => CharatersCubit(charactersRepoistory),
                  child: CharactersScreen(),
                ));
      case characterDetails:
        final character = settings.arguments as Character;
        return MaterialPageRoute(builder: (_) => BlocProvider(
          create: (BuildContext context)=> CharatersCubit(charactersRepoistory),
          child: CharacterDetails(character :character),));
    }
  }
}

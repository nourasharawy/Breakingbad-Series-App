import 'package:bloc_breaking_trianing/bussiness_logic/cubit/charaters_cubit.dart';
import 'package:bloc_breaking_trianing/constants/my_colors.dart';
import 'package:bloc_breaking_trianing/data/models/charaters.dart';
import 'package:bloc_breaking_trianing/presentation/widgets/character_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';

class CharactersScreen extends StatefulWidget {
  @override
  _CharactersScreenState createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  late List<Character> allCharacters;
  late List<Character> searchedForCharacter;
  bool _isSerching = false;
  final _searchTextController = TextEditingController();

  Widget _buildSearchField() {
    return TextField(
      controller: _searchTextController,
      cursorColor: MyColors.myGrey,
      decoration: InputDecoration(
        hintText: 'Find a character...',
        border: InputBorder.none,
        hintStyle: TextStyle(fontSize: 18, color: MyColors.myGrey),
      ),
      style: TextStyle(fontSize: 18, color: MyColors.myGrey),
      onChanged: (searshedCharacter) {
        addSearchedForItemsToSearchedList(searshedCharacter);
      },
    );
  }

  void addSearchedForItemsToSearchedList(String searshedCharacter) {
    searchedForCharacter = allCharacters
        .where((character) =>
            character.name.toLowerCase().startsWith(searshedCharacter))
        .toList();
    setState(() {});
  }

  List<Widget> _buildAppBarActions() {
    if (_isSerching) {
      return [
        IconButton(
            icon: Icon(Icons.clear),
            color: MyColors.myGrey,
            onPressed: () {
              _clearSearch();
              Navigator.pop(context);
            })
      ];
    } else {
      return [
        IconButton(
            icon: Icon(Icons.search),
            color: MyColors.myGrey,
            onPressed: _startSearch)
      ];
    }
  }

  void _startSearch() {
    ModalRoute.of(context)!
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));
    setState(() {
      _isSerching = true;
    });
  }

  void _stopSearching() {
    _clearSearch();
    setState(() {
      _isSerching = false;
    });
  }

  void _clearSearch() {
    setState(() {
      _searchTextController.clear();
    });
  }

  @override
  void initState() {
    BlocProvider.of<CharatersCubit>(context).getAllCharacters();
    super.initState();
  }

  Widget _buildAppBarTitle() {
    return Text(
      "Characters",
      style: TextStyle(color: MyColors.myGrey),
    );
  }

  Widget buildNoInternetWidget() {
    return Center(
      child: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 20,
            ),
            Text(
              "No Internet Connection",
              style: TextStyle(
                fontSize: 22,
                color: MyColors.myGrey,
              ),
            ),
            Image.asset('asstes/images/connection error.png'),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: MyColors.myYellow,
          leading: _isSerching
              ? BackButton(
                  color: MyColors.myGrey,
                )
              : Container(),
          title: _isSerching ? _buildSearchField() : _buildAppBarTitle(),
          actions: _buildAppBarActions(),
        ),
        body: OfflineBuilder(
          connectivityBuilder: (
            BuildContext context,
            ConnectivityResult connectivity,
            Widget child,
          ) {
            final bool connected = connectivity != ConnectivityResult.none;
            if (connected) {
              return buildBlocWidget();
            } else {
              return buildNoInternetWidget();
            }
          },
          child: showLoadingIndicator(),
        ));
  }

  Widget buildBlocWidget() {
    return BlocBuilder<CharatersCubit, CharatersState>(
        builder: (context, state) {
      if (state is CharactersLoaded) {
        allCharacters = (state).characters;
        return buildLoadedListWidgets();
      } else {
        return showLoadingIndicator();
      }
    });
  }

  Widget showLoadingIndicator() {
    return Center(
      child: CircularProgressIndicator(
        backgroundColor: MyColors.myYellow,
      ),
    );
  }

  Widget buildLoadedListWidgets() {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: [buildCharactersList()],
        ),
      ),
    );
  }

  Widget buildCharactersList() {
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2 / 3,
          crossAxisSpacing: 1,
          mainAxisSpacing: 1,
        ),
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        padding: EdgeInsets.zero,
        itemCount: _searchTextController.text.isEmpty
            ? allCharacters.length
            : searchedForCharacter.length,
        itemBuilder: (ctx, index) {
          return CharacterItem(
              character: _searchTextController.text.isEmpty
                  ? allCharacters[index]
                  : searchedForCharacter[index]);
        });
  }
}

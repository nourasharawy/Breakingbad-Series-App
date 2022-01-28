import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:bloc_breaking_trianing/bussiness_logic/cubit/charaters_cubit.dart';
import 'package:bloc_breaking_trianing/constants/my_colors.dart';
import 'package:bloc_breaking_trianing/data/models/charaters.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CharacterDetails extends StatelessWidget {
  final Character character;

  const CharacterDetails({Key? key, required this.character}) : super(key: key);

  Widget buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 600,
      pinned: true,
      stretch: true,
      backgroundColor: MyColors.myGrey,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          character.nickname,
          style: TextStyle(color: MyColors.myWhite),
        ),
        background: Hero(
          tag: character.char_id,
          child: Image.network(
            character.img,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget characterInfo(String title, String value) {
    return RichText(
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(children: [
        TextSpan(
            text: title,
            style: TextStyle(
              color: MyColors.myWhite,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            )),
        TextSpan(
            text: value,
            style: TextStyle(
              color: MyColors.myWhite,
              fontSize: 16,
            )),
      ]),
    );
  }

  Widget buildDevider(double endIdent) {
    return Divider(
      height: 30,
      color: MyColors.myYellow,
      endIndent: endIdent,
      thickness: 2,
    );
  }

  checkIfQuotesAreLoaded(CharatersState state){
    if(state is QuotesLoaded)
      return displayRandomQoutesOrEmptySpace(state);
    else
      return showProgressIndicator();
  }

  Widget displayRandomQoutesOrEmptySpace(state){
     var qoutes = (state).quotes ;
     if(qoutes.length !=0){
       int randomIndex= Random().nextInt(qoutes.length-1);
       return Center(
         child:  DefaultTextStyle(
           textAlign: TextAlign.center,
           style: TextStyle(
             fontSize: 20,
             color: MyColors.myWhite,
             shadows: [
             Shadow  (
               blurRadius: 7,
               color: MyColors.myYellow,
               offset: Offset(0,0),
               )
             ],
           ),
           child: AnimatedTextKit(
             repeatForever: true,
             animatedTexts: [
               FlickerAnimatedText(qoutes[randomIndex].quote.toString()),
             ],
           ),
         ),
       );
     }else{
       return Container();
     }
  }

  Widget showProgressIndicator(){
    return Center(
      child: CircularProgressIndicator(
        backgroundColor: MyColors.myYellow,
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CharatersCubit>(context).getQuotes(character.name);
    return Scaffold(
      backgroundColor: MyColors.myGrey,
      body: CustomScrollView(
        slivers: [
          buildSliverAppBar(),
          SliverList(
              delegate: SliverChildListDelegate([
            Container(
              margin: EdgeInsets.fromLTRB(14, 14, 14, 0),
              padding: EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  characterInfo('Job : ' , character.occupation.join(' / ')),
                  buildDevider(330),
                  characterInfo('Appeared In : ' , character.category),
                  buildDevider(265),
                  characterInfo('Seasons : ' , character.appearance.join(' / ')),
                  buildDevider(295),
                  characterInfo('Status : ' , character.status),
                  buildDevider(310),
                  character.better_call_saul_appearance.isEmpty? Container():
                      characterInfo('Better Call Soul Seasons : ' , character.better_call_saul_appearance.join(' / ')),
                  character.better_call_saul_appearance.isEmpty? Container():
                  buildDevider(165),
                  characterInfo('Actor/Actress : ' , character.name),
                  buildDevider(250),
                  SizedBox(height: 20,),
                  
                  BlocBuilder<CharatersCubit, CharatersState>(builder: (context, state){
                    return checkIfQuotesAreLoaded(state);
                  }
                   )
                ],
              ),
            ),
                SizedBox(height: 500,),
          ]))
        ],
      ),
    );
  }
}

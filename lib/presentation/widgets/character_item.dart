import 'package:bloc_breaking_trianing/constants/my_colors.dart';
import 'package:bloc_breaking_trianing/constants/strings.dart';
import 'package:bloc_breaking_trianing/data/models/charaters.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CharacterItem extends StatelessWidget {
  final Character character ;
  const CharacterItem({Key? key, required this.character}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
      padding: EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        color: MyColors.myWhite,
        borderRadius: BorderRadius.circular(8),
      ),
       child: InkWell(
         onTap: ()=> Navigator.pushNamed(context, characterDetails, arguments: character),
         child: GridTile(
           child: Hero(
             tag: character.char_id,
             child: Container(
               color: MyColors.myGrey,
               child: character.img.isNotEmpty?
               FadeInImage.assetNetwork(
                 width: double.infinity,
                   height: double.infinity,
                   placeholder: 'asstes/images/loading.gif',
                   image: character.img.toString(),
                 fit: BoxFit.cover,
               ):
                   Image.asset('asstes/images/placeholder.png'),
             ),
           ),
           footer: Container(
             width: double.infinity,
             color: Colors.black54,
             padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
             alignment: Alignment.bottomCenter,
             child: Text(
               "${character.name}", style: TextStyle(height: 1.3, fontSize: 16, color: MyColors.myWhite, fontWeight: FontWeight.bold),
             overflow: TextOverflow.ellipsis,
               maxLines: 2,
               textAlign: TextAlign.center,
             ),

           ),
         ),
       ),
    );
  }
}

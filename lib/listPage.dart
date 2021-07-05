
import 'package:Medicine_Remainder/EditFamily.dart';
import 'package:flutter/material.dart';

class ConversationList extends StatefulWidget{
  String name;
  String messageText;
  String imageUrl;
  String time;
  bool isMessageRead;
  ConversationList({@required this.name,@required this.messageText,@required this.imageUrl,@required this.time,@required this.isMessageRead});
  @override
  _ConversationListState createState() => _ConversationListState();
}

class _ConversationListState extends State<ConversationList> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
      },
      child: Container(
        padding: EdgeInsets.only(left: 5,right: 5,top: 5,bottom: 5),
        child: Card(

     shadowColor: Colors.purple,
          elevation: 4,
          child: Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(8),
                child: CircleAvatar(
                  backgroundImage: widget.imageUrl.isNotEmpty
                      ? AssetImage(widget.imageUrl): null,
                  maxRadius: 30,
                ),
              ),
              SizedBox(width: 16,),
              Expanded(
                child: Container(
                  color: Colors.transparent,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(widget.name, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                      SizedBox(height: 6,),
                      Text(widget.messageText,style: TextStyle(fontSize: 13,color: Colors.grey.shade600, fontWeight: FontWeight.bold),),
                    ],
                  ),
                ),
              ),
              Container(
                  padding: EdgeInsets.all(7)
                  ,child: Text(widget.time,style: TextStyle(fontFamily:'Mate_SC' ,color:Colors.purple, fontSize: 22,fontWeight: FontWeight.bold),)),
                IconButton(onPressed:(){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EditFamily()));

                } , icon:Icon(Icons.arrow_forward_ios,color: Colors.red,))
            ],
          ),
        ),
      ),
    );
  }
}
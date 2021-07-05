
import 'package:Medicine_Remainder/EditFamily.dart';
import 'package:Medicine_Remainder/famDetails.dart';
import 'package:Medicine_Remainder/listPage.dart';
import 'package:flutter/material.dart';
class FamilyMembers extends StatefulWidget {
  // const FamilyMembers({Key? key}) : super(key: key);

  @override
  _FamilyMembersState createState() => _FamilyMembersState();
}

class _FamilyMembersState extends State<FamilyMembers> {
  List<ChatUsers> chatUsers = [
    ChatUsers(name: "Ramesh", messageText: "46 Years", imageURL: "assets/images/dad.jpeg", time: "Father"),
    ChatUsers(name: "Sita", messageText: "40 Years", imageURL: "assets/images/mom.jpeg", time: "Mother"),
    ChatUsers(name: "Priya", messageText: "27 Years", imageURL: "assets/images/wife.png", time: "Wife"),
    // ChatUsers(text: "Philip Fox", secondaryText: "Busy! Call me in 20 mins", image: "images/userImage4.jpeg", time: "28 Mar"),
    // ChatUsers(text: "Debra Hawkins", secondaryText: "Thankyou, It's awesome", image: "images/userImage5.jpeg", time: "23 Mar"),
    // ChatUsers(text: "Jacob Pena", secondaryText: "will update you in evening", image: "images/userImage6.jpeg", time: "17 Mar"),
    // ChatUsers(text: "Andrey Jones", secondaryText: "Can you please share the file?", image: "images/userImage7.jpeg", time: "24 Feb"),
    // ChatUsers(text: "John Wick", secondaryText: "How are you?", image: "images/userImage8.jpeg", time: "18 Feb"),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SafeArea(
              child: Container(

                height: 100,
                decoration: BoxDecoration(
                  color: Colors.purple,
                  borderRadius: const BorderRadius.vertical(bottom: Radius.circular(15.0)),
                ),
                padding: EdgeInsets.only(left: 16,right: 16,top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Family Members",style: TextStyle(color: Colors.white,fontFamily:'Mate_SC'
                        ,fontSize: 25,fontWeight: FontWeight.bold),),
                    Container(
                      padding: EdgeInsets.only(left: 8,right: 10,top: 2,bottom: 2),
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.pink[50],
                      ),
                      child: InkWell(
                        onTap: (){Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EditFamily()));},
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.add,color: Colors.pink,size: 20,),
                            SizedBox(width: 2,),
                            Text("Add New",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                          ],
                        ),
                      ),


                    ),

                  ],
                ),
              ),


            ),
            Container(child: ListView.builder(
              itemCount: chatUsers.length,
              shrinkWrap: true,
              padding: EdgeInsets.only(top: 16),
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index){
                return ConversationList(
                  name: chatUsers[index].name,
                  messageText: chatUsers[index].messageText,
                  imageUrl: chatUsers[index].imageURL,
                  time: chatUsers[index].time,
                  isMessageRead: (index == 0 || index == 3)?true:false,
                );
              },
            ),),
          ],
        ),
      ),
    );
  }
}



import 'package:chat_app/res/colors/color.dart';
import 'package:flutter/material.dart';
class MessageTile extends StatefulWidget {
 final  String sender;
 final String message;
 final bool sentByMe;
  const MessageTile({Key ?key,required this.sender,required this.message,required this.sentByMe}):super(key:key);

  @override
  State<MessageTile> createState() => _MessageTileState();
}

class _MessageTileState extends State<MessageTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 4,
        bottom: 4,
        left: widget.sentByMe? 0:24,
        right: widget.sentByMe? 24:0,
      ),
      alignment: widget.sentByMe? Alignment.centerRight :Alignment.centerLeft,
      child: Container(
        margin: widget.sentByMe?
        EdgeInsets.only(left: 30)
        :EdgeInsets.only(right: 30),
        padding: EdgeInsets.only(top: 17,bottom: 17,right:20,left: 20),
        decoration: BoxDecoration(
          borderRadius: widget.sentByMe?
          BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomLeft: Radius.circular(20),
          )
         : BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
        bottomRight: Radius.circular(20),
      ),
         color: widget.sentByMe?AppColors.primaryColor:Colors.grey[700]),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.sender.toUpperCase(),
           textAlign:TextAlign.center,
        style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: Colors.white,letterSpacing: -0.5),
            ),
            Text(widget.message,
            textAlign: TextAlign.center,style: TextStyle(fontSize: 16,color: Colors.white),)
          ],
        ),
      ),
    );
  }
}

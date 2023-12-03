import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String? uid;

  DatabaseService({this.uid});

//reference for our collection
  final CollectionReference userCollection =
  FirebaseFirestore.instance.collection("users");
  final CollectionReference groupCollection =
  FirebaseFirestore.instance.collection("groups");

  //saving userdata
  Future savingUserData(String fullName, String email,) async {
    return await userCollection.doc(uid).set({
      "fullName": fullName,
      "email": email,
      "groups": [],
      "profilePic": "",
      "uid": uid,
    });
  }

  //getting userdata
  Future gettingUserData(String email) async {
    QuerySnapshot snapshot = await userCollection.where(
        "email", isEqualTo: email).get();
    return snapshot;
  }

  //get user groups
  Future getUserGroups() async {
    return userCollection.doc(uid).snapshots();
  }

  //create group Structure
  Future createGroup(String userName, String id, String groupName) async {
    DocumentReference groupDocumentReference = await groupCollection.add({
      "groupName": groupName,
      "groupIcon": "",
      "admin": "${id}_$userName",
      "members": [],
      "groupId": "",
      "recentMessage": "",
      "recentMessageSender": "",
    });
    //update the members
    await groupDocumentReference.update({
      "members": FieldValue.arrayUnion(["${uid}_$userName"]),
      "groupId": groupDocumentReference.id,
    });
    DocumentReference userDocumentReference = userCollection.doc(uid);
    return await userDocumentReference.update({
      "groups": FieldValue.arrayUnion(
          ["${groupDocumentReference.id}_$groupName"]),
    });
  }
    //getting chat and admin info
    getChats(String groupId)async{
    return groupCollection.doc(groupId).
    collection("messages").
    orderBy("time").
    snapshots();
    }
    Future getGroupAdmin(String groupId)async{
    DocumentReference d=groupCollection.doc(groupId);
    DocumentSnapshot documentSnapshot =await d.get();
    return documentSnapshot['admin'];
    }
//getGroupMembers
getGroupMembers(String groupId) async{
    return groupCollection.doc(groupId).snapshots();
}
//searchByName
 searchByName(String groupName){
    return groupCollection.where("groupName",isEqualTo: groupName).get();
    
}
//function->bool
Future<bool> isUserJoined(String groupId,String groupName,String userName) async{
DocumentReference userDocumentReference=userCollection.doc(uid);
DocumentSnapshot documentSnapshot= await userDocumentReference.get();
List<dynamic> groups =await documentSnapshot["groups"];
if(groups.contains("${groupId}_$groupName")) {
  return true;
}else{
    return false;
}
}
// toggling the  group join/exit
Future toggleGroupJoin(
    String groupId,String groupName,String userName)async{
    DocumentReference userDocumentReference=userCollection.doc(uid);
    DocumentReference groupDocumentReference=groupCollection.doc(uid);
    DocumentSnapshot documentSnapshot=await userDocumentReference.get();
    List<dynamic>groups=await documentSnapshot ['groups'];
    //if user has our group-> then rejoin or remove
  if(groups.contains("${groupId}_$groupName}")){
    await userDocumentReference.update({
      "groups": FieldValue.arrayRemove(["${groupId}_$groupName"])
    });
        await groupDocumentReference.update({
        "members":FieldValue.arrayRemove(["${uid}_$userName"])
    });
  }else{
    await userDocumentReference.update({
      "groups": FieldValue.arrayUnion(["${groupId}_$groupName"])
    });
    await groupDocumentReference.update({
      "members": FieldValue.arrayUnion(["${uid}_$userName"])
    });
    }
  }
}



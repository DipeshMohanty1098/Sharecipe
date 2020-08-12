import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sharecipe/models/UserData.dart';
import 'package:sharecipe/models/recipe.dart';
import 'package:sharecipe/models/users.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});
  //collection reference for users
  final CollectionReference userCollection =
      Firestore.instance.collection('Users');

  //collection reference for recipes
  final CollectionReference recipeCollection =
      Firestore.instance.collection('Recipes');

  Future updateUserData(String name, int recipes, String photoURL) async {
    return await userCollection.document(uid).setData({
      'name': name,
      'recipes': recipes,
      'photoURL': photoURL,
    });
  }

  //check if document already exists
  Future checkIfDocExists() async {
    var a = await userCollection.document(uid).get();
    if (a.exists) {
      return true;
    } else {
      return false;
    }
  }

  //increase recipe count on publish
  Future updateRecipeCount(int count) async {
    return await userCollection.document(uid).updateData({
      'recipes': count + 1,
    });
  }

  Future reduceRecipeCount(int count) async {
    return await userCollection.document(uid).updateData({
      'recipes': count - 1,
    });
  }

  Future addRecipetoDB(
      String authorName,
      String recipeName,
      int recipePreptime,
      int cookingTime,
      String ingredients,
      String steps,
      String searchKey) async {
    return await recipeCollection.document(recipeName).setData({
      'uid': uid,
      'authorName': authorName,
      'recipeName': recipeName,
      'recipePreptime': recipePreptime,
      'cookingTime': cookingTime,
      'ingredients': ingredients,
      'steps': steps,
      'searchKey': searchKey,
    });
  }

  Future deleteRecipefromDB(String recipeName) async {
    return await recipeCollection.document(recipeName).delete();
  }

  //userdata from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
        name: snapshot.data['name'],
        recipes: snapshot.data['recipes'],
        photoURL: snapshot.data['photoURL']);
  }

  Stream<UserData> get userdata {
    return userCollection.document(uid).snapshots().map(_userDataFromSnapshot);
    //print(userCollection.document(uid).snapshots().map(_userDataFromSnapshot));
  }

  //recipelist from snapshot
  List<Recipes> _recipeListfromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Recipes(
          uid: uid,
          authorName: doc.data['authorName'],
          recipeName: doc.data['recipeName'],
          recipePreptime: doc.data['recipePreptime'],
          cookingTime: doc.data['cookingTime'],
          ingredients: doc.data['ingredients'],
          steps: doc.data['steps']);
      searchKey:
      doc.data['searchKey'];
    }).toList();
  }

  Stream<List<Recipes>> get recipes {
    return recipeCollection.snapshots().map(_recipeListfromSnapshot);
  }

  //Stream for user recipes
  Stream<List<Recipes>> get userRecipes {
    return recipeCollection
        .where('uid', isEqualTo: uid)
        .snapshots()
        .map(_recipeListfromSnapshot);
  }

  searchByName(String search) {
    return recipeCollection
        .where('searchKey', isEqualTo: search.substring(0, 1).toUpperCase())
        .getDocuments();
  }

  //Stream<List<Cooks>> get cooks {
  // return userCollection.snapshots().map(_userListfromSnapshot);
  // }

  //get user stream
  Stream<QuerySnapshot> get users {
    return userCollection.snapshots();
  }
}

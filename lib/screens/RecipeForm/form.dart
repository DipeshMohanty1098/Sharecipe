import 'dart:ffi';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sharecipe/models/UserData.dart';
import 'package:sharecipe/shared/AlertBox.dart';
import 'package:sharecipe/screens/RecipeForm/PreviewRecipe.dart';
import 'package:sharecipe/Drawer_Pages/user_drafts/drafts.dart';
import 'package:sharecipe/services/localDB_helper.dart';
import 'package:toast/toast.dart';

class DraftForm extends StatefulWidget {
  String uid;
  DraftForm({this.uid});
  @override
  _DraftFormState createState() => _DraftFormState();
}

class _DraftFormState extends State<DraftForm> {

  void joinAll(){
    joinSteps = '';
    joinIng = '';
    joinQuant = '';
    joinUnit = '';
    for (String i in steps){
      joinSteps += i + '\n';
    }
    for (int j=0;j<ingredients.length;j++){
      joinIng += ingredients[j] + '\n';
      joinQuant += quantity[j] + '\n';
      joinUnit += units[j] + '\n';
    }
  }

  void saveRecipeToDB(String name, String uid, int recipeCount){
    joinAll();
    LocalDatabaseService.instance.insert({
        LocalDatabaseService.uid : uid,
        LocalDatabaseService.authorName : name,
        LocalDatabaseService.cookingTime : cookingTime,
        LocalDatabaseService.recipePrepTime : recipePreptime,
        LocalDatabaseService.recipeCount : recipeCount,
        LocalDatabaseService.steps : joinSteps,
        LocalDatabaseService.ingredients : joinIng,
        LocalDatabaseService.quantity : joinQuant,
        LocalDatabaseService.units : joinUnit,
        LocalDatabaseService.private: _private.toString(),
        LocalDatabaseService.recipeName: recipeName,
    });
  }

  void updateRecipe(String name) async{
    joinAll();
    int updated =await LocalDatabaseService.instance.update({
        LocalDatabaseService.cookingTime : cookingTime,
        LocalDatabaseService.recipePrepTime : recipePreptime,
        LocalDatabaseService.steps : joinSteps,
        LocalDatabaseService.ingredients : joinIng,
        LocalDatabaseService.quantity : joinQuant,
        LocalDatabaseService.units : joinUnit,
        LocalDatabaseService.private: _private.toString(),
        LocalDatabaseService.recipeName: recipeName,
    },name);
    print(updated);
  }

  void addField(){ 
    //if (steps[steps.length - 1] == ''){
      //_showAlert();
    //}
    //else{
    _stepsCounter += 1;
    steps.add('');
    int label = _stepsCounter;
    formFields.add(TextFormField(
      decoration: InputDecoration(hintText: 'Enter Step ' + '${label.toString()}.',
      ),
      validator: (val){
        if (val == ''){
          return 'Please do not leave this field empty';
        }
      },
      autocorrect: true,
      onTap: () {
          setState(() {
            _changeNumber = label;
          });
        print(_changeNumber);
      },
      onChanged: (val){
        setState(() {
          steps[_changeNumber-1] = val;
          print(steps);
        });
        
      }, 
    ),
  );
    setState(() {
      formFields = formFields;
      steps = steps;
    });
    print(steps);
    //}
  }

  void removeField(){
    if (formFields.length > 1){
    _stepsCounter -= 1;
    steps.remove(steps[formFields.length-1]);
    formFields.remove(formFields[formFields.length-1]);
    setState(() {
      formFields = formFields;
      steps = steps;
    });
    }
    print(steps);
  }

   void addIngredientField(){ 
   // if (ingredients[ingredients.length-1] == '' || quantity[quantity.length-1] == ''){
    //  _showAlert();
    //}
   // else{
    _ingredientCounter += 1;
    ingredients.add('');
    quantity.add('');
    units.add('Grams');
    int label = _ingredientCounter;
    formFieldsIng.add(Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: 100.0,
                          child: TextFormField(
                              //keyboardType: TextInputType.multiline,
                              maxLines: null,
                              decoration:
                                  InputDecoration(hintText: 'Ingredient'),
                              validator: (val) {
                                if (val == ''){
                                  return 'Please do not leave this field empty';
                                }
                              },
                              autocorrect: true,
                              onTap: () {
                                setState(() {
                                  _changeIng = label;
                                });
                              },
                              onChanged: (val) {
                                setState(() {
                                  ingredients[_changeIng-1] = val;
                                  print(ingredients);
                                  print(units);
                                  print(quantity);
                                });
                              }),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Container(
                          width: 75,
                          child: TextFormField(
                              keyboardType: TextInputType.number,
                              //maxLines: null,
                              decoration: InputDecoration(hintText: 'Quantity'),
                              validator: (val) {
                                if (val == ''){
                                  return 'Please add a quantity for the ingredient';
                                };
                              },
                              autocorrect: true,
                              onChanged: (val) {
                                setState(() {
                                  quantity[_changeIng-1] = val;
                                });
                              }),
                        ),
                        SizedBox(width: 5),
                        Container(
                          width: 75,
                          child: DropdownButtonFormField(
                              decoration: InputDecoration(hintText: 'Unit'),
                              value: units[_ingredientCounter-1],
                              hint: Text('Units'),
                              items: _units.map((_) {
                                return DropdownMenuItem(
                                  value: _,
                                  child: Text('$_'),
                                );
                              }).toList(),
                              onChanged: (val) {
                                setState(() {
                                  units[_changeIng-1] = val;
                                });
                              }),
                        ),
                      ],
                    ),);
    setState(() {
      formFieldsIng = formFieldsIng;
      ingredients = ingredients;
      quantity = quantity;
      units = units;
    });
    print(ingredients);
    print(quantity);
    print(units);
    //}
  }

  void removeIngredientField(){
    if (formFieldsIng.length > 1 && quantity.length > 1 && units.length > 1){
    _ingredientCounter -= 1;
    formFieldsIng.remove(formFieldsIng[formFieldsIng.length-1]);
    ingredients.remove(ingredients[formFieldsIng.length-1]);
    quantity.remove(quantity[formFieldsIng.length-1]);
    units.remove(units[formFieldsIng.length-1]);
    setState(() {
      formFieldsIng = formFieldsIng;
      ingredients = ingredients;
      quantity = quantity;
      units = units;
    });
    }
    print(ingredients);
    print(quantity);
    print(units);
  }

  String Capitalize(String name) {
    return name.substring(0, 1).toUpperCase() + name.substring(1, name.length);
  }


  String saveRecipeName = '';
  bool isSaved = true;
  String joinSteps = '';
  String joinIng = '';
  String joinQuant =  '';
  String joinUnit = '';
  bool _private = false;
  int _changeNumber = 0;
  int _changeIng = 0;
  int _stepsCounter = 1;
  int _ingredientCounter = 1;
  String step = '';
  List<Widget> formFields = [];
  List<String> steps= [''];
  List<Widget> formFieldsIng = [];
  List<String> ingredients = [''];
  List<String> quantity = [''];
  List<String> units = ['Grams'];
  String recipeName = '';
  String recipePreptime = '';
  String cookingTime = '';
  final stepController = TextEditingController();
  List<TextEditingController> controllers = [TextEditingController()];
  final List<String> _units = [
    'Grams',
    'Kgs',
    'Cup(s)',
    'Tspn',
    'Tbsp',
    'Pieces'
  ];


  final _formKey = GlobalKey<FormState>();

  @override
  void initState(){
    super.initState();
    formFields.add(TextFormField(
      decoration: InputDecoration(hintText: 'Enter Step ' + '${(_stepsCounter).toString()}.' ),
      onChanged: (val){
        setState(() {
          steps[0] = val;
        });
      }
    ));
    formFieldsIng.add(Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: 100.0,
                          child: TextFormField(
                              //keyboardType: TextInputType.multiline,
                             // expands: true,
                              //maxLines: null,
                              decoration:
                                  InputDecoration(hintText: 'Ingredient'),
                              validator: (val) {
                                val.isEmpty ? 'Please do not leave this field empty.': null;
                              },
                              onChanged: (val) {
                                setState(() {
                                  ingredients[0] = val;
                                });
                              },
                              autocorrect: true,
                              ),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Container(
                          width: 75,
                          child: TextFormField(
                              keyboardType: TextInputType.number,
                              //maxLines: null,
                              decoration: InputDecoration(hintText: 'Quantity'),
                              validator: (val) {
                                val.isEmpty ? 'Please do not leave this field empty':null;
                              },
                              onChanged: (val) {
                                setState(() {
                                  quantity[0] = val;
                                });
                              },
                              autocorrect: true,),
                        ),
                        SizedBox(width: 5),
                        Container(
                          width: 75,
                          child: DropdownButtonFormField(
                              decoration: InputDecoration(hintText: 'Unit'),
                              value: units[0],
                              hint: Text('Units'),
                              items: _units.map((_) {
                                return DropdownMenuItem(
                                  value: _,
                                  child: Text('$_'),
                                );
                              }).toList(),
                              onChanged: (val) {
                                setState(() {
                                  units[0]= val;
                                });
                              }),
                        ),
                      ],
                    ),);
  }

  @override
  Widget build(BuildContext context) {
    final userdata = Provider.of<UserData>(context);
    return WillPopScope(
      onWillPop: (){
        Alert().showAlert(context);
      },
          child: SingleChildScrollView(
                child: Form(
              key: _formKey,
              child: Column(
                
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 30,),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                                    child: TextFormField(
                            autocorrect: true,
                            //keyboardType: TextInputType.multiline,
                            //maxLines: null,
                            maxLength: null,
                            decoration:
                                InputDecoration(hintText: 'Enter Recipe Name'),
                            validator: (val) =>
                                val.isEmpty ? 'Please Enter a Recipe Name' : null,
                            onChanged: (val) {
                              setState(() {
                                recipeName = (val);
                              });
                            }),
                  ),
                  SizedBox(height: 20.0),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal:30),
                                            child: TextFormField(
                            autocorrect: true,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                hintText: 'Enter the Preparation time(minutes)'),
                            validator: (val) =>
                                val.isEmpty ? 'Please fill this field' : null,
                            onChanged: (val) {
                              setState(() {
                                recipePreptime = val;
                              });
                            }),
                      ),
                      SizedBox(height: 20.0),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 30),
                                            child: TextFormField(
                            autocorrect: true,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                hintText: 'Enter the Cooking time(minutes)'),
                            validator: (val) =>
                                val.isEmpty ? 'Please fill this field' : null,
                            onChanged: (val) {
                              setState(() {
                                cookingTime = val;
                              });
                            }),
                      ),
                  SizedBox(height: 20.0,),   
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 25.0),
                    child: Column(children: formFieldsIng,) 
                  ),
                 FlatButton(onPressed: () => addIngredientField(),  
      child: Text("+ Add an Ingredient", style: TextStyle(color: Colors.blue)),
      ),
      FlatButton(onPressed: () => removeIngredientField(),  
      child: Text("Remove Last Ingredient", style: TextStyle(color: Colors.blue)),
      ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 30.0),
                    child: Column(children: formFields,) 
                  ),
                  SizedBox(height:10.0),
                  FlatButton(onPressed: () => addField(),  
      child: Text("+ Add a Step", style: TextStyle(color: Colors.blue)),
      ),
      FlatButton(onPressed: () => removeField(),  
      child: Text("Remove Last Step", style: TextStyle(color: Colors.blue)),
      ),
      SizedBox(height: 10,),
      Row(
                      children: [
                        Switch(
                            value: _private,
                            onChanged: (newVal) {
                              setState(() {
                                _private = newVal;
                                print(_private);
                              });
                            }),
                            Expanded(
                                                          child: Text(
                                'Private Recipe? Only you can view this recipe.',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                      ],
                    ),
      /*
      isSaved ? Container(
        width: 300,
            child: FlatButton(child: Text("Save Recipe as a draft?", style: TextStyle(color: Colors.black, fontSize: 15),),
        color: Colors.grey,
        onPressed: () async{
          if (_formKey.currentState.validate()){
          saveRecipeName = recipeName;
          saveRecipeToDB(userdata.name, widget.uid, userdata.recipes);
          Toast.show( "Recipe added to drafts.", context,
            duration: Toast.LENGTH_LONG,
            gravity: Toast.BOTTOM,
            backgroundColor: Colors.grey);
          setState(() {
            isSaved = false;
          });
          }
        },),
       ) : Container(
        child: FlatButton(child: Text("Save your changes", style: TextStyle(color: Colors.black, fontSize: 15),),
        color: Colors.grey,
        onPressed: () async{
          if (_formKey.currentState.validate()){
          updateRecipe(saveRecipeName);
          saveRecipeName = recipeName;
          Toast.show( "Changes Saved.", context,
            duration: Toast.LENGTH_LONG,
            gravity: Toast.BOTTOM,
            backgroundColor: Colors.grey);
          }
        },)
      ),
      */
      AnimatedCrossFade(firstChild: Container(
        width: 300,
            child: FlatButton(child: Text("Save Recipe as a draft?", style: TextStyle(color: Colors.black, fontSize: 15),),
        color: Colors.grey,
        onPressed: () async{
          if (_formKey.currentState.validate()){
          saveRecipeName = recipeName;
          saveRecipeToDB(userdata.name, widget.uid, userdata.recipes);
          Toast.show( "Recipe added to drafts.", context,
            duration: Toast.LENGTH_LONG,
            gravity: Toast.BOTTOM,
            backgroundColor: Colors.grey);
          setState(() {
            isSaved = false;
          });
          }
        },),
       ), 
      secondChild: Container(
        width: 300,
        child: FlatButton(child: Text("Save your changes", style: TextStyle(color: Colors.black, fontSize: 15),),
        color: Colors.grey,
        onPressed: () async{
          if (_formKey.currentState.validate()){
          updateRecipe(saveRecipeName);
          saveRecipeName = recipeName;
          Toast.show( "Changes Saved.", context,
            duration: Toast.LENGTH_LONG,
            gravity: Toast.BOTTOM,
            backgroundColor: Colors.grey);
          }
        },)
      ), 
      crossFadeState: isSaved? CrossFadeState.showFirst: 
      CrossFadeState.showSecond, 
      duration: const Duration(milliseconds: 2000)),
      SizedBox(height: 20,),
      Container(
        width: 300,
            child: FlatButton(child: Text("Preview your recipe?", style: TextStyle(color: Colors.black, fontSize: 15),),
        color: Colors.grey,
        onPressed: (){
           if (_formKey.currentState.validate()) {
              SystemChannels.textInput.invokeMethod('TextInput.hide');
              updateRecipe(saveRecipeName);
              saveRecipeName = recipeName;
          Navigator.push(context, MaterialPageRoute(
          builder: (context) =>PreviewRecipe(
            steps: steps,
            ingredients: ingredients,
            recipeName: recipeName,
            cookingTime: cookingTime,
            recipePrepTime: recipePreptime,
            quantity: quantity,
            units: units,
            authorName: userdata.name,
            private: _private,
            recipes: userdata.recipes,
            uid: widget.uid,
          )
          )
          );
           }
        },),
      ),
      SizedBox(height:25)
      
                ]
              )
          ),
        ),
    );
  }
}
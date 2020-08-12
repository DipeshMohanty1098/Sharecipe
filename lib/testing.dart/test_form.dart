import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sharecipe/models/UserData.dart';
import 'package:provider/provider.dart';
import 'package:sharecipe/screens/Confirmation.dart';
import 'package:sharecipe/services/database.dart';
import 'package:toast/toast.dart';

class RecipeFormBodyTest extends StatefulWidget {
  RecipeFormBodyTest({this.uid});
  String uid;
  @override
  _RecipeFormBodyTestState createState() => _RecipeFormBodyTestState();
}

class _RecipeFormBodyTestState extends State<RecipeFormBodyTest> {
  String recipeName = '';
  String recipePreptime = '';
  String cookingTime = '';
  String ingredient = '';
  String ingredients = '';
  String step = '';
  String steps = '';
  String quantity = '';
  int ingCount = 0;
  int stepCount = 0;
  String _unitText = 'Grams';
  final ingHolder = TextEditingController();
  final stepHolder = TextEditingController();
  final quantityHolder = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final List<String> _units = [
    'Grams',
    'Kgs',
    'Cup(s)',
    'Tspn',
    'Tbsp',
    'Pieces'
  ];
  List<String> stepsList = [];
  List<String> ingredientList = [];
  String previewIng(List ingredientLists) {
    setState(() {
      ingredients += ingredientLists.length.toString() +
          '.' +
          ' ' +
          ingredientLists[ingCount] +
          '\n';
      ingCount += 1;
    });
  }

  String previewIngState(List ingredientLists) {
    setState(() {
      ingredients = '';
    });
    for (int i = 0; i < ingredientLists.length; i++) {
      setState(() {
        ingredients +=
            (i + 1).toString() + '.' + ' ' + ingredientLists[i] + '\n';
      });
    }
  }

  Future<void> _showAlert() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Alert!',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Please fill the field to add'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  String previewStep(List stepLists) {
    setState(() {
      steps +=
          stepLists.length.toString() + '.' + ' ' + stepLists[stepCount] + '\n';
      stepCount += 1;
    });
  }

  String previewStepstate(List stepLists) {
    setState(() {
      steps = '';
    });
    for (int i = 0; i < stepLists.length; i++) {
      setState(() {
        steps += (i + 1).toString() + '.' + ' ' + stepLists[i] + '\n';
      });
    }
  }

  String Capitalize(String name) {
    return name.substring(0, 1).toUpperCase() + name.substring(1, name.length);
  }

  @override
  Widget build(BuildContext context) {
    final userdata = Provider.of<UserData>(context);

    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
        child: Center(
            child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 20.0),
                    TextFormField(
                        autocorrect: true,
                        //keyboardType: TextInputType.multiline,
                        //maxLines: null,
                        maxLength: 15,
                        decoration:
                            InputDecoration(hintText: 'Enter Recipe Name'),
                        validator: (val) =>
                            val.isEmpty ? 'Please Enter a Recipe Name' : null,
                        onChanged: (val) {
                          setState(() {
                            recipeName = (val);
                          });
                        }),
                    SizedBox(height: 20.0),
                    TextFormField(
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
                    SizedBox(height: 20.0),
                    TextFormField(
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
                    SizedBox(height: 20.0),
                    Text(
                      "Added Ingredients (Preview)",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 20.0),
                    ),
                    Text(
                      ingredients,
                      style: TextStyle(color: Colors.black, fontSize: 20.0),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: 100.0,
                          child: TextFormField(
                              controller: ingHolder,
                              //keyboardType: TextInputType.multiline,
                              maxLines: null,
                              decoration:
                                  InputDecoration(hintText: 'Ingredient'),
                              validator: (val) {
                                if (ingredientList.length == 0) {
                                  return 'Please add an ingredient';
                                }
                              },
                              onChanged: (val) {
                                setState(() {
                                  ingredient = val;
                                });
                              }),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Container(
                          width: 75,
                          child: TextFormField(
                              controller: quantityHolder,
                              keyboardType: TextInputType.number,
                              //maxLines: null,
                              decoration: InputDecoration(hintText: 'Quantity'),
                              validator: (val) {
                                if (ingredientList.length == 0) {
                                  return 'Please add an ingredient';
                                }
                              },
                              onChanged: (val) {
                                setState(() {
                                  quantity = val;
                                });
                              }),
                        ),
                        SizedBox(width: 5),
                        Container(
                          width: 75,
                          child: DropdownButtonFormField(
                              decoration: InputDecoration(hintText: 'Unit'),
                              value: _unitText,
                              hint: Text('Units'),
                              items: _units.map((_) {
                                return DropdownMenuItem(
                                  value: _,
                                  child: Text('$_'),
                                );
                              }).toList(),
                              onChanged: (val) {
                                setState(() {
                                  _unitText = val;
                                });
                              }),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    FlatButton(
                      color: Colors.blue,
                      child: Text("Add Ingredient"),
                      onPressed: () async {
                        if (ingredient == '' || quantity == '') {
                          _showAlert();
                        } else {
                          ingredientList.add(Capitalize(ingredient) +
                              ' x ' +
                              quantity +
                              ' ' +
                              _unitText);
                          setState(() {
                            ingredient = '';
                            quantity = '';
                          });
                          ingHolder.clear();
                          quantityHolder.clear();
                          print(ingredientList);
                          previewIng(ingredientList);
                          Toast.show(
                            "Ingredient added.",
                            context,
                            duration: Toast.LENGTH_LONG,
                            gravity: Toast.BOTTOM,
                            backgroundColor: Colors.grey,
                          );
                        }
                      },
                    ),
                    FlatButton(
                      color: Colors.blue,
                      child: Text("Remove previous Ingredient"),
                      onPressed: () async {
                        ingredientList
                            .remove(ingredientList[ingredientList.length - 1]);
                        print(ingredientList);
                        setState(() {
                          ingCount -= 1;
                        });
                        if (ingCount == 0) {
                          setState(() {
                            ingredients = '';
                          });
                        } else
                          previewIngState(ingredientList);
                      },
                    ),
                    SizedBox(height: 20.0),
                    Text(
                      "Added Steps (Preview)",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 20.0),
                    ),
                    Text(
                      steps,
                      style: TextStyle(color: Colors.black, fontSize: 20.0),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                        autocorrect: true,
                        keyboardType: TextInputType.text,
                        //maxLength: 500,
                        controller: stepHolder,
                        maxLines: null,
                        decoration: InputDecoration(hintText: 'Add a step'),
                        validator: (val) {
                          if (stepsList.length == 0) {
                            return 'Please add a Step';
                          }
                        },
                        onChanged: (val) {
                          setState(() {
                            step = val;
                          });
                        }),
                    SizedBox(height: 5.0),
                    FlatButton(
                      color: Colors.blue,
                      child: Text("Add Step"),
                      onPressed: () async {
                        if (step == '') {
                          _showAlert();
                        } else {
                          stepsList.add(Capitalize(step));
                          setState(() {
                            step = '';
                          });
                          stepHolder.clear();
                          print(stepsList);
                          previewStep(stepsList);
                          Toast.show("Step added.", context,
                              duration: Toast.LENGTH_LONG,
                              gravity: Toast.BOTTOM,
                              backgroundColor: Colors.grey);
                        }
                      },
                    ),
                    FlatButton(
                      color: Colors.blue,
                      child: Text("Remove previous Step"),
                      onPressed: () async {
                        stepsList.remove(stepsList[stepsList.length - 1]);
                        print(stepsList);
                        setState(() {
                          stepCount -= 1;
                        });
                        if (stepCount == 0) {
                          setState(() {
                            steps = '';
                          });
                        } else
                          previewStepstate(stepsList);
                      },
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50.0,
                      child: RaisedButton(
                          onPressed: () async {
                            Future<void> _showMyDialog() async {
                              return showDialog<void>(
                                context: context,
                                barrierDismissible:
                                    false, // user must tap button!
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text(
                                      'Are You Sure?',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    content: SingleChildScrollView(
                                      child: ListBody(
                                        children: <Widget>[
                                          Text(
                                              'Are you sure you want to publish your recipe?'),
                                          Text('It cannot be edited later.'),
                                        ],
                                      ),
                                    ),
                                    actions: <Widget>[
                                      FlatButton(
                                        child: Text(
                                            'No, Review my recipe again',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      FlatButton(
                                        child: Text('Yes, publish my Recipe',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                        onPressed: () async {
                                          if (_formKey.currentState
                                              .validate()) {
                                            print('confirmed');
                                            SystemChannels.textInput
                                                .invokeMethod('TextInput.hide');
                                            DatabaseService(uid: widget.uid)
                                                .addRecipetoDB(
                                                    userdata.name,
                                                    Capitalize(recipeName) +
                                                        '.' +
                                                        widget.uid,
                                                    int.parse(recipePreptime),
                                                    int.parse(cookingTime),
                                                    ingredients,
                                                    steps,
                                                    recipeName
                                                        .substring(0, 1)
                                                        .toUpperCase());
                                            DatabaseService(uid: widget.uid)
                                                .updateRecipeCount(
                                                    userdata.recipes);
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ConfirmationPage()));
                                          }
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            }

                            ;
                            if (_formKey.currentState.validate()) {
                              _showMyDialog();
                            }
                            ;
                          },
                          color: Colors.grey,
                          child: Text("Publish your Recipe")),
                    ),
                  ],
                ))),
      ),
    );
  }
}

class Recipes {
  final String authorName;
  final String recipeName;
  final int recipePreptime;
  final int cookingTime;
  final String ingredients;
  final String steps;
  final String uid;
  final String searchKey;
  final String private;
  Recipes(
      {this.recipeName,
      this.recipePreptime,
      this.authorName,
      this.cookingTime,
      this.ingredients,
      this.steps,
      this.uid,
      this.searchKey,
      this.private});
}

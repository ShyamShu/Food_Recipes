
class recipeModel{
   String appUrl = "";
   String appLabel = "";
   String appImage = "";
   String appCalorie = "";


   recipeModel();

   recipeModel.name({required this.appImage,required this.appLabel, required this.appCalorie, required this.appUrl});

   factory recipeModel.fromMap(Map recipe)
   {
      return recipeModel.name(
          appImage: recipe["image"].toString(),
          appLabel: recipe["label"].toString(),
          appCalorie: recipe["calories"].toString(),
          appUrl: recipe["url"].toString(),
      );
   }
}

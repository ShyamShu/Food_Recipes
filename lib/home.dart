import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:foodieee/model.dart';
import 'package:foodieee/recipe_view.dart';
import 'package:foodieee/search.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isLoading = true;
  List<recipeModel> recipeList = <recipeModel>[];
  TextEditingController searchController = new TextEditingController();
  List reciptCatList = [{"imgUrl": "https://images.unsplash.com/photo-1593560704563-f176a2eb61db", "heading": "Chilli Food"},{"imgUrl": "https://images.unsplash.com/photo-1593560704563-f176a2eb61db", "heading": "Chilli Food"},{"imgUrl": "https://images.unsplash.com/photo-1593560704563-f176a2eb61db", "heading": "Chilli Food"},{"imgUrl": "https://images.unsplash.com/photo-1593560704563-f176a2eb61db", "heading": "Chilli Food"},{"imgUrl": "https://images.unsplash.com/photo-1593560704563-f176a2eb61db", "heading": "Chilli Food"},{"imgUrl": "https://images.unsplash.com/photo-1593560704563-f176a2eb61db", "heading": "Chilli Food"},{"imgUrl": "https://images.unsplash.com/photo-1593560704563-f176a2eb61db", "heading": "Chilli Food"},{"imgUrl": "https://images.unsplash.com/photo-1593560704563-f176a2eb61db", "heading": "Chilli Food"}];
  getRecipe(String query) async {
    print(query);
    Uri url = Uri.parse("https://api.edamam.com/search?q=$query&app_id=3280428a&app_key=928d897c02fcfced052a5bd001a850d7");
    Response response = await http.get(url);
    if (response.statusCode == 200) {
      Map data = jsonDecode(response.body);
      // List hit = data["hits"];
      // Map d = hit[1];
      // Map recipe= d["recipe"];
      // String label = recipe["label"].toString();
      // print(label);
      //log(data.toString());

      data["hits"].forEach((Element) {
        recipeModel recipemodel = new recipeModel();
        recipemodel = recipeModel.fromMap(Element["recipe"]);
        recipeList.add(recipemodel);
        setState(() {
          isLoading = false;
        });
        //log(recipeList.toString());
      });
      recipeList.forEach((recipe) {
        print(recipe.appCalorie);
      });
    }
    else {
      print(" action failed");
    }
  }
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    getRecipe("Ladoo");
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
                  Color(0xff213A50),
                  Color(0xff071938),
                ])),
          ),
          SingleChildScrollView(
            child: SafeArea(
              child: Column(
                children: [
                  Container(
                    //search container
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(32),
                    ),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (searchController.text.replaceAll("  ", "") ==
                                "") {
                              print("blank search");
                            } else {
                              Navigator.push(context, MaterialPageRoute(builder:(context)=> search(searchController.text)));
                            }
                          },
                          child: const Icon(
                            Icons.search,
                            color: Colors.blueAccent,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: TextField(
                            controller: searchController,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: "Lets Cook Something !",
                            ),
                          ),
                        )
                      ],
                    ),
                  ),

                  // text container
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "WHAT DO YOU WANT TO COOK TODAY !! ",
                          style: TextStyle(fontSize: 35, color: Colors.white),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Text(
                          "LETS COOK SOMETHING NEW",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        )
                      ],
                    ),
                  ),
                  Container(
                    child:isLoading ? const  CircularProgressIndicator() : ListView.builder(
                        scrollDirection: Axis.vertical,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: recipeList.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => Recipe_View(recipeList[index].appUrl)));
                            },
                            child: Card(
                              margin:const  EdgeInsets.all(25),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    child: Image.network(
                                      recipeList[index].appImage,
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      height: 280,
                                    ),
                                  ),
                                  Positioned(
                                    left: 0,
                                    right: 0,
                                    bottom: 0,
                                    child: Container(
                                      padding:const EdgeInsets.symmetric(
                                          vertical: 18, horizontal: 20),
                                      decoration:const BoxDecoration(
                                        color: Colors.black38,
                                      ),
                                      child: Text(
                                          recipeList[index].appLabel,
                                          style: const TextStyle(
                                              fontSize: 25,
                                              color: Colors.white)
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                      right: 0,
                                      height: 60,
                                      width: 90,
                                      child: Container(
                                          padding:const EdgeInsets.symmetric(vertical: 12),
                                          decoration:const BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(20),
                                                bottomLeft: Radius.circular(20),
                                              )
                                          ),
                                          child: Center(
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                const Icon(Icons.local_fire_department),
                                                Text(recipeList[index].appCalorie.toString().substring(0,5) ,style:const TextStyle(fontSize: 18,color: Colors.black87),),
                                              ],
                                            ),
                                          ))),
                                ],
                              ),
                            ),
                          );
                        }),
                  ),

                  Container(
                    height: 200,

                    child: ListView.builder(
                        itemCount: reciptCatList.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context,index){
                          return Container(
                            child: InkWell(
                              onTap: (){},
                              child: Card(
                                margin:const  EdgeInsets.all(25),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius : BorderRadius.circular(18.0),
                                      child: Image.network(reciptCatList[index]["imgUrl"],
                                        fit: BoxFit.cover,
                                        width:150,
                                        height:280,),

                                    ),
                                    Positioned(
                                        left: 0,
                                        right: 0,
                                        bottom: 0,
                                        top: 0,
                                        child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 5, horizontal: 10),
                                            decoration:const BoxDecoration(
                                                color: Colors.black26),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  reciptCatList[index]["heading"],
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 28),
                                                ),
                                              ],
                                            ))),
                                  ],
                                ),
                              ),
                            ),
                          );

                    }),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

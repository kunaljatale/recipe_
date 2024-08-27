import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:receipe_app/model.dart';

class Homepage extends StatefulWidget {
  
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}


  TextEditingController searchController= new TextEditingController();
class _HomepageState extends State<Homepage> {

List <RecipeModel> recipeList=[];

  
   Future getRecipe(String query)async{
   String url = "https://api.edamam.com/api/recipes/v2?type=public&q=$query&app_id=bd3fd17d&app_key=67d53e0c56e47faf15db01e575362fdc";


    // String url ="Image.network('https://https://api.edamam.com/api/recipes/v2?type=public&q=$query&app_id=bd3fd17d&app_key=67d53e0c56e47faf15db01e575362fdc";
   try{
  final response= await http.get(Uri.parse(url));


   if (response.statusCode==200){
    Map <String,dynamic>data =jsonDecode(response.body);

if(data["hits"]!=null){
data["hits"].forEach((element){
    RecipeModel newRecipeModel= new RecipeModel();
    newRecipeModel=RecipeModel.fromMap(element["recipe"]);
    recipeList.add(newRecipeModel);
    
});


}else{
  print("Error:'hits not found");
}
     



   
     

    // print(recipeList.toString());
  recipeList.forEach((recipe){
print(recipe.appcalories.toString());
print(recipe.appimgUrl.toString());
// print(recipe.appcalories.toString());


  });

  setState(() {
    
  });
}  else{
  print("Error: Received status code ${response.statusCode}" );
}
   }catch(e){
  print("error$e");
   }
  

   }

   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        title: Text("Recipe App",style: TextStyle(color: Colors.white),
        ),
      ),
  body: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width ,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  Color(0xff213A50),
                  Color(0xff071938),

                ])
              ),
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  //search bar
              
                     SafeArea(
                       child: Container(
                                   padding: EdgeInsets.symmetric(horizontal: 10),
                                   margin: EdgeInsets.symmetric(horizontal: 24,vertical:20 ),
                                   decoration: BoxDecoration(
                                     borderRadius:BorderRadius.circular(30) ,
                                     color: Colors.white
                                   ),
                                   //search wala container
                                 child: Row(
                                   
                                   children: [
                                GestureDetector(
                             onTap: (){
                         getRecipe(searchController.text);
                           
                         
                       
                               print(searchController.text);
                             },
                             child: Container(
                               padding: EdgeInsets.fromLTRB(3, 0, 7, 0),
                               child: Icon(Icons.search,size: 30,color: Colors.black,)
                               ),
                                ),
                       
                                     Expanded(
                                       child: TextField(
                                         controller: searchController,
                                         decoration: InputDecoration(
                        hintText: "Serch recipe here",
                        border: InputBorder.none,
                                         ),
                                         
                                       ),
                                     )
                                   ],
                                 ),
                                 ),
                     ),
              
                     Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("WHAT DO YOU WANT TO COOK TODAY?",style: TextStyle(color: Colors.white, fontSize: 30)),
                       SizedBox(height: 15,),
                     
                     Text("Cook Something New!",style: TextStyle(color: Colors.white,fontSize: 20))
                     
                        ],
                      ),
                     ),
                     Container(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: recipeList.length,
                        itemBuilder: (context,index){
                        return InkWell(
                          onTap: (){},
                          child: Card(
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child:Image.network(recipeList[index].appimgUrl.toString(),
                                  fit: BoxFit.cover,
                                height: 200,
                                width: MediaQuery.of(context).size.width,
                                loadingBuilder: (context,child,progress){
                                  return progress==null?child:Center(child: CircularProgressIndicator(),);
                                },
                                errorBuilder: (context,error,StackTrace){
                                  return Center( 
                                    
                                    child: Icon(Icons.error)
                                    
                                     );
                                },
                                  
                                  )
                                ),

                              ],
                            ),
                          ),
                        );
                      }),
                     )
                ],
              ),
            ),

          ],

        ) ,
 
    ) ;
  }
}


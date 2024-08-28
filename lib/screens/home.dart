
import 'package:fake_store/models/product.dart';
import 'package:fake_store/screens/all_category.dart';
import 'package:fake_store/screens/cart_screen.dart';
import 'package:fake_store/screens/product_detail.dart';
import 'package:fake_store/services/apiService.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget{
  HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.redAccent,
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => AllCategory()));
          }, icon: const Icon(Icons.view_list)),

          IconButton(onPressed: (){
            Navigator.push(context,MaterialPageRoute(builder: (context)=>CartScreen()));

          }, icon: const Icon(Icons.shopping_cart)
          )
        ],


      ),
      body: FutureBuilder(
        future: ApiService().getAllPosts(),
        builder: (context, AsyncSnapshot snapshot){
          if(snapshot.hasData){
            return Center(
              child: ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context,index){
                  Product product = snapshot.data[index];
                  return ListTile(
                    title: Text(product.title),
                    leading: Image.network(product.image,height: 50,width: 30,),
                    subtitle: Text("Price - \$"+product.price.toString()),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductDetail(product.id)));

                     // Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductDetail(snapshot.data[index]['id'])));
                    },
                  );
                } ),           
              
            );

        }

        return const Center(
          child: CircularProgressIndicator(),
        );
  }),
    );
  }
}
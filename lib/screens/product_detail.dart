
import 'package:fake_store/models/product.dart';
import 'package:fake_store/services/apiService.dart';
import 'package:flutter/material.dart';

class ProductDetail extends StatelessWidget{
  final int id;
  ProductDetail(this.id);
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
      ),
      body: FutureBuilder(
        future: ApiService().getSingleProduct(id),
        builder: (context,AsyncSnapshot snapshot){
          if(snapshot.hasData){
            
            Product product = snapshot.data;
            return  SingleChildScrollView(
                 child:Container(
              margin: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30,),
                  Image.network(snapshot.data['image'],height: 200,width: double.infinity,),
                  const SizedBox(height: 10,),
                  Center(
                    child: Text("\$"+product.price.toString(),style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold
                    ),),
                  ),
                  const SizedBox(height: 10,),
                  Text(snapshot.data['title'],style: const TextStyle(
                    fontSize: 25,
                  ),),
                  Chip(label: Text(product.category.toString(),style: const TextStyle(
                    fontSize: 15,
                    color: Colors.white
                  ),),backgroundColor: Colors.blueGrey,),
                  const SizedBox(height: 30,),
                  Text(snapshot.data['description']),
                  
                  
                ],
              ),
            )
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add_shopping_cart_outlined),
        onPressed: () {
          
        },
        backgroundColor: Colors.green,
       ),
       floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
  



}
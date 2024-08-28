

import 'package:fake_store/models/product.dart';
import 'package:fake_store/services/apiService.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget{
  CartScreen ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Your cart"),
        centerTitle: true,
        backgroundColor: Colors.redAccent,
      ),
      body: FutureBuilder(
        future: ApiService().getCart('1'),
        builder: (context,AsyncSnapshot snapshot){
          if(snapshot.hasData){
            List products = snapshot.data['products'];
            return ListView.builder(
              itemCount: products.length,
              itemBuilder: (context,index){
                return FutureBuilder(
                  future: ApiService().getSingleProduct(products[index]['productId']), 
                  builder: (context,AsyncSnapshot asyncSnapshot){
                    if(asyncSnapshot.hasData){
                      Product product = asyncSnapshot.data;
                      return ListTile(
                        title: Text(product.title),
                        leading: Image.network(product.image,height: 40,),
                        subtitle: Text("Quantity - "+products[index]['quantity'].toString()),
                        trailing: IconButton(onPressed: () async {
                          await ApiService().deleteCart('1');
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Item Deleted Sucessfully !"),));
                        },icon: Icon(Icons.delete,color: Colors.red,),),
                      );
                    }
                    return LinearProgressIndicator();
                  });
              });
          }
          return Center(
            child: CircularProgressIndicator(),
          );

      }),

      bottomNavigationBar: Container(
        height: 60,
        width: double.infinity,
        color: Colors.green,
        child: Center(
          child: Text("Order Now",style: TextStyle(
            color: Colors.white,
            fontSize: 30
          ),),
        ),
      ),
    );
  }
}
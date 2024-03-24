import "package:flutter/material.dart";
import "package:stock1/infrastructure/DB/queries/crud.dart";
import "package:stock1/presentation/screens/prodform.dart";

import "../../infrastructure/models/prods.dart";

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  MainRoute createState() => MainRoute();
}

class MainRoute extends State<ProductList> {
  late Future<List<Prod>> productListFuture;

  @override
  void initState() {
    super.initState();
    productListFuture = products();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('test title'),
      ),
      body: FutureBuilder<List<Prod>>(
          future: productListFuture,
          builder: (context, index) {
            if (index.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (index.hasError) {
              return Center(child: Text('Error: ${index.error}'));
            } else {
              final List<Prod> productList = index.data!;
              return ListView.builder(
                itemCount: productList.length,
                itemBuilder: (context, index) {
                  return Dismissible(
                    onDismissed: (direction) {
                      setState(() {
                        deleteProd(productList[index].id);
                        productList.removeAt(index);
                      });
                    },
                    key: UniqueKey(), 
                    child: ListTile(
                      title: Text(productList[index].name),
                      subtitle: Text('Stock: ${productList[index].stock}'),
                      leading: CircleAvatar(
                        child: Text('${productList[index].id}'),
                      ),
                    )
                  );
                  
                },
              );
            }
          },
        ) ,
      floatingActionButton: FloatingActionButton(onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => const Prods())).then((_) => setState(() {
          productListFuture = products();
        }));
      },),
      
    );
  }
  
}
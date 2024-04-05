import "package:flutter/material.dart";
import "package:flutter/widgets.dart";
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
        title: const Text('Products'),
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
              if (productList.isEmpty) {
                return const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.assignment_add,
                        color: Colors.yellow,
                        size: 150,
                      ),
                      Text('No items')
                    ],
                  )
                );
              }else{

                return ListView.builder(
                  itemCount: productList.length,
                  itemBuilder: (context, index) {
                    return Dismissible(
                      background: Container(
                        color: Colors.red[700],
                        padding: const EdgeInsets.only(right: 20.0),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Icon(
                              Icons.delete,
                            )
                          ],
                        ),
                      ),
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
                        leading: const CircleAvatar(
                          //child: Iconprods.getImage(productList[index].name) != '' ? Image.asset(Iconprods.getImage(productList[index].name)) : Text('${productList[index].id}'),
                          //backgroundImage: ExactAssetImage('../../assets/images/burger.png'),
                          //child: Text('${productList[index].id}'),
                          radius: 30.0,
                          backgroundImage: ExactAssetImage('../assets/images/burger.png'),
                          backgroundColor: Colors.transparent,
                        ),
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Prods(prodArgs: productList[index]))).then((_) => setState(() {
                            productListFuture = products();
                          }));
                        },
                      )
                    );
                    
                  },
                );
              }
            }
          },
        ) ,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add_rounded),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const Prods())).then((_) => setState(() {
          productListFuture = products();
        }));
      },),
      
    );
  }
  
}
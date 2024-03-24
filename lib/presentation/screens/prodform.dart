import "package:flutter/material.dart";

import "../../infrastructure/DB/queries/crud.dart";
import "../../infrastructure/models/prods.dart";

class Prods extends StatelessWidget {
  const Prods({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form'),
      ),
      body: Center(
        child: TextButton(
          child: const Text('mybutton'),
          onPressed: () async {
            // Create a Dog and add it to the dogs table
            var fido = Prod(
              id: 0,
              name: 'Fido',
              stock: 35,
            );
            
            await insertProd(fido);
            
            print('crear');
            print(await products());

            if (!context.mounted) return;
            Navigator.of(context).pop();
          },
        ),
      )
    );
  }
  
}
import "package:flutter/material.dart";
import "../../infrastructure/DB/queries/crud.dart";
import "../../infrastructure/models/prods.dart";

class Prods extends StatefulWidget {

  final Prod? prodArgs;

  const Prods({super.key, this.prodArgs});

  @override
  State<Prods> createState() => _ProdsState();
}

class _ProdsState extends State<Prods> {

  //validator form
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _idController;
  late TextEditingController _nameController;
  late TextEditingController _stockController;
  
  //value forms
  String? name;
  late int stock;
  late int id;

  @override
  void initState() {
    super.initState();

    // Inicializar controladores con valores proporcionados si existen
    _idController = TextEditingController(text: widget.prodArgs?.id.toString() ?? '');
    _nameController = TextEditingController(text: widget.prodArgs?.name ?? '');
    _stockController = TextEditingController(text: widget.prodArgs?.stock.toString() ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form'),
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                controller: _idController,
                enabled: widget.prodArgs?.id == null, // Deshabilitar si el ID se proporciona
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  icon: Icon(Icons.numbers),
                  hintText: 'i.e. 10',
                  labelText: 'ID *',
                ),
                onSaved: (String? value) {
                  id = int.parse(value!);
                },
              ),
              TextFormField(
                controller: _nameController,
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  icon: Icon(Icons.shopping_bag_outlined),
                  hintText: 'i.e. burger',
                  labelText: 'Name *',
                ),
                onSaved: (String? value) {
                  name = value;
                },
              ),
              TextFormField(
                controller: _stockController,
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  icon: Icon(Icons.warehouse),
                  hintText: 'i.e. 10',
                  labelText: 'Stock *',
                ),
                onSaved: (String? value) {
                  stock = int.parse(value!);
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: widget.prodArgs?.id != null ?  
                ElevatedButton(
                  onPressed: () async {
                    // Validate returns true if the form is valid, or false otherwise.
                    if (_formKey.currentState!.validate()) {

                      _formKey.currentState!.save(); //save

                      // Create a Dog and add it to the dogs table
                      var fido = Prod(
                        id: id,
                        name: name.toString(),
                        stock: stock,
                      );
                      
                      await updateProd(fido);

                      if (!context.mounted) return;
                      Navigator.of(context).pop();
                    }
                  },
                  child: const Text('Update'),
                ) : // Deshabilitar si el ID se proporciona
                ElevatedButton(
                  onPressed: () async {
                    // Validate returns true if the form is valid, or false otherwise.
                    if (_formKey.currentState!.validate()) {

                      _formKey.currentState!.save(); //save

                      // Create a Dog and add it to the dogs table
                      var fido = Prod(
                        id: id,
                        name: name.toString(),
                        stock: stock,
                      );
                      
                      await insertProd(fido);

                      if (!context.mounted) return;
                      Navigator.of(context).pop();
                    }
                  },
                  child: const Text('Create'),
                ),
              ),
            ],
          ),
        )
      )
    );
  }
}
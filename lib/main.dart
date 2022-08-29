import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightContoller = TextEditingController();
  TextEditingController heightContoller = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText ='Informe seus dados';

  void _resetFields(){
    weightContoller.text = '';
    heightContoller.text = '';
   setState(() {
     _infoText = 'Informe seus dados';
     _formKey = GlobalKey<FormState>();
   });

  }

  void _calculate(){
    setState(() {
      double weight = double.parse(weightContoller.text);
      double height = double.parse(heightContoller.text) /100;
      double imc = weight / (height * height);
      print(imc);
      if(imc < 18.6){
        _infoText = 'Abaixo do peso (${imc.toStringAsPrecision(4)})';
      } else if(imc >= 18.6 && imc <24.9){
        _infoText = 'Peso Ideal (${imc.toStringAsPrecision(4)})';
      } else if(imc >= 24.9 && imc <29.9){
        _infoText = 'Levemente Acima do Peso (${imc.toStringAsPrecision(4)})';
      } else if(imc >= 29.9 && imc <34.9){
        _infoText = 'Obesidade Grau I (${imc.toStringAsPrecision(4)})';
      } else if(imc >= 34.9 && imc <39.9){
        _infoText = 'Obesidade Grau II (${imc.toStringAsPrecision(4)})';
      } else if(imc >= 40){
        _infoText = 'Obesidade Grau III (${imc.toStringAsPrecision(4)})';
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora de IMC'),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: [IconButton
          (onPressed: (_resetFields)
            , icon: Icon(Icons.refresh))],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Form(key: _formKey,
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Icon(Icons.person_outlined, size: 120, color: Colors.green),
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  labelText: 'Peso (Kg)',
                  labelStyle: TextStyle(color: Colors.green)),
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.green, fontSize: 25),
              controller: weightContoller,
              validator: (value) {
                if(value!.isEmpty) {
                  return 'Insira seu Peso!!!';
                }
              },
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  labelText: 'Altura (Cm)',
                  labelStyle: TextStyle(color: Colors.green)),
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.green, fontSize: 25),
              controller: heightContoller,
              validator:  (value) {
                if(value!.isEmpty) {
                  return 'Insira sua altura!!!';
                }
              },

            ),
            Padding(
              padding: EdgeInsets.only(top: 10, bottom: 10),
              child: Container(
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    if(_formKey.currentState!.validate()) {
                      _calculate();
                    }
                  },
                  child: Text(
                    'Calcular',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                  style: ElevatedButton.styleFrom(primary: Colors.green),
                ),
              ),
            ),
            Text(
              _infoText,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.green, fontSize: 25),
            )
          ],
        ),)
      ),
    );
  }
}

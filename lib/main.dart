import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: new Calculator(),
    );
  }
}

class CalculatorLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mainState = MainState.of(context);
    return new Scaffold(
      appBar: new AppBar(
          title: new Text("Calculator")
      ),
      body: new Column(
        children: <Widget>[
          new Expanded(
              child: new Container(
                padding: new EdgeInsets.all(16.0),
                color: Colors.blueGrey.withOpacity(0.85),
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    new Text(
                      mainState.inputValue ?? '0',
                      style: new TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w700,
                        fontSize: 48.0,

                      ),
                    )
                  ],

                ),
              )
          ),
          new Expanded(
            flex: 4,
            child: new Container(
              child: new Column(
                children: <Widget>[
                  makeBtns('C<%/'),
                  makeBtns('789x'),
                  makeBtns('456-'),
                  makeBtns('123+'),
                  makeBtns('_0.='),
                ],
              ),
            ),
          ),
        ],
      ),

    );
  }

  Widget makeBtns(String row){
    List<String> token = row.split("");
    return new Expanded(
      flex:1,
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: token
            .map((e) => new CalcButton(
          keyvalue: e == '_' ? "+/-" : e == '<' ? '⌫' : e,
        )).toList(),
      ),
    );

  }
}

class Calculator extends StatefulWidget{
  @override
  CalcState createState() => new CalcState();

}

class CalcState extends State<Calculator>{
  String inputString = "";
  double prevValue;
  String value = "";
  String op = "z";

  bool isNumber(String str){
    if(str == null){
      return false;
    }
    return double.parse(str, (e)=>null) != null;
  }

  void onPressed(keyvalue){
    switch(keyvalue){
      case "C":
        op = null;
        prevValue = 0.0;
        value = "";
        setState(() => inputString = "");
        break;
      case ".":
      case "%":
      case "⌫":
      case "+/-":
        break;
      case "x":
      case "+":
      case "-":
      case "/":

        op = keyvalue;
        value = '';
        prevValue = double.parse(inputString);
        setState(() {
          inputString = inputString + keyvalue;
        });
        break;
      case "=":
        if(op!= null){
          setState(() {
            switch (op){
              case "+":
                inputString =
                    (prevValue + double.parse(value)).toStringAsFixed(0);
                break;
              case "-":
                inputString =
                    (prevValue - double.parse(value)).toStringAsFixed(0);
                break;
              case "x":
                inputString =
                    (prevValue * double.parse(value)).toStringAsFixed(0);
                break;
              case "/":
                inputString =
                    (prevValue / double.parse(value)).toStringAsFixed(2);
                break;
            }
          });
          op = null;
          prevValue = double.parse(inputString);
          value = '';
          break;
        }
        break;
      default:
        if(isNumber(keyvalue)){
          if(op != null){
            setState(() => inputString = inputString + keyvalue);
            value = value + keyvalue;
          } else {
            setState(() => inputString = ""+ keyvalue);
            op = 'z';
          }
        }else{
          onPressed(keyvalue);
        }
    }
  }

  @override
  Widget build(BuildContext context){
    return new MainState(
      inputValue: inputString,
      prevValue: prevValue,
      value: value,
      op: op,
      onPressed: onPressed,
      child: new CalculatorLayout(),

    );
  }

}

class MainState extends InheritedWidget{
  MainState({
    Key key,
    this.inputValue,
    this.prevValue,
    this.value,
    this.op,
    this.onPressed,
    Widget child,
  }) : super(key: key, child: child);

  final String inputValue;
  final double prevValue;
  final String value;
  final String op;
  final Function onPressed;

  static MainState of(BuildContext context){
    return context.inheritFromWidgetOfExactType(MainState);
  }

  @override
  bool updateShouldNotify(MainState oldWidget){
    return inputValue != oldWidget.inputValue;
  }
}







class CalcButton extends StatelessWidget{
  CalcButton({this.keyvalue});

  final String keyvalue;

  @override
  Widget build(BuildContext context){
    final mainState = MainState.of(context);
    return new Expanded(
      flex: 1,
      child: new FlatButton(
        shape: new Border.all(
          color: Colors.grey.withOpacity(0.5),
          width: 2.0,
          style: BorderStyle.solid,
        ),
        color: Colors.white,
        child: new Text(
          keyvalue,
          style: new TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 36.0,
            color: Colors.black54,
            fontStyle: FontStyle.normal,
          ),
        ),
        onPressed: () {
           mainState.onPressed(keyvalue);
        },
      ),
    );
  }

}
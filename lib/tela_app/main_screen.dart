import 'package:flutter/material.dart';
import 'package:draw_graph/draw_graph.dart';
import 'package:draw_graph/models/feature.dart';
import 'package:intl/intl.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final glicoseController = TextEditingController();
  final formKeyG = GlobalKey<FormState>();

  List<double> glicoseValue = [0.0];
  List<String> timeValue = ["00:00"];

  final List<Feature> features = [
    Feature(
      data: [],
    ),
  ];

  @override
  void initState() {
    setState(() {
      features.add(Feature(
        data: glicoseValue,
      ));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gozina"),
      ),
      body: Container(
        child: PageView(
          children: <Widget>[
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                    child: Column(
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value?.isEmpty ?? true)
                          return 'Este campo precisa ser preenchido!';
                      },
                      controller: glicoseController,
                      decoration: InputDecoration(hintText: "Insira a glicose"),
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        setState(() {
                          String formattedTime =
                              DateFormat.Hm().format((DateTime.now()));
                          double threeRule;
                          threeRule =
                              (int.parse(glicoseController.text) * 0.0025);
                          glicoseValue.add(threeRule);
                          features.clear();
                          features.add(Feature(
                            data: glicoseValue,
                          ));
                          timeValue.add(formattedTime);
                        });
                      },
                      icon: Icon(
                        Icons.add,
                      ),
                      label: Text("Adicionar"),
                    ),
                    LineGraph(
                      features: features,
                      size: Size(420, 450),
                      labelX: timeValue,
                      labelY: [
                        '80mg/dL',
                        '160mg/dL',
                        '240mg/dL',
                        '320mg/dL',
                        '400mg/dL'
                      ],
                      graphColor: Colors.black87,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                )),
              ),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class FeeContainer extends StatelessWidget {
  var color_color;
  var gas_fee_var;
  var type;
  FeeContainer({Key? key, this.color_color,this.gas_fee_var,this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color : Colors.black,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          boxShadow:const [
            BoxShadow(
              color: Colors.white,
              blurRadius: 4,
              offset: Offset(1, 2), // Shadow position
            ),
          ],
        ),
        width: 100,
        height: 100,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
          child: Column(
            children: [
              Row(
                children: [
                  if(int.parse(gas_fee_var) <= 80)...[
                    const Padding(
                      padding: EdgeInsets.fromLTRB(7,0,0,0),
                      child: Text("😀"),
                    ),
                  ] else if(int.parse(gas_fee_var) > 80 && int.parse(gas_fee_var) <= 150) ...[
                    const Padding(
                      padding: EdgeInsets.fromLTRB(7,0,0,0),
                      child: Text("😃"),
                    ),
                  ] else if(int.parse(gas_fee_var) > 150 && int.parse(gas_fee_var) <= 500) ...[
                    const Padding(
                      padding: EdgeInsets.fromLTRB(7,0,0,0),
                      child: Text("😃"),
                    ),
                  ],
                  Padding(
                    padding: const EdgeInsets.fromLTRB(3,0,0,0),
                    child: Text(type),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0,3,0,3),
                child: Text(gas_fee_var + ' gwei', style: TextStyle(
                  fontFamily: 'Helvetica Neue',
                    color: color_color,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


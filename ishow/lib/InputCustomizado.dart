import 'package:flutter/material.dart';
class InputCustomizado extends StatelessWidget {
  final String hint;
  final bool obscure;
  final Icon icon;
  InputCustomizado(
      {@required this.hint, this.obscure=false, this.icon = const Icon(Icons.person)}
      );
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(0),
      child: TextField(
        obscureText: this.obscure,
        decoration: InputDecoration(
            icon: this.icon,
            border: InputBorder.none,
            hintText: this.hint,
            hintStyle: TextStyle(
                color: Colors.grey[600],
                fontSize: 18
            ),
          focusColor:  Color.fromRGBO(255, 100, 127, 1),
          hoverColor:  Color.fromRGBO(255, 100, 127, 1),
          fillColor:  Color.fromRGBO(255, 100, 127, 1),
        ),
      ),
    );
  }
}

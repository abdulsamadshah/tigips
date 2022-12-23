import 'package:flutter/material.dart';

//i did created this round button because round use all place like login and signup its all places reuse the button
class Roundbtn extends StatelessWidget {
  final String title;
  final VoidCallback ontap;
  final bool loading;

  const Roundbtn(
      {Key? key,
      required this.title,
      required this.ontap,
      this.loading = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          // color: Colors.indigo,
          color: Color(0XFF7a19ab),
          // color: Colors.deepPurple,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
            child: loading
                ? CircularProgressIndicator(strokeWidth: 3,color: Colors.pink)
                : Text(
                    title,
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  )),
      ),
    );
  }
}

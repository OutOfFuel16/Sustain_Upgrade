import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyButton extends StatelessWidget {
  final Function()? onTap;
  final String strValue;
  final String? imagePath;
  final Color imageColor;
  final Color? startColor;
  final Color? endColor;

  const MyButton({super.key, required this.onTap, required this.strValue, this.imagePath,this.imageColor=Colors.white,this.startColor=Colors.black,  this.endColor = Colors.black});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: MediaQuery.of(context).size.height*0.095,
        width: MediaQuery.of(context).size.width*0.7,
        padding: const EdgeInsets.all(25),
        margin: const EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            //color: Colors.blueGrey[800],
            gradient: LinearGradient(begin:Alignment.topCenter,end:Alignment.bottomCenter,colors: [startColor!,endColor!])
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: Text(
                  strValue,
                  style: GoogleFonts.mulish(textStyle:const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ))
              ),
            ),
            const SizedBox(width: 8,),
            if(imagePath!=null) Image.asset(imagePath!,height:45,width: 45,color:imageColor ,),


          ],
        ),
      ),
    );
  }
}
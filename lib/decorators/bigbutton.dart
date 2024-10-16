import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class MyBigButton extends StatelessWidget {
  final Function()? onTap;
  final String strValue;
  final String? imagePath;
  final Color? startColor;
  final Color? endColor;
  final String? animationPath;

  const MyBigButton({super.key, required this.onTap, required this.strValue,this.imagePath, required this.startColor, required this.endColor, this.animationPath});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 110,

        padding: const EdgeInsets.all(25),
        margin: const EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          //color: Colors.blueGrey[800],
         gradient: LinearGradient(begin:Alignment.topLeft,end:Alignment.bottomRight,colors: [startColor!,endColor!])
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
            const SizedBox(width: 20,),
            if(imagePath!=null)Image.asset(imagePath!,height: 65,width: 65,color: Colors.white),
            if(animationPath!=null)Lottie.asset(animationPath!)


          ],
        ),
      ),
    );
  }
}
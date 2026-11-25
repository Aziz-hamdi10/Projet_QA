import 'package:bridgewearaa/Webpart/constaints.dart';
import 'package:bridgewearaa/screens/loading.dart';
import 'package:flutter/material.dart';

class inputsignin extends StatefulWidget {
  final TextEditingController input;
  final String label;
  final String texthover;
  final String fontfm;

  final bool pass;


  const inputsignin({super.key,required this.fontfm,required this.input,required this.label,required this.texthover,required this.pass});

  @override
  State<inputsignin> createState() => _inputsigninState();
}

class _inputsigninState extends State<inputsignin> {


  @override
  Widget build(BuildContext context) {

    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double screenWidth = mediaQueryData.size.width;
    double screenHeight = mediaQueryData.size.height;
    double fontSize = MediaQuery.of(context).size.shortestSide * 0.05;
    double marginValue = MediaQuery.of(context).size.width * 0.02;
    return             Padding(
      padding:  EdgeInsets.all(marginValue),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10,20, 10,20),
            child: Text(
              this.widget.label,
              style: TextStyle(
                fontSize: fontSize,
                fontFamily: "LALEZAR",
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
    Container(
    height: screenHeight*0.07,
      child :TextField(
        obscureText: this.widget.pass,
      controller: this.widget.input,
      decoration: InputDecoration(
        alignLabelWithHint: true,
      label: Text(this.widget.texthover),
        contentPadding: EdgeInsets.symmetric(vertical: screenHeight*0.03,horizontal: 10), // Adjust padding here

        border: OutlineInputBorder(

      ),
labelStyle: TextStyle(fontSize: fontSize,fontFamily:this.widget.fontfm),
      ),
      ),
    ),
        ],
      ),
    );//label

  }
}

class inputlogin extends StatefulWidget {

  final TextEditingController input;
  final String label;
  final bool pass;
  final IconData? icon;
  final Color cl;
  final Function? change;
  final Function? verif;
  final String errmsg;

  const inputlogin({required this.errmsg,this.verif,required this.change,required this.cl,required this.icon,super.key,required this.input,required this.label,required this.pass});


  @override
State<inputlogin> createState() => _inputloginState();
}

class _inputloginState extends State<inputlogin> {
  
bool error=false;
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double screenWidth = mediaQueryData.size.width;
    double screenHeight = mediaQueryData.size.height;
    double fontSize = MediaQuery.of(context).size.shortestSide * 0.05;
    double marginValue = MediaQuery.of(context).size.width * 0.02;
    return   Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        onChanged: (value) {
          if(this.widget.verif!=null)
          setState(() {
            error=!this.widget.verif!(value);

          });
        },
          controller: this.widget.input,
          textAlign: TextAlign.left,
          style:  TextStyle(
            color: widget.cl,
            fontSize: fontSize*0.8,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w400,
          ),
        obscureText: this.widget.pass,

        decoration:  InputDecoration(
          suffixIcon:this.widget.change != null? IconButton(
            icon: Icon(widget.pass?Icons.visibility_off:Icons.remove_red_eye_rounded, color:error?Colors.red: widget.cl
              ,),
            onPressed: () {
            widget.change!();
            },
          ):null,

            labelText: this.widget.label,

          prefixIcon: Icon(this.widget.icon, color:error?Colors.red: widget.cl,),

          labelStyle: TextStyle(
              color: widget.cl,
              fontSize: fontSize*0.8,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
            ),
            enabledBorder:  OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(
                width: 1,
                color:widget.cl,
              ),
            ),


            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(
                width: 1,
                color:Colors.red,

              ),

            ),
          errorText: error ? this.widget.errmsg : null,

          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(
                width: 1,
                color:widget.cl,
              ),
            ),
          ),

      ),
    );
  }
}

class inputsignup extends StatefulWidget {
  final TextEditingController input;
  final String label;


  final bool pass;
  final Color cl;
  final Function verif;
  final Function errmsg;
  final String errmsg2;

  const inputsignup({required this.errmsg2,required this.errmsg, required this.verif,required this.cl,super.key,required this.input,required this.label,required this.pass});

  @override
  State<inputsignup> createState() => _inputsignupState();
}

class _inputsignupState extends State<inputsignup> {
  void updateVerification(String value) async {
    bool result = await this.widget.verif(value);
    setState(() {
      v = result;
    });
  }
  bool validateInput() {
    
    return this.widget.input.text.isEmpty;
  }
  bool v=true;

  @override
  Widget build(BuildContext context) {
  MediaQueryData mediaQueryData = MediaQuery.of(context);
    double screenWidth = mediaQueryData.size.width;
    double screenHeight = mediaQueryData.size.height;
    double fontSize = MediaQuery.of(context).size.shortestSide * 0.05;
    double marginValue = MediaQuery.of(context).size.width * 0.02;
  if(screenWidth>screenHeight){
           screenWidth = mediaQueryData.size.height;
       screenHeight = mediaQueryData.size.width;
      }
        final Size _size = MediaQuery.of(context).size;

        final bool _isDesktop = _size.width >= screenLg;

    return              SizedBox(
      child:TextField(
        obscureText: this.widget.pass,
        controller: this.widget.input,
        textAlign: TextAlign.left,
        style: TextStyle(
          color: this.widget.cl,
          fontSize: fontSize * 0.7,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          labelText: this.widget.label,
          labelStyle: TextStyle(
            color: !v ? Colors.red : this.widget.cl,
            fontSize: fontSize * 0.7,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
          ),
               enabledBorder:  OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(
                width: 1,
                color:widget.cl,
              ),
            ),


            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(
                width: 1,
                color:Colors.red,

              ),

            ),
             focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(
                width: 1,
                color:widget.cl,
              ),
            ),
          errorText: this.widget.errmsg(widget.input.text)!=null&&!v ? this.widget.errmsg(widget.input.text) :v==false?widget.errmsg2: null,
          errorStyle: TextStyle(
            fontSize: fontSize*0.5,
            fontWeight: FontWeight.w600,
          ),
      
        ),

        onChanged: (value) {
          updateVerification(value);
        },
      ),


    );//label

  }
}

import 'package:flutter/material.dart';
import 'package:pon/core/res/colors.dart';
import 'package:pon/core/res/styles.dart';

class EditText extends StatefulWidget {

  TextEditingController controller;
  String hint;
  String errorText;
  TextInputType inputType;
  TextStyle textStyle;
  FocusNode focusNode = new FocusNode();
  EdgeInsets marginEdgeInsets;
  TextCapitalization textCapitalization;

  Key key;

  bool validate = false;
  bool autoFocus = false;
  bool isPasswordField = false;
  bool removeDecoration = false;
  int maxLength = 1000;
  int maxLines;
  bool enabled =true;
  Widget prefix;

  TextAlign textAlign;

  ValueChanged<String> onSubmitted = (terms) {};
  ValueChanged<String> onChanged = (terms) {};

  EditText(
      this.hint,
      this.key,
      this.controller,
      this.inputType,
     {this.marginEdgeInsets,
       this.focusNode,
       this.onSubmitted,
       this.onChanged,
       this.maxLength,
       this.textCapitalization,
       this.autoFocus = false,
       this.errorText,
       this.enabled,
       this.maxLines,
       this.textStyle,
       this.textAlign,
       this.prefix,
       this.validate});

  EditText.password(
      this.hint,
      this.key,
      this.controller,
      this.inputType,
      {this.marginEdgeInsets,
        this.focusNode,
        this.onSubmitted,
        this.maxLength,
        this.autoFocus = false,
        this.onChanged,
        this.textCapitalization,
        this.errorText,
        this.validate,
        this.maxLines = 1}){
    isPasswordField = true;
  }

  EditText.noDecoration(
      this.hint,
      this.key,
      this.controller,
      this.inputType,
      {this.marginEdgeInsets,
        this.focusNode,
        this.onSubmitted,
        this.maxLength,
        this.onChanged,
        this.textCapitalization,
        this.errorText,
        this.textAlign,
        this.autoFocus = false,
        this.textStyle,
        this.validate}){
    removeDecoration = true;
  }

  @override
  _EditTextState createState() => _EditTextState();
}

class _EditTextState extends State<EditText> {
  VoidCallback onPressed;

  String text;

  bool isVisible = false;

  setFormSubmitted(ValueChanged<String> formSubmitted){
    this.widget.onSubmitted = formSubmitted;
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
        margin: widget.marginEdgeInsets == null ? EdgeInsets.all(0) : widget.marginEdgeInsets,
        child: new Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              new TextFormField(
                key: widget.key,
                controller: widget.controller,
                obscureText: widget.isPasswordField && !isVisible ? true : false,
                textInputAction: TextInputAction.next,
                style: widget.textStyle == null ? TextStyle(
                  color: AppColor.text,
                  fontSize: 17,
                ) : widget.textStyle,
                maxLines: widget.maxLines,
                focusNode: widget.focusNode,
                onFieldSubmitted: widget.onSubmitted,
                onChanged: widget.onChanged,
                maxLength: widget.maxLength,
                enabled: widget.enabled,
                autofocus: widget.autoFocus,
                textAlign: widget.textAlign == null ? TextAlign.left : widget.textAlign,
                decoration: new InputDecoration(labelText: !widget.removeDecoration ? widget.hint : null,
                  counterText: widget.maxLength == null ? null : " ",
                  hintStyle: widget.textStyle == null ? new TextStyle(color: AppColor.secondaryText, fontSize: 15) : widget.textStyle.copyWith(color: AppColor.secondaryText),
                  hintText: widget.removeDecoration ? widget.hint : null,
                  errorText: widget.validate ? widget.errorText == null ? "Required" : widget.errorText : null,
                  labelStyle: new TextStyle(color: AppColor.secondaryText, fontSize: 15),
                  border:  UnderlineInputBorder(
                    borderSide: BorderSide(color: widget.removeDecoration ? Colors.transparent : Colors.black12),
                  ),
                  enabledBorder:  UnderlineInputBorder(
                    borderSide: BorderSide(color: widget.removeDecoration ? Colors.transparent : Colors.black12),
                  ),
                  disabledBorder:  UnderlineInputBorder(
                    borderSide: BorderSide(color: widget.removeDecoration ? Colors.transparent : Colors.black12),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: widget.removeDecoration ? Colors.transparent : Theme.of(context).secondaryHeaderColor),
                  ),

                  prefix: widget.prefix,
                  suffix: widget.isPasswordField ? GestureDetector(child: Icon(isVisible ? Icons.visibility : Icons.visibility_off),
                        onTap: (){
                          setState(() {
                            isVisible = !isVisible;
                          });
                        },) : null,

                ),
                keyboardType: widget.inputType,
                textCapitalization: widget.textCapitalization == null ? TextCapitalization.words : widget.textCapitalization,
              ),
            ]
        ),
    );
  }
}
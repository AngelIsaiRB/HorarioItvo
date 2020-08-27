
import 'package:flutter/material.dart';

String coloToString(Color color){

 if(color==Colors.red){
   return "red";
 }
 else if(color==Colors.blue){
   return "blue";
 }
 if(color==Colors.yellow){
   return "yellow";
 }
 else if(color==Colors.black){
   return "black";
 }
 if(color==Colors.brown){
   return "brown";
 }
 else if(color==Colors.purple){
   return "purple";
 }
 if(color==Colors.orange){
   return "orange";
 }
 else if(color==Colors.green){
   return "green";
 }
 else if(color==Colors.indigo){
   return "indigo";
 }
 else if(color==Colors.white){
   return "white";
 }
 if(color==Colors.blueGrey){
   return "blueGrey";
 }
 return "blue";
  
}

Color stringToColor(String color){

 if(color=="red"){
   return Colors.red;
 }
 else if(color=="blue"){
   return Colors.blue;
 }
 if(color=="yellow"){
   return Colors.yellow;
 }
 else if(color=="black"){
   return Colors.black;
 }
 if(color=="brown"){
   return Colors.brown;
 }
 else if(color=="purple"){
   return Colors.purple;
 }
 if(color=="orange"){
   return Colors.orange;
 }
 else if(color=="green"){
   return Colors.green;
 }
 else if(color=="indigo"){
   return Colors.indigo;
 }
  else if(color=="white"){
   return Colors.white;
 }
  if(color=="blueGrey"){
   return Colors.blueGrey;
 }
 return Colors.blue;
  
}
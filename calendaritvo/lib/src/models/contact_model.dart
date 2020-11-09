import 'package:flutter/material.dart';

class ContactModel{

  final String nombre;
  final String link;
  final IconData icon;
  final bool isLink;

  ContactModel({
    this.nombre, 
    this.link, 
    this.icon,
    this.isLink
  });

}
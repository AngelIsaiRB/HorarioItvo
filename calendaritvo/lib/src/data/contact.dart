import 'package:flutter/material.dart';
import 'package:calendaritvo/src/models/contact_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';




final List<ContactModel> contactos = <ContactModel>[

  ContactModel(
    nombre:"Facebook",
    link:"https://www.facebook.com/itvalleoaxaca", 
    icon: FontAwesomeIcons.facebook,
    isLink: true
    ),
  ContactModel(
    nombre:"Pagina Web",
    link:"https://www.voaxaca.tecnm.mx", 
    icon: FontAwesomeIcons.internetExplorer,
    isLink: true
    ),
  ContactModel(
    nombre:"Telefono 1",
    link:"tel:9515170444", 
    icon: FontAwesomeIcons.phone,
    isLink: true
    ),
  ContactModel(
    nombre:"Telefono 2",
    link:"tel:9515170788", 
    icon: FontAwesomeIcons.phone,
    isLink: true
    ),
    ContactModel(
    nombre:"Email",
    link:"mailto:itvalleoaxaca@hotmail.com", 
    icon: FontAwesomeIcons.envelope,
    isLink: true
    ),


];



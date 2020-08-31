
import 'dart:convert';

Noticia noticiaFromJson(String str) => Noticia.fromJson(json.decode(str));

String noticiaToJson(Noticia data) => json.encode(data.toJson());

class Noticia {
    Noticia({
        this.id,
        this.imagen,
        this.importancia,
        this.link,
        this.texto,
    });

    String id;
    String imagen;
    int importancia;
    String link;
    String texto;

    factory Noticia.fromJson(Map<String, dynamic> json) => Noticia(
        id: json["id"],
        imagen: json["imagen"],
        importancia: json["importancia"],
        link: json["link"],
        texto: json["texto"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "imagen": imagen,
        "importancia": importancia,
        "link": link,
        "texto": texto,
    };
}

class Translate {
  int id;

  final String cyrillic; // cyrillic
  final String latin;

  Translate({
    this.cyrillic,
    this.latin,
    this.id,
  });


  factory Translate.fromMap(Map<String, dynamic> map) => Translate(
    cyrillic: map['cyrillicValue'],
    latin: map['latinValue'],

  );
   // Translate.fromMap(Map<String, dynamic> map) :
   //  this.cyrillic = map['cyrillicValue'],
   //  this.latin = map['latinValue'],);

  Map<String, dynamic> toMap() {
    return {
      'cyrillicValue' : cyrillic,
      'latinValue' : latin,
    };
  }
}
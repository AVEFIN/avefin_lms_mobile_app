class Person {
  final String id;
  final String? email;
  final String phone;
  final String name;
  final String? lastName;
  final String? secondLastName;
  final String rfc;
  final String streetNumber;
  final String? interiorNumber;
  final int? entity;
  final String? city;
  final String municipality;
  final int? cnbvLocalidad;
  final String neighborhood;
  final String? clabe;
  final String? curp;
  final String streetName;
  final String zipCode;
  final String? personaType; // "1" | "2"
  final String? personaTypeDisplay; // read-only
  final String? dateOfBirth;
  final int? nationality;
  final int? countryOfResidence;
  final String sectorOcupation;
  final String? countryOfResidenceName; // read-only
  final String? entityName; // read-only
  final String? nationalityName; // read-only

  const Person({
    required this.id,
    this.email,
    required this.phone,
    required this.name,
    this.lastName,
    this.secondLastName,
    required this.rfc,
    required this.streetNumber,
    this.interiorNumber,
    this.entity,
    this.city,
    required this.municipality,
    this.cnbvLocalidad,
    required this.neighborhood,
    this.clabe,
    this.curp,
    required this.streetName,
    required this.zipCode,
    this.personaType,
    this.personaTypeDisplay,
    this.dateOfBirth,
    this.nationality,
    this.countryOfResidence,
    required this.sectorOcupation,
    this.countryOfResidenceName,
    this.entityName,
    this.nationalityName,
  });

  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(
      id: json['id'] as String,
      email: json['email'] as String?,
      phone: json['phone'] as String,
      name: json['name'] as String,
      lastName: json['lastName'] as String?,
      secondLastName: json['secondLastName'] as String?,
      rfc: json['rfc'] as String,
      streetNumber: json['streetNumber'] as String,
      interiorNumber: json['interiorNumber'] as String?,
      entity: json['entity'] as int?,
      city: json['city'] as String?,
      municipality: json['municipality'] as String,
      cnbvLocalidad: json['cnbvLocalidad'] as int?,
      neighborhood: json['neighborhood'] as String,
      clabe: json['clabe'] as String?,
      curp: json['curp'] as String?,
      streetName: json['streetName'] as String,
      zipCode: json['zipCode'] as String,
      personaType: json['personaType'] as String?,
      personaTypeDisplay: json['personaTypeDisplay'] as String?,
      dateOfBirth: json['dateOfBirth'] as String?,
      nationality: json['nationality'] as int?,
      countryOfResidence: json['countryOfResidence'] as int?,
      sectorOcupation: json['sectorOcupation'] as String,
      countryOfResidenceName: json['countryOfResidenceName'] as String?,
      entityName: json['entityName'] as String?,
      nationalityName: json['nationalityName'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'phone': phone,
      'name': name,
      'lastName': lastName,
      'secondLastName': secondLastName,
      'rfc': rfc,
      'streetNumber': streetNumber,
      'interiorNumber': interiorNumber,
      'entity': entity,
      'city': city,
      'municipality': municipality,
      'cnbvLocalidad': cnbvLocalidad,
      'neighborhood': neighborhood,
      'clabe': clabe,
      'curp': curp,
      'streetName': streetName,
      'zipCode': zipCode,
      'personaType': personaType,
      'personaTypeDisplay': personaTypeDisplay,
      'dateOfBirth': dateOfBirth,
      'nationality': nationality,
      'countryOfResidence': countryOfResidence,
      'sectorOcupation': sectorOcupation,
      'countryOfResidenceName': countryOfResidenceName,
      'entityName': entityName,
      'nationalityName': nationalityName,
    };
  }
}

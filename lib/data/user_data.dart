class UserData {
  final int id;
  final String nombre;
  final String apellido;
  final String? telefono; 
  final String sexo;
  final String email;
  final DateTime fechaNac;
  final String? rutaFoto;
  final int userId;

  UserData({
    required this.id,
    required this.nombre,
    required this.apellido,
    this.telefono,
    required this.sexo,
    required this.email,
    required this.fechaNac,
    required this.userId,
    this.rutaFoto,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
        id: json['id'],
        nombre: json['nombre'],
        apellido: json['apellido'],
      telefono: json['telefono']?.toString(),
        sexo: json['sexo'],
        email: json['email'],
        fechaNac: DateTime.parse(json['fecha_nac']),
        rutaFoto: json['ruta_foto'],
        userId: json['user_id']);
  }

  get data => null;
}

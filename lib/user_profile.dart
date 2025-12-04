class UserProfile {
  final String avatarUrl;
  final String firstName;
  final String lastName;
  final String role;
  final String dateOfBirth;
  final String specialty;
  final List<String> skills;
  final String aboutMe;
  final String position;
  final String organization;

  UserProfile({
    required this.avatarUrl,
    required this.firstName,
    required this.lastName,
    required this.role,
    required this.dateOfBirth,
    required this.specialty,
    required this.skills,
    required this.aboutMe,
    required this.position,
    required this.organization,
  });

  factory UserProfile.fromMap(Map<String, dynamic> data) {
    return UserProfile(
      avatarUrl: data['avatarUrl'] ?? '',
      firstName: data['firstName'] ?? '',
      lastName: data['lastName'] ?? '',
      role: data['role'] ?? '',
      dateOfBirth: data['dateOfBirth'] ?? '',
      specialty: data['specialty'] ?? '',
      skills: List<String>.from(data['skills'] ?? []),
      aboutMe: data['aboutMe'] ?? '',
      position: data['position'] ?? '',
      organization: data['organization'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'avatarUrl': avatarUrl,
      'firstName': firstName,
      'lastName': lastName,
      'role': role,
      'dateOfBirth': dateOfBirth,
      'specialty': specialty,
      'skills': skills,
      'aboutMe': aboutMe,
      'position': position,
      'organization': organization,
    };
  }
}

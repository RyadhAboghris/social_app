// ignore_for_file: public_member_api_docs, sort_constructors_first
class SocialUserModel {
  String name, email, phone, image, cover, bio, uId;
  bool isEmailVerfied;
  SocialUserModel({
    this.name,
    this.email,
    this.phone,
    this.uId,
    this.image,
    this.cover,
    this.bio,
    this.isEmailVerfied,
  });

  SocialUserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    uId = json['uId'];
    image = json['image'];
    cover = json['cover'];
    bio = json['bio'];
    isEmailVerfied = json['isEmailVergied'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'uId': uId,
      'image': image,
      'cover': cover,
      'bio': bio,
      'isEmailVergied': isEmailVerfied,
    };
  }
}

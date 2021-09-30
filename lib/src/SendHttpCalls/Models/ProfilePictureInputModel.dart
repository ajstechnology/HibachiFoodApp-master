class ProfilePictureInputModel {
  String avatar;
  String contentType = "image/png";
  String file = "base64string";
  ProfilePictureInputModel(this.avatar);
  ProfilePictureInputModel.fromJson(Map<String, dynamic> json) {
    avatar = json['avatar'];
    contentType = json['content_type'];
    file = json['file'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['avatar'] = this.avatar;
    data['content_type'] = this.contentType;
    data['file'] = this.file;
    return data;
  }
}

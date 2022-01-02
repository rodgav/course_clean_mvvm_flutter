class SliderObject {
  String title;
  String subTitle;
  String image;

  SliderObject(this.title, this.subTitle, this.image);
}

class Customer {
  String id;
  String name;
  int numOfNotifications;

  Customer(
      {required this.id, required this.name, required this.numOfNotifications});
}

class Contacts {
  String email;
  String phone;
  String link;

  Contacts({required this.email, required this.phone, required this.link});
}

class Authentication {
  int status;
  String message;
  Customer customer;
  Contacts contacts;

  Authentication(
      {required this.status,
      required this.message,
      required this.customer,
      required this.contacts});
}

class DeviceInfo {
  String name;
  String identifier;
  String version;

  DeviceInfo(this.name, this.identifier, this.version);
}

class ForgotPassword {
  ForgotPassword({
    required this.status,
    required this.message,
    required this.support,
  });

  int status;
  String message;
  String support;
}

class Home {
  Home({
    required this.status,
    required this.message,
    required this.data,
  });

  int status;
  String message;
  Data data;
}

class Data {
  Data({
    required this.services,
    required this.stores,
    required this.banners,
  });

  List<BannerData> services;
  List<BannerData> stores;
  List<BannerData> banners;
}

class BannerData {
  BannerData({
    required this.id,
    required this.title,
    required this.image,
  });

  int id;
  String title;
  String image;
}

class StoreDetails {
  StoreDetails({
    required this.status,
    required this.message,
    required this.image,
    required this.id,
    required this.title,
    required this.details,
    required this.services,
    required this.about,
  });

  int status;
  String message;
  String image;
  int id;
  String title;
  String details;
  String services;
  String about;}

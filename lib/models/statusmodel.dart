class StatusModel {
  final String name;
  final String image;
  final String time;

  StatusModel(this.name, this.image, this.time);
}

List<StatusModel> status = [
  StatusModel("Baddestkid", "assets/img3.jpg", "3 minutes"),
  StatusModel("Jessie", "assets/img1.jpg", "10:53"),
  StatusModel("Greg", "assets/img2.jpg", "9:56"),
  StatusModel("Paul", "assets/img4.jpg", "11:22"),
];

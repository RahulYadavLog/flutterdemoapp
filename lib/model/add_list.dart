class AddDataModel{
  int id;
 String title;
 String url;

 int get getId=> id;
 String get getTitle=>title;
 String get getUrl=>url;

 AddDataModel(this.id,this.title,this.url);

   AddDataModel getById(int id) => AddDataModel(id,title,url);

  /// Get item by its position in the catalog.
  AddDataModel getByPosition(int position) {
    // In this simplified case, an item's position in the catalog
    // is also its id.
    return getById(position);
  }
}
class AppUrl{
  static const String baseUrl = "https://crm.mnsbilisim.com";
  static const String login = ("$baseUrl/api/Login/kullanici-giris");

  static const String addCustomer = ("$baseUrl/api/musteri/musteri-ekle");
  static const String addUser = ("$baseUrl/api/Kullanici/kullanici-ekle");
  static const String addTask = ("$baseUrl/api/gorev/gorev-ekle");
  static const String addAktivity = ("$baseUrl/api/aktivite/aktivite-ekle");
  static const String addOffer = ("$baseUrl/api/teklif/teklif-ekle");
  static const String addProductBasket = ("$baseUrl/api/teklif/teklife-sepet-ekle");
  static const String addScope = ("$baseUrl/api/firsat/firsat-ekle");
  static const String addProduct = ("$baseUrl/api/urun/urun-ekle");
  static const String addCurrency = ("$baseUrl/api/parabirimleri/para-birimi-ekle");
  static const String addCauseRefuse = ("$baseUrl/api/rednedenleri/rednedenleri-ekle");
  static const String addCargo = ("$baseUrl/api/parabirimleri/kargo-ekle");

  static const String customerList = ("$baseUrl/api/musteri/musteriler");
  static const String productList = ("$baseUrl/api/urun/urunler");
  static const String taskList = ("$baseUrl/api/gorev/gorevler");
  static const String aktivityList = ("$baseUrl/api/aktivite/aktiviteler");
  static const String scopeList = ("$baseUrl/api/firsat/firsatlar");
  static const String userList = ("$baseUrl/api/Kullanici/kullanicilar");
  static const String allCategeryList = ("$baseUrl/api/musteri/tüm-kategorileri-getir");
  static const String getTaskNomAndRespList = ("$baseUrl/api/gorev/gorev-atayan-sorumlu");
  static const String allScopeList = ("$baseUrl/api/firsat/Musterileri-Getir-WithPaging");
  static const String currencyList = ("$baseUrl/api/parabirimleri/tum-para-birimleri");
  static const String offerList = ("$baseUrl/api/teklif/teklifler");
  static const String offerproductList = ("$baseUrl/api/teklif/urun-listeleme");
  static const String causeRefus = ("$baseUrl/api/rednedenleri/tum-ret-nedenleri");
  static const String cargoList = ("$baseUrl/api/parabirimleri/tum-kargolar");
  static const String OrderConfirm = ("$baseUrl/api/teklif/onaylanan-siparisler");
  static const String orderRefuse = ("$baseUrl/api/teklif/reddedilen-siparisler");
  static const String getScopeCustomer = ("$baseUrl/api/firsat/müsterileri-getir");
  static const String getmusterWithPaging = ("$baseUrl/api/firsat/Musterileri-Getir-WithPaging");
  static const String allTaskNominationList = ("$baseUrl/api/gorev/gorev-atayan-sorumlu");

  static const String updateCustomer = ("$baseUrl/api/musteri/musteri-guncelle");
  static const String updateProduct = ("$baseUrl/api/urun/urun-guncelle");
  static const String updateUser = ("$baseUrl/api/Kullanici/kullanici-guncelle");
  static const String updateActivity = ("$baseUrl/api/aktivite/aktivite-guncelle");
  static const String updateScope = ("$baseUrl/api/firsat/firsat-guncelle");
  static const String updateTask = ("$baseUrl/api/gorev/gorev-guncelle");
  static const String updateOffer = ("$baseUrl/api/teklif/teklif-guncelle");
  static const String updateCauseRefus = ("$baseUrl/api/rednedenleri/rednedenleri-guncelle");
  static const String updateCurrency = ("$baseUrl/api/parabirimleri/para-birimi-guncelle");
  static const String updateCargo = ("$baseUrl/api/parabirimleri/kargo-guncelle");

  static const String deleteOffer = ("$baseUrl/api/teklif/teklif-sil");
  static const String dashbordInfo = ("$baseUrl/api/Login/dashboard-bilgileri");
  static const String dashbordofferInfo = ("$baseUrl/api/Login/teklif-bilgileri");
  static const String dashbordScopeInfo = ("$baseUrl/api/Login/firsat-bilgileri");
  static const String dashbordAktivityInfo = ("$baseUrl/api/Login/gorusme-bilgileri");
  static const String dashbordTaskInfo = ("$baseUrl/api/Login/gorev-bilgileri");
  static const String dashbordTopTenInfo = ("$baseUrl/api/Login/musteri-top-ten");
  static const String dashbordBirthDayInfo = ("$baseUrl/api/Login/yetkili-dogum-gunleri");

  static const String integra = ("$baseUrl/api/parabirimleri/entegrasyon-calistir");




}
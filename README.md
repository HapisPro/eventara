# 🌸 Eventara — Platform Informasi Event Budaya Indonesia

Eventara adalah aplikasi mobile berbasis **Flutter** dan **Firebase** yang berfungsi sebagai platform terpusat untuk **informasi dan promosi event budaya di Indonesia**.  
Aplikasi ini dikembangkan untuk memudahkan masyarakat menemukan acara budaya, serta memberikan ruang bagi penyelenggara untuk mempublikasikan event mereka secara terverifikasi.

---

## 📖 Latar Belakang

Indonesia dikenal sebagai negara dengan keragaman budaya yang sangat kaya, terdiri dari lebih dari **1.340 suku bangsa** dengan berbagai tradisi, kesenian, dan festival unik.  
Setiap daerah memiliki acara budaya yang menjadi identitas lokal — seperti *Pacu Jalur* di Riau, *Festival Danau Toba* di Sumatera Utara, hingga *Sekaten* di Yogyakarta.

Namun di era digital, informasi mengenai acara budaya masih **tidak terpusat** dan tersebar di berbagai platform seperti media sosial, blog, dan situs pemerintah daerah.  
Akibatnya, masyarakat terutama generasi muda sering kesulitan mendapatkan informasi yang akurat dan terkini.  
Di sisi lain, penyelenggara acara juga menghadapi kendala dalam promosi karena keterbatasan jangkauan platform.

Untuk menjawab tantangan tersebut, **Eventara** hadir sebagai solusi dengan menyediakan **satu platform terpusat** untuk informasi dan promosi event budaya di seluruh Indonesia.

---

## 🎯 Tujuan Penelitian

1. Mempermudah masyarakat menemukan informasi event budaya dalam satu platform.
2. Membantu penyelenggara acara mempromosikan event budaya secara efektif.
3. Menjamin keakuratan informasi melalui sistem **verifikasi admin**.
4. Mengimplementasikan **Flutter** untuk menghasilkan aplikasi lintas platform dengan performa tinggi dan tampilan intuitif.
5. Meningkatkan partisipasi generasi muda dalam pelestarian budaya lokal.

---

## 🧩 Fitur Utama

| Fitur | Deskripsi |
|-------|------------|
| 🗓️ **Daftar Event Budaya** | Menampilkan daftar acara budaya dari berbagai daerah. |
| 🔍 **Pencarian & Filter** | Memudahkan pengguna menemukan event sesuai lokasi atau waktu. |
| 📝 **Tambah Event** | Pengguna dapat mengajukan event budaya untuk dipublikasikan. |
| ✅ **Verifikasi Admin** | Admin meninjau dan menyetujui event sebelum tampil ke publik. |
| 📱 **Notifikasi Event** | Mengingatkan pengguna terhadap event yang akan datang. |
| 🌗 **Dark/Light Mode** | Pilihan tema tampilan sesuai preferensi pengguna. |
| 📅 **Kalender Event** | Menambahkan event ke kalender |

---

## 🏗️ Teknologi & Tools

| Kategori | Tools/Resource | Fungsi |
|-----------|----------------|--------|
| **Bahasa Pemrograman** | Dart | Bahasa utama Flutter, mendukung OOP & async. |
| **Framework** | Flutter | Framework lintas platform untuk Android & iOS. |
| **State Management** | Provider | Mengelola state agar data konsisten di seluruh halaman. |
| **Shared Preferences** |  | Menyimpan pengaturan tema dan preferensi pengguna. |
| **Cloud Backend** | Firebase Auth | Autentikasi berbasis role (User/Admin). |
|  | Cloud Firestore | Menyimpan data event & detail secara real-time. |
|  | Firebase Cloud Messaging | Push notification event terbaru. |
|  | Supabase Storage | Menyimpan gambar hasil upload pengguna. |
| **Package Tambahan** | Table Calendar, Intl, Flutter Local Notifications | Mendukung kalender, format tanggal, dan notifikasi lokal. |

---

## ⚙️ Instalasi & Menjalankan Proyek

### 🔧 Prasyarat
Pastikan kamu telah menginstal:
- [Flutter SDK](https://flutter.dev/docs/get-started/install)
- [Dart SDK](https://dart.dev/get-dart)
- [Firebase CLI](https://firebase.google.com/docs/cli)
- Editor seperti **VS Code** atau **Android Studio**

### 🪜 Langkah-langkah

1. **Clone repository**
   ```bash
   git clone https://github.com/username/eventara.git
   cd eventara
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Hubungkan ke Firebase**
   - Buka [Firebase Console](https://console.firebase.google.com)
   - Tambahkan aplikasi Android & iOS
   - Unduh file `google-services.json` (Android) dan/atau `GoogleService-Info.plist` (iOS)
   - Letakkan file tersebut pada direktori yang sesuai di proyek Flutter

4. **Jalankan aplikasi**
   ```bash
   flutter run
   ```

---


## 🧪 Rencana Pengembangan (Milestone)

| Minggu | Kegiatan |
|--------|-----------|
| 1 | Analisis kebutuhan & perancangan UI/UX |
| 2 | Setup proyek & fitur autentikasi |
| 3 | Pengembangan fitur utama (event list, detail, tambah, verifikasi) |
| 4 | Fitur pendukung (pencarian, filter, notifikasi) |
| 5 | Pengujian, debugging, dan finalisasi |

---

## 👥 Tim Pengembang

| Peran | Tanggung Jawab |
|-------|----------------|
| **UI/UX Designer** | Merancang tampilan yang menarik & intuitif. |
| **Backend Developer** | Mengelola database, autentikasi, dan sistem verifikasi event. |
| **Mobile Developer ** | Membangun fitur utama & integrasi antar komponen aplikasi. |


---

## 📄 Lisensi

Proyek ini dilisensikan di bawah [MIT License](LICENSE).

---

## 🌐 Kontak

📧 Email: [capstoneb25@gmail.com](mailto:capstoneb25@gmail.com)  

---

> “Melestarikan budaya tidak hanya tentang masa lalu, tetapi juga tentang bagaimana kita memperkenalkannya di masa depan.”  
> — *Eventara Team*

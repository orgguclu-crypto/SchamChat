# SchamChat Yerelleştirme Kılavuzu

## Desteklenen Diller

- 🇹🇷 Türkçe (TR)
- 🇸🇦 Arapça (AR)
- 🇩🇪 Almanca (DE)
- 🇬🇧 İngilizce (EN)
- 🇵🇹 Portekizce (PT)

## Çeviri Dosya Yapısı

```
locales/
├── tr/
│   ├── common.json
│   ├── rooms.json
│   ├── moments.json
│   ├── games.json
│   ├── wallet.json
│   └── errors.json
├── ar/
│   ├── common.json
│   ├── rooms.json
│   ├── moments.json
│   ├── games.json
│   ├── wallet.json
│   └── errors.json
├── de/
├── en/
└── pt/
```

## Çeviri Dosyası Formatı (JSON)

```json
{
  "common": {
    "app_name": "SchamChat",
    "welcome": "Hoş Geldiniz",
    "loading": "Yükleniyor...",
    "error": "Bir hata oluştu"
  },
  "buttons": {
    "continue": "Devam Et",
    "cancel": "İptal Et",
    "save": "Kaydet",
    "delete": "Sil"
  }
}
```

## Uygulama Örneği (React)

```javascript
import { useTranslation } from 'react-i18next';

function App() {
  const { t, i18n } = useTranslation();
  
  const changeLanguage = (lang) => {
    i18n.changeLanguage(lang);
  };
  
  return (
    <div>
      <h1>{t('common.app_name')}</h1>
      <select onChange={(e) => changeLanguage(e.target.value)}>
        <option value="tr">Türkçe</option>
        <option value="ar">العربية</option>
        <option value="de">Deutsch</option>
        <option value="en">English</option>
        <option value="pt">Português</option>
      </select>
    </div>
  );
}
```

## Uygulama Örneği (Flutter)

```dart
import 'package:easy_localization/easy_localization.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      supportedLocales: [
        Locale('tr'),
        Locale('ar'),
        Locale('de'),
        Locale('en'),
        Locale('pt'),
      ],
      localizationsDelegates: context.localizationDelegates,
      locale: context.locale,
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('common.app_name').tr(),
      ),
    );
  }
}
```

## Çeviriler

### Türkçe Örnekleri (tr/common.json)

```json
{
  "app_name": "SchamChat",
  "welcome": "Hoş Geldiniz",
  "login": "Giriş Yap",
  "register": "Kayıt Ol",
  "logout": "Çıkış Yap",
  "profile": "Profil",
  "settings": "Ayarlar",
  "rooms": "Odalar",
  "moments": "Anlar",
  "games": "Oyunlar",
  "wallet": "Cüzdan"
}
```

### Arapça Örnekleri (ar/common.json)

```json
{
  "app_name": "شام تشات",
  "welcome": "أهلا بك",
  "login": "تسجيل الدخول",
  "register": "إنشاء حساب",
  "logout": "تسجيل الخروج",
  "profile": "الملف الشخصي",
  "settings": "الإعدادات",
  "rooms": "الغرف",
  "moments": "اللحظات",
  "games": "الألعاب",
  "wallet": "المحفظة"
}
```

### Almanca Örnekleri (de/common.json)

```json
{
  "app_name": "SchamChat",
  "welcome": "Willkommen",
  "login": "Anmelden",
  "register": "Registrieren",
  "logout": "Abmelden",
  "profile": "Profil",
  "settings": "Einstellungen",
  "rooms": "Zimmer",
  "moments": "Momente",
  "games": "Spiele",
  "wallet": "Geldbörse"
}
```

### İngilizce Örnekleri (en/common.json)

```json
{
  "app_name": "SchamChat",
  "welcome": "Welcome",
  "login": "Log In",
  "register": "Sign Up",
  "logout": "Log Out",
  "profile": "Profile",
  "settings": "Settings",
  "rooms": "Rooms",
  "moments": "Moments",
  "games": "Games",
  "wallet": "Wallet"
}
```

### Portekizce Örnekleri (pt/common.json)

```json
{
  "app_name": "SchamChat",
  "welcome": "Bem-vindo",
  "login": "Fazer Login",
  "register": "Se Registrar",
  "logout": "Fazer Logout",
  "profile": "Perfil",
  "settings": "Configurações",
  "rooms": "Salas",
  "moments": "Momentos",
  "games": "Jogos",
  "wallet": "Carteira"
}
```

## Yön Desteği (RTL)

Arapça ve Portekizce (seçmeli) için RTL (Sağdan Sola) desteği:

### React RTL Örneği

```javascript
const isRTL = ['ar'].includes(i18n.language);

return (
  <div dir={isRTL ? 'rtl' : 'ltr'}>
    {/* İçerik */}
  </div>
);
```

### Flutter RTL Örneği

```dart
MaterialApp(
  builder: (context, child) {
    return Directionality(
      textDirection: context.locale.languageCode == 'ar' 
        ? TextDirection.rtl 
        : TextDirection.ltr,
      child: child!,
    );
  },
)
```

## Best Practices

1. **Kısa ve Net Metinler Yazın**
   - Çevirinin uzaması sorunlarına neden olabilir

2. **Placeholders Kullanın**
   ```json
   {
     "greeting": "Merhaba {name}!"
   }
   ```

3. **Pluralizasyon**
   ```json
   {
     "items": {
       "one": "{count} öğe",
       "other": "{count} öğe"
     }
   }
   ```

4. **Tarih/Saat Formatı**
   - Locale'e göre otomatik format
   - Örn: TR = GG.AA.YYYY, EN = MM/DD/YYYY

5. **Para Formatı**
   - Locale'e göre simge ve ondalak ayırıcı
   - Örn: TR = ₺1.234,56 EN = $1,234.56

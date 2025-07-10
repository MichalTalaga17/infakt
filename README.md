# inFakt iOS App - WebView-Based Solution

## Przegląd Projektu

Aplikacja iOS dla inFakt zbudowana w oparciu o WebView, integrująca natywne funkcje systemu iOS z funkcjonalnością webową. Projekt został stworzony jako rozwiązanie zadania rekrutacyjnego na stanowisko iOS Developer.

## Główne Funkcje

### Podstawowe Wymagania
- **WebView Integration**: Pełna integracja z aplikacją webową inFakt
- **Autoryzacja**: Integracja z systemem logowania `konto.infakt.pl`
- **Główna Aplikacja**: Dostęp do `front.infakt.pl` po autoryzacji
- **Natywna Nawigacja**: Wsparcie dla gestów iOS (swipe, pull-to-refresh)
- **Haptyka**: Haptyczne powiadomienia o np. załadowaniu aplikacji

### Funkcje Bezpieczeństwa
- **Face ID Authentication**: Biometryczna autoryzacja przy każdym uruchomieniu

### Natywne Funkcje iOS
- **Push Notifications**: Pełne wsparcie dla powiadomień push (w demo wysyłene z Apple Developer Console)
- **Haptic Feedback**: Taktyczne sprzężenie zwrotne dla lepszego UX
- **Network Monitoring**: Monitorowanie stanu połączenia internetowego
- **Offline Detection**: Automatyczne wykrywanie i obsługa trybu offline

## Stack Technologiczny

### Języki i Frameworki
- **Swift 5.9+**
- **SwiftUI** - Nowoczesny framework UI
- **UIKit** - Integracja z komponentami UIKit
- **WebKit** - Zaawansowana integracja WebView

### Natywne API iOS
- **LocalAuthentication** - Face ID / Touch ID
- **UserNotifications** - Local notifications i Push notifications
- **Network** - Monitorowanie połączenia z Internetem
- **Combine** - Reaktywne programowanie


## 📁 Struktura Projektu

```
inFakt/
├── App/
│   ├── infaktApp.swift          # Główna aplikacja
│   └── AppDelegate.swift        # Delegate aplikacji
├── Core/
│   ├── Models/                  # Modele danych
│   ├── Services/                # Usługi biznesowe
│   ├── Extensions/              # Rozszerzenia
│   └── Utils/                   # Narzędzia pomocnicze
├── Features/
│   ├── Authentication/          # Moduł autoryzacji
│   └── WebView/                 # Moduł WebView
└── Presentation/
    ├── ViewModels/              # ViewModele
    └── Views/                   # Widoki SwiftUI
```


## User Experience

### Interakcje
- **Pull-to-Refresh**: Odświeżanie zawartości
- **Swipe Navigation**: Nawigacja w przód/tył
- **Double-tap Refresh**: Szybkie odświeżanie
- **Haptic Feedback**: Haptyczne potwierdzenia

## Bezpieczeństwo

### Autoryzacja Biometryczna
- Automatyczna autoryzacja przy uruchomieniu
- obsługa błędów dla urządzeń bez biometrii

## Monitorowanie i Diagnostyka

### Network Monitoring
- Real-time monitoring połączenia
- Automatyczne odświeżenie po odzyskaniu połączenia z internetem
- Wykrywanie utraty połączenia

## Problemy i ograniczenia

- Konieczność pracy na testowych Push Notifications z uwagi na brak dostępu do backendu
- Niektóre ze styli strony internetowaej nie są dopasowane do aplikacji mobilnej, np. utrzymanie dolnej belki w dole ekranu



Projekt został stworzony jako część procesu rekrutacyjnego dla inFakt. 

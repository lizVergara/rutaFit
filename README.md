# RutaFit
RutaFit registra tu actividad diaria, simula sincronización con dispositivos BLE y te inspira con consejos de salud basados en evidencia, todo en una interfaz limpia y moderna. Todo **offline-friendly** gracias
a su base de datos local y una interfaz diseñada para motivarte cada día.

## 🏋️‍♀️ Qué puedes hacer con RutaFit

| Sección | Experiencia del usuario |
|---------|-------------------------|
| **Login inteligente** | • Crea hasta 2 perfiles por dispositivo.<br>• Contraseña cifrada en Hive.<br>• Vuelve a la app y tu sesión sigue abierta.<br>
| **Sincronización BLE con animación realista** | Un botón circular animado escanea (simulado), que accede a los permisos reales del dispositivo y añade entre 1-1000 pasos a tu total diario, mostrando una notificación motivadora. |
| **Contador de pasos persistente** | Los pasos se acumulan por usuario y se guardan localmente en tu dispositivo, incluso después de cerrar la app. |
| **Consejos de salud al instante** | RutaFit descarga 10 tips de bienestar en español desde la API pública MyHealthfinder |
| **Búsqueda inteligente** | Toca cualquier tip y RutaFit abre automáticamente una búsqueda en Google con el tema para ampliar tu información. |
| **Sin conexión?** | Los pasos y usuarios viven en Hive: la app funciona sin internet; los consejos se muestran cuando haya conexión disponible. |

---

## Arquitectura del proyecto
lib/
└─ src/
├─ models/ # Clases de datos
├─ services/ # Capa externa
├─ controllers/ # Lógica de estado de la aplicacion
├─ widgets/ # Componentes reutilizables 
├─ screens/ # Pantallas 
└─ theme/ # Paleta de colores y tema global
---
##  Permisos solicitado por la aplicación
• Android: se declaran Bluetooth y queries de intent en AndroidManifest.xml
• iOS: descripciones Bluetooth y Motion en Info.plist

Flujo de uso
1. Crear usuario → Inicia sesión y se guarda en Hive.
2. Pestaña Sync
     • Pulsa Sincronizar dispositivo → activación BLE → pasos sumados.
3. Pestaña Tips
     • Pull-to-refresh o botón Cargar consejos.
     • Toca cualquier tip → se abre Google con más información.
4. Cerrar sesión cuando lo desees (resetea last_user en Hive).
---
##  Cómo ejecutar
```bash
git clone https://github.com/lizVergara/rutafit.git
cd rutafit
flutter pub get
flutter run
---

En correo he dejado el apk de la aplicacion para que puedan probarla en un dispositivo android.


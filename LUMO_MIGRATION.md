# 🌟 Migración de News Toolkit a Lumo

## 📋 Estado de Migración

### ✅ Fase 1: Limpieza (COMPLETADO)

#### Features Eliminadas
- ❌ `lib/ads/` - Sistema de publicidad
- ❌ `lib/subscriptions/` - Planes de suscripción
- ❌ `lib/newsletter/` - Newsletter
- ❌ `lib/slideshow/` - Slideshows de noticias
- ❌ `lib/magic_link_prompt/` - Magic link específico de news

#### Packages Eliminados
- ❌ `packages/ads_consent_client/`
- ❌ `packages/in_app_purchase_repository/`
- ❌ `packages/purchase_client/`

#### Archivos Actualizados
- ✅ `pubspec.yaml` - Eliminadas dependencias innecesarias
- ✅ `lib/app/view/app.dart` - Removidos AdsConsentClient y InAppPurchaseRepository
- ✅ `lib/main/main_development.dart` - Actualizado bootstrap
- ✅ `lib/main/main_production.dart` - Actualizado bootstrap
- ✅ `lib/navigation/view/nav_drawer.dart` - Removida sección de subscripción

#### Configuración
- ✅ FVM configurado con Flutter 3.32.7 (Dart 3.8.1)
- ✅ Dependencias instaladas

---

### 🔄 Fase 2: Adaptación Base (EN PROGRESO)

#### 2.1 Estructura de Navegación
- [ ] Adaptar `lib/home/` para dashboard de Lumo
- [ ] Modificar navegación bottom bar/drawer
- [ ] Actualizar l10n (internacionalización) con textos de Lumo

#### 2.2 Transformar Feed/Categories
- [ ] Convertir `lib/feed/` de noticias a feed social/hábitos
- [ ] Adaptar `lib/categories/` para categorías de hábitos
- [ ] Modificar `lib/article/` para detalles de hábito/post

---

### 📦 Fase 3: Crear Nuevos Packages (PENDIENTE)

#### Repositories
```bash
packages/
├── habits_repository/          # NUEVO - Gestión de hábitos
├── emotions_repository/         # NUEVO - Tracking emocional  
├── ai_repository/              # NUEVO - Integración con IA
└── social_repository/          # NUEVO - Features sociales
```

#### Packages de Soporte
```bash
packages/
├── lumo_models/               # NUEVO - Modelos compartidos (Habit, Emotion, etc)
└── charts/                    # NUEVO - Componentes de gráficas (opcional)
```

---

### 🎨 Fase 4: Nuevas Features (PENDIENTE)

```bash
lib/
├── habits/                    # NUEVO - Tracking de hábitos
│   ├── bloc/
│   ├── view/
│   └── widgets/
├── emotional_wellbeing/       # NUEVO - Registro emocional
│   ├── bloc/
│   ├── view/
│   └── widgets/
├── ai_companion/              # NUEVO - Chat con IA
│   ├── bloc/
│   ├── view/
│   └── widgets/
├── social/                    # NUEVO - Features sociales
│   ├── bloc/
│   ├── view/
│   └── widgets/
└── insights/                  # NUEVO - Analytics y insights
    ├── bloc/
    ├── view/
    └── widgets/
```

---

### 🎨 Fase 5: Branding Lumo (PENDIENTE)

#### Design System
- [ ] Actualizar `packages/app_ui/lib/src/colors/` con paleta de Lumo
- [ ] Modificar `packages/app_ui/lib/src/typography/` 
- [ ] Actualizar logo en `packages/app_ui/assets/`
- [ ] Crear nuevos iconos/ilustraciones

#### Nuevos Widgets
- [ ] `LumoCard` - Tarjetas con diseño de Lumo
- [ ] `HabitCard` - Tarjeta de hábito
- [ ] `EmotionPicker` - Selector de emociones
- [ ] `ProgressRing` - Anillo de progreso
- [ ] `MoodChart` - Gráfica de estado de ánimo

---

### 🔌 Fase 6: Backend API (PENDIENTE)

#### Nuevos Endpoints
```bash
api/routes/api/v1/
├── habits/
│   ├── index.dart           # GET, POST /habits
│   └── [id].dart           # GET, PUT, DELETE /habits/:id
├── emotions/
│   ├── index.dart           # GET, POST /emotions
│   └── insights.dart        # GET /emotions/insights
├── ai/
│   ├── chat.dart           # POST /ai/chat
│   └── suggestions.dart    # GET /ai/suggestions
└── social/
    ├── feed.dart           # GET /social/feed
    └── connections.dart    # GET, POST /social/connections
```

#### Modelos de Datos
```bash
api/lib/src/data/models/
├── habit.dart              # NUEVO
├── emotion.dart            # NUEVO
├── ai_message.dart         # NUEVO
└── social_post.dart        # NUEVO
```

---

## 🗺️ Roadmap de Implementación

### Sprint 1: Fundamentos (Semana 1)
1. ✅ Limpieza de código
2. 🔄 Adaptar navegación base
3. ⏳ Crear packages base (habits_repository, emotions_repository)

### Sprint 2: Features Core (Semana 2-3)
1. ⏳ Implementar feature de hábitos
2. ⏳ Implementar tracking emocional
3. ⏳ Actualizar backend con endpoints básicos

### Sprint 3: AI & Social (Semana 4-5)
1. ⏳ Integrar AI companion
2. ⏳ Implementar features sociales
3. ⏳ Crear sistema de insights

### Sprint 4: Polish & Testing (Semana 6)
1. ⏳ Aplicar branding completo de Lumo
2. ⏳ Testing exhaustivo
3. ⏳ Optimizaciones de rendimiento
4. ⏳ Documentación

---

## 📝 Notas de Desarrollo

### Decisiones de Arquitectura

#### Mantener:
- ✅ Estructura feature-first
- ✅ BLoC/Cubit para state management
- ✅ Repository pattern
- ✅ Dependency injection con Provider
- ✅ HydratedBloc para persistencia
- ✅ Firebase Authentication
- ✅ Dart Frog como BFF

#### Adaptar:
- 🔄 `news_repository` → Base para `habits_repository`
- 🔄 `feed/` → Feed social de Lumo
- 🔄 `categories/` → Categorías de hábitos
- 🔄 `article/` → Detalles de contenido (hábitos, posts)

#### Agregar:
- ➕ AI integration (OpenAI, Gemini, o similar)
- ➕ Charts/Visualizations (fl_chart o similar)
- ➕ Real-time features (WebSockets para chat)
- ➕ Image upload/storage (Firebase Storage)
- ➕ Push notifications personalizadas

---

## 🚀 Comandos Útiles

```bash
# Ejecutar la app
fvm flutter run --flavor development --target lib/main/main_development.dart

# Generar código (BLoC, JSON)
fvm flutter pub run build_runner build --delete-conflicting-outputs

# Backend
cd api && dart_frog dev

# Tests
fvm flutter test

# Analizar código
fvm flutter analyze

# Ver paquetes desactualizados
fvm flutter pub outdated
```

---

## 📚 Referencias

- [Flutter News Toolkit Docs](https://vgventures.github.io/news_toolkit/)
- [BLoC Pattern](https://bloclibrary.dev)
- [Dart Frog](https://dartfrog.vgv.dev)
- [Firebase Flutter](https://firebase.google.com/docs/flutter/setup)
- [Clean Architecture Flutter](https://github.com/ResoCoder/flutter-tdd-clean-architecture-course)

---

**Última actualización:** 2025-10-26  
**Flutter Version:** 3.32.7  
**Dart Version:** 3.8.1




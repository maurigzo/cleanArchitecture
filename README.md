# 🧹 CleanArchitecture - Pokédex App

Una aplicación modular de iOS que muestra una Pokédex con los detalles de cada Pokémon, implementada utilizando una arquitectura limpia (**Clean Architecture**) y desarrollada en Swift.

## 🚀 Características

- Lista de Pokémon con imágenes oficiales.
- Vista detallada de cada Pokémon con estadísticas y tipos.
- Uso de **Combine** para manejar flujos reactivos.
- Arquitectura modular con las capas: `Presentation`, `Domain`, `Data` e `Infrastructure`.
- Integración de SwiftUI y UIKit para aprovechar lo mejor de ambos mundos.
- Sistema extensible y preparado para pruebas unitarias.

---

## 🏗️ Arquitectura

El proyecto sigue el patrón **Clean Architecture**, con las siguientes capas principales:

1. **Presentation**: Encargada de la interfaz de usuario, utilizando SwiftUI y UIKit.
2. **Domain**: Contiene las entidades, casos de uso y lógica de negocio.
3. **Data**: Gestiona los datos provenientes de APIs y mapea los datos entre capas.
4. **Infrastructure**: Provee implementaciones específicas de clientes HTTP y almacenamiento.

Cada capa es independiente y fácilmente testeable, asegurando modularidad y mantenibilidad.

---

## 📚 Tecnologías y Librerías

- **SwiftUI**: Para las pantallas de detalles.
- **UIKit**: Para la navegación y la lista principal.
- **Combine**: Para manejar flujos reactivos.
- **XCTest**: Para pruebas unitarias de casos de uso y validación de memoria.

---

## 🧑🏻‍💻 Autor
Gonzalo Mauricio Ramírez

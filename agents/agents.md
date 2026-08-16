# AI Agent Guidelines & Mobile Development Best Practices

Welcome! This document provides instructions and guidelines for AI agents operating in this workspace, alongside recommended standards for mobile application engineering.

______________________________________________________________________

## 🤖 General Agent Instructions

1. **Safety First**: Prioritize safe, deterministic, and maintainable code changes.
1. **Modular Architecture**: Keep components loosely coupled with clean interfaces.
1. **Immutability & State Management**: Prefer immutable state models (`val` in Kotlin, `let` / `@State` / `struct` in Swift) and explicit unidirectional data flow.
1. **Conventional Commits**: Ensure commit messages strictly follow the Conventional Commits specification (e.g. `feat:`, `fix:`, `chore:`).
1. **Proactive Verification**: Always test and verify changes using relevant linters and unit test suites before completing tasks.

______________________________________________________________________

## 📱 Mobile Engineering Best Practices

### 🤖 Android (Kotlin & Jetpack Compose)

- **Architecture**: Follow Clean Architecture and Unidirectional Data Flow (UDF).
  - **UI Layer**: Jetpack Compose views observing `StateFlow` exposed by ViewModel.
  - **Domain Layer**: Use cases encapsulating single business operations.
  - **Data Layer**: Repositories managing data sources (Room database, Retrofit/Ktor network clients).
- **Asynchronous Execution**:
  - Use Kotlin Coroutines and `Flow` / `StateFlow`.
  - Always tie coroutine scopes to lifecycle components (`viewModelScope`, `lifecycleScope`).
  - Avoid passing `Context` references into ViewModels to prevent memory leaks.
- **Compose Performance**:
  - Use `@Stable` and `@Immutable` annotations on state classes when appropriate.
  - Remember keys in lazy lists (`LazyColumn(items, key = { it.id })`).
  - Defer state reads to layout/draw phases using lambdas where possible to avoid unnecessary recompositions.

### 🍏 iOS (Swift & SwiftUI)

- **Architecture**:
  - MVVM with SwiftUI views and `@Observable` / `ObservableObject` ViewModels.
  - Keep logic out of SwiftUI views; delegate to ViewModels or Domain Services.
- **Asynchronous Execution**:
  - Use Swift Concurrency (`async`/`await`, `Task`, `Actor`).
  - Use `[weak self]` in completion closures to eliminate retain cycles.
  - Isolate UI updates to `@MainActor`.
- **SwiftUI Performance**:
  - Ensure view IDs are stable.
  - Break complex views into small, reusable subviews.

### 🌐 Cross-Platform & KMP

- Share domain logic, models, and network layers via Kotlin Multiplatform (KMP).
- Keep UI code platform-native (Jetpack Compose / SwiftUI) or use Compose Multiplatform where applicable.

______________________________________________________________________

## 🧪 Testing & Code Quality

- **Unit Testing**:
  - Android: `JUnit5`, `Mockk`, and `Turbine` for testing Coroutine Flows.
  - iOS: `XCTest` or `Swift Testing` for ViewModels and Domain logic.
- **Code Style**:
  - Enforce `ktlint` for Kotlin and `swiftlint` for Swift.
  - Keep functions focused and concise.

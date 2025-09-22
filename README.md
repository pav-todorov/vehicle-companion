# Vehicle Companion – iOS App
An iOS app that helps a vehicle owner manage their car and plan outings

## Project Setup

Running the Project:
- Xcode: 26.0
- iOS Deployment Target: 17.0
- Build Modes: Debug (suitable for UI tests with mock data) & Release (no mock data, real time data fetch)
- Configuration: .xcconfig files for managing build settings (API keys, environments, flags)
- Tests:
  - Unit Tests
  - UI Tests

Using modern tools ensures compatibility with SwiftUI, SwiftData, and async/await features. Configuration files allow clean and scalable build environments.

---

## Architecture & Design

MVVM + Repository Pattern:
- MVVM separates UI, logic, and data clearly
- Repository layer abstracts data fetching and storage, making mocking and unit testing easier

UI/Screen States:
- Views are driven by enum-based states like:
  - loading
  - success
  - empty
  - error

This keeps UI logic clean and improves user experience by clearly displaying different states of the app.

Brandbook:
- Centralized place for all design-related values:
  - Padding
  - Spacing
  - Colors
  - Fonts
  - Corner radii
  - Animations

Improves consistency across the app and makes theming easier.

---

## Data Modeling

DTOs:
- Used for decoding network responses.
- UI models for easier handling and data consumption
- They are marked as `actor` to support concurrency and avoid thread-safety issues.
- Codable and lightweight, perfect for parsing.

Enums like FuelType and Category:
- Used to replace raw strings with type-safe values
- Makes UI code cleaner and reduces the chance of typos
- CaseIterable + Identifiable make them great for SwiftUI usage

Category includes a computed property `symbolName` which maps each category to an SF Symbol, centralizing icon logic.

SwiftData Models:
- PoiUIModel and Vehicle are marked with `@Model`
- Use SwiftData attributes like `.unique` for uniqueness constraints and `.externalStorage` for storing image data more efficiently
- Transform DTOs into these models for UI and persistence
- Includes helper methods like `.mock()` and `.empty()` to support testing and previews

Coordinate Transformation:
- The `loc` array from the API is mapped to CLLocationCoordinate2D in the UI model, ensuring type safety and SwiftUI Map compatibility

---

## Error and Empty State Handling

- Views handle `.empty` and `.error` states using conditional logic and display placeholders or alerts
- User feedback is immediate and appropriate
- `.mock()` and `.empty()` models make it easy to preview and test all screen states

---

## What I’d Build Next

If more time was available, I would prioritize:

- Add SwiftLint to enforce style consistency and prevent bad practices
- Integrate SonarQube for static analysis, checking for bugs, vulnerabilities, and code smells
- Use Sourcery to:
  - Auto-generate boilerplate code (Equatable, Hashable, Mocks)
  - Prevent merge conflicts in project.pbxproj by minimizing manual editing
- Create enums for all SF Symbols to avoid string-based typos in image names
- Write tests to:
  - Validate that all images exist in Assets.xcassets
  - Ensure every font/color defined in Brandbook is used and valid
- Move all configuration values (e.g. layout constants, API keys, flags) into the Brandbook
- SPM (Swift Package Manager) modules for better separation of concers (also multiple teams could better work on different modules at the same time) - UI components, services, etc.
- Resource existence tests for images and fonts
- CI-based/hooks/local linting and test automation
- Façade patter for external libraries for easier vendor swap and better upgradability

---

## Testing Strategy

- Repository and ViewModels are fully mockable
- `.mock()` and `.empty()` methods allow snapshot previews and reliable UI states

---

## Summary

This project is built on a modern iOS stack (SwiftUI + SwiftData + Swift Testing), clean architecture (MVVM + Repository), and scalable design principles (Brandbook, state-driven views). It’s structured for easy testing, fast development, and future scalability through automation tools.

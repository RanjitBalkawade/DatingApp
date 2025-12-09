# InnerCircle Dating App

iOS dating app demonstrating UIKit and SwiftUI integration with clean architecure.

## Requirements

- iOS 16+
- Xcode 14+
- Swift 5+

## Login Credentials

- Email containing **"new"** → New user (goes to Onboarding flow)
- Any other email → Aproved user (goes directly to Home)
- Password can be anything

## Future Enhancements
- Unit testing is not done considering scope and time limit of the assignment


## Project Structure

The app follows **MVVM-C** (Model-View-ViewModel-Coordinator) pattern:

## Architecture Overview

### Coordinator Pattern

Each major flow has its own coordinator that handles navigation:

- **AppCoordinator** - Root coordinator, manage app-level routing
- **LoginCoordinator** - Handles login flow
- **OnboardingCoordinator** - Manages 11-step onboarding process
- **HomeCoordinator** - Controls home screen

**Key benefit:** Child coordinators decide where to go next (autonomous routing), parent coordinators just execute the navigation. This keeps business logic with the coordinator that owns it.

### Dependency Injection

All dependencies are injected through constructors:
- **SceneDelegate** is the composition root (where everything is wired up)
- Services created once and passed down through coordinators

## Key Technical Decisions

### 1. Why Coordinator Pattern?

Coordinators handle all navigation logic seperately from view controllers. This makes it easy to:
- Switch between UIKit and SwiftUI screens
- Change navigation flows without touching UI code
- Test navigation logic independently

### 2. Why Closures Instead of Delegates for Coordinators?

```swift
loginCoordinator.onFinish = { [weak self, weak loginCoordinator] destination in
    // Handle completion
}
```

Benefits:
- Less code than delegate protocols
- Behavior is defined right where coordinator is created
- Easier to read (no jumping between files)

### 3. Why Dependency Injection?

All dependencies are passed through constructors rather than using singletons:
- Makes dependencies explicit and visible
- Easier to test (can inject mock services)
- No hidden global state

## Memory Management

The app is memory-leak free:
- All coordinator references use `weak` to prevent retain cycles
- Closure captures use `[weak self]` where needed
- Combine subscriptions are stored in `cancellables` set (auto-cancelled on dealloc)
- All delegates are marked as `weak`

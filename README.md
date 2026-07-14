# vortextech-appdev-week2
A Flutter To-Do List app with a clean Material Design interface that allows users to add, complete, and delete tasks.

# Flutter To-Do List App

A simple and responsive To-Do List application built with **Flutter** as part of the **Vortex Tech App Development Internship – Week 2**.

The application demonstrates basic Flutter state management using `StatefulWidget` and `setState()`, allowing users to manage their daily tasks with a clean Material Design interface.

## Features

* ➕ Add new tasks
* ✅ Mark tasks as completed using checkboxes
* 📝 Completed tasks display with a strikethrough effect
* 🗑️ Delete tasks using the delete button
* 👆 Swipe to delete tasks with `Dismissible`
* 📱 Responsive Material Design UI

## Technologies Used

* Flutter
* Dart
* Material Design

## Project Structure

```
lib/
└── main.dart
```

The project contains:

* `Task` model class
* `StatefulWidget` for state management
* `TextEditingController` for task input
* `ListView.builder` for displaying tasks
* `CheckboxListTile` for task completion
* `Dismissible` widget for swipe-to-delete functionality

## Getting Started

### Prerequisites

* Flutter SDK installed
* Android Studio or Visual Studio Code
* Android Emulator or Physical Android Device

### Installation

1. Clone the repository:

```bash
git clone https://github.com/MuhammadDaud811/vortextech-appdev-week2.git
```

2. Navigate to the project directory:

```bash
cd vortextech-appdev-week2
```

3. Install dependencies:

```bash
flutter pub get
```

4. Run the application:

```bash
flutter run
```

## Learning Objectives

This project demonstrates:

* Stateful widgets
* State management using `setState()`
* Managing lists in Flutter
* Working with `TextEditingController`
* Building dynamic UIs with `ListView.builder`
* Using `CheckboxListTile`
* Implementing swipe-to-delete with `Dismissible`

## Assignment

This project was developed as part of the **Vortex Tech App Development Internship 2026 – Week 2 (Beginner–Intermediate Track)**.

The objective was to build a fully functional To-Do List application where users can:

* Add tasks
* Mark tasks as completed
* Delete tasks
* Manage the task list using local state

## Author

**Muhammad Daud**

Software Engineering Student
International Islamic University Islamabad

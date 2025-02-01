
<img width="722" alt="Screenshot 2025-01-31 at 11 34 41 PM" src="https://github.com/user-attachments/assets/d95dff0d-0ef6-482f-a8f3-3052e45a0def" />


DOWNLOAD:[ https://github.com/profmitchell/snip/releases](https://github.com/profmitchell/snip/releases/tag/V1.0)

---

# Snip

**Snip** is a macOS menu bar application built with SwiftUI that lets you quickly manage and copy notes. It features organized categories, tabs, and notes with intuitive double–click renaming and state persistence. The app runs as a status item in the menu bar, keeping your workflow clutter–free while providing quick access to your notes.

---

## Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Requirements](#requirements)
- [Installation](#installation)
- [Usage](#usage)
- [Project Structure](#project-structure)
- [Accessibility Permissions](#accessibility-permissions)
- [Contributing](#contributing)
- [License](#license)
- [Acknowledgements](#acknowledgements)

---

## Overview

**Snip** is designed for developers, writers, and anyone who needs to quickly copy snippets of text from organized notes. By running entirely from the menu bar, Snip provides a seamless, distraction–free environment for accessing your notes. Users can easily create, rename, reorder, and delete categories, tabs, and notes. The app also remembers the collapsed/expanded state of each note, ensuring your layout stays just the way you left it.

---

## Features

- **Menu Bar Application:**  
  Runs as a status item in the macOS menu bar with a custom icon.

- **Notes Management:**  
  - Create, edit, and copy notes quickly.
  - Persisted note state (collapsed or expanded) across sessions.
  - Double–click any note title to rename it instantly.

- **Organizational Hierarchy:**  
  - **Categories:** Group related tabs together.
  - **Tabs:** Within each category, organize your notes further.
  - **Notes:** Edit and copy text from individual note cards.

- **Inline Renaming:**  
  Double–click category names, tab names, or note titles to edit them directly.

- **Reorderable Notes:**  
  Drag and drop notes to rearrange them.

- **Settings Screen:**  
  - View developer information.
  - Recheck accessibility permissions.
  - Quit the app.

- **Accessibility Permission Caching:**  
  The app prompts for accessibility permission only on first launch (or when manually rechecked) and caches the result.

---

## Requirements

- **macOS:** Version 10.15 (Catalina) or later (macOS Ventura recommended).
- **Xcode:** 15 or later.
- **SwiftUI:** Built using the SwiftUI lifecycle.
- **Accessibility Permissions:** The app requires accessibility permissions to function (for text copying).

---

## Installation

1. **Clone the Repository:**

   ```bash
   git clone https://github.com/yourusername/Snip.git
   cd Snip
   ```

2. **Open in Xcode:**

   Open the `Snip.xcodeproj` file in Xcode.

3. **Configure Code Signing:**

   Ensure your project’s code signing is properly configured in Xcode. If running in development, you may use your development team and provisioning profile.

4. **Build and Run:**

   Build and run the project (⌘R). The app will launch as a menu bar item.

---

## Usage

- **Menu Bar Icon:**  
  Click the Snip icon in the menu bar to open the popover window.

- **Categories & Tabs:**  
  - Use the sidebar to view and manage categories.  
  - Double–click any category name to rename it.
  - In the tabs area at the top of the popover, double–click a tab name to rename it.  
  - Use the plus (`+`) and minus (`–`) buttons in the tabs area to add or delete tabs.

- **Notes:**  
  - Create new notes within a tab using the plus button.
  - Double–click a note title to rename it.
  - Collapse or expand a note by clicking the chevron icon.
  - Copy a note’s content by clicking the copy button (doc icon).
  - Reorder notes by dragging them within the list.

- **Settings:**  
  Click the gear icon in the top–right to open the settings screen. From there, you can recheck accessibility permissions (if needed) or quit the app.

---

## Project Structure

- **SnipApp.swift:**  
  The app’s entry point, including the AppDelegate. This file sets up the status bar item, manages accessibility permission caching, and launches the popover.

- **ContentView.swift:**  
  Contains the main UI for Snip, including:
  - Data models for Note, Tab, and Category.
  - The sidebar for directories and categories.
  - The main content area with tabs and notes.
  - Custom views such as `EditableText` and `EditableTabView` for inline renaming.

- **AppFileManager.swift:**  
  A helper class for saving and loading the categories (and their associated tabs and notes) as JSON in the Application Support directory.

---

## Accessibility Permissions

**Snip** requires accessibility permissions to copy text programmatically. The app checks and caches these permissions on first launch. If you need to revalidate the permissions, use the "Recheck Permissions" button in the Settings screen.  
Ensure your app is properly signed to avoid repeated prompts.

---

## Contributing

Contributions are welcome! If you have any ideas for improvements or bug fixes, please open an issue or submit a pull request. For major changes, please discuss them first via GitHub issues.

1. Fork the repository.
2. Create a feature branch (`git checkout -b feature/YourFeature`).
3. Commit your changes.
4. Push your branch and open a pull request.

---

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

---

## Acknowledgements

- Thank you o3-mini for your help!

---

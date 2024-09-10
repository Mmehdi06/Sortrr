<div align="center">

![256](https://github.com/user-attachments/assets/5a0240f0-193e-4f5e-be53-105ddc3d5da5)

</div>


Sortrr is a macOS utility application that helps organize files and folders within the Downloads directory. It sorts files based on their extensions into predefined directories, and it places unmatched files and folders in specified directories.

## Features

- **Sort by Extension**: Files are sorted into directories based on their extensions, which are specified in a `config.json` file.
- **Folder Organization**: Folders are moved to a dedicated `"Folder"` directory.
- **Other Files Handling**: Files with extensions that are not listed in the `config.json` file are moved to an `"Other"` directory.
- **Menu Bar App**: The app runs in the macOS menu bar, providing easy access to sorting functions.

## Project Structure

```plaintext
Sortrr/
├── SortrrApp.swift         # Main app entry point for SwiftUI
├── Settings.swift          # Manages the settings and config data
├── AppMenu.swift           # Defines the menu UI in the macOS menu bar
├── FileManagerHelper.swift # File operations and configuration handling
├── config.json             # Stores file extension-to-folder mappings
└── Assets.xcassets         # Holds the app's images and other assets
```
## How It Works
1. Sorting:

Files in the Downloads directory are moved to specific folders based on their extension, as defined in config.json.
Folders without extensions are moved to a special folder called "Folder".
Files that have extensions not listed in config.json are moved to the "Other" folder.

2. Config File:

The config.json file contains mappings between file extensions and folders. An example format is shown below:
```json
{
  "customFolders": [
    {
      "folderName": "Multimedia",
      "extensions": ["mp3", "mp4", "jpg", "png"]
    },
    {
      "folderName": "Documents",
      "extensions": ["pdf", "docx", "txt"]
    },
      ...
  ]
}
```
* The app reads this file on startup to determine where to move files based on their extensions.

## Usage

1. The application runs in the macOS menu bar.
2. Click the menu bar icon to open the app menu.
3. From the menu, click "Sort Now" to organize your Downloads folder.
4. Files will be moved to corresponding directories based on their extensions.
5. Folders without extensions are moved to the "Folder" directory, and files with unlisted extensions are moved to "Other".

## Example Scenarios
* Files with Listed Extensions:
  * Files like .mp3, .pdf, etc., are moved into folders such as "Multimedia" or "Documents" as defined in the config.json.

* Unlisted Files:
  * Files with extensions not listed in the config.json file are moved to the "Other" directory.

* Folders:
  * Folders (i.e., items with no extension) are moved to a directory named "Folder".


## Development
* This project uses SwiftUI and AppKit for the macOS user interface and file operations.




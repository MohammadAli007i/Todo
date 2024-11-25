To-Do Management App 
________________________________________
Project Overview
The To-Do Management App is a Flutter-based application that helps users manage tasks effectively. It includes features like adding, editing, marking tasks as completed, and deleting them. The app organizes tasks into two categories: Completed and Pending, ensuring a neat and efficient user experience.
________________________________________
How to Set Up and Run the Project
1.	Prerequisites
o	Install Flutter SDK (version 3.0.0 or later).
o	Install a code editor like Visual Studio Code or Android Studio.
o	Ensure your development environment is properly configured with Flutter.
2.	Steps to Set Up the Project
o	Clone the project repository to your local machine using git clone <repository-url>.
o	Open the project in your preferred code editor.
o	Run flutter pub get in the terminal to fetch the required dependencies.
3.	Running the Project
o	Connect a physical device or start an emulator.
o	Run the command flutter run in the terminal.
o	The app will compile and launch on your connected device/emulator.
________________________________________
State Management Approach
The app uses Provider for state management.
1.	Why Provider?
o	It is a lightweight, efficient, and reactive state management solution for Flutter apps.
o	It rebuilds only the necessary widgets when the state changes, improving performance.
2.	How Provider Works in This App
o	A central TodoProvider class is used to manage the app’s state.
o	The provider contains methods to perform operations like:
	Adding new tasks.
	Updating task details.
	Toggling between "completed" and "pending" states.
	Deleting tasks.
o	The provider notifies listeners whenever changes are made, ensuring the UI updates dynamically.
3.	Categorization of Tasks
o	The tasks are displayed in two separate sections:
	Pending: Shows tasks that are not yet completed.
	Completed: Displays tasks that are marked as completed.
o	Each category is styled distinctly to enhance visual clarity.
________________________________________
Key Features of the App
•	Add tasks with a title and description.
•	Edit task details using a bottom sheet dialog.
•	Mark tasks as completed or toggle them back to pending.
•	Delete tasks from the list when no longer needed.
•	View tasks in categorized sections for better organization.




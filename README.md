VideoGamesIA
This application allows users to manage a catalog of video games downloaded from a public API. The app offers an intuitive and functional interface, developed in SwiftUI using the MVVM architecture with local persistence through CoreData.

*Main features*

1.- Initial Load
Automatic download of the video game catalog from the API:
https://www.freetogame.com/api/games
The data is stored locally in a database for offline access.

2.- Search and Filter Screen
Search by video game name or category.
Results with automatic suggestions.
Detailed navigation of the selected video game.

3.- Video Game Detail Screen
Display of detailed information about the video game (title, image, description, etc.).
Options to edit and delete (logical deletion) a record.

4.- Data Persistence
Video games are stored in CoreData for fast and efficient access.
Implementation of logical deletion to keep records in the database.

5.- Interface
Responsive and accessible UI, designed with SwiftUI.
Real-time updates when searching or changing records.

*Architecture*
Pattern: MVVM (Model-View-ViewModel).
Persistence: CoreData.
API consumption: URLSession with Combine.
Error management: Use of operators such as catch in Combine.

-Installation-
git clone https://github.com/your-user/game-catalog-app.git

Unit tests implemented with XCTest to validate the ViewModel logic and correct data management.

Technologies used:
- Swift 5
- SwiftUI
- Combine
- CoreData
- Xcode 16.1

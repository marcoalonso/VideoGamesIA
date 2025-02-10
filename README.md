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

Unit tests implemented with XCTest to validate the ViewModel logic and correct data management.

Technologies used:
- Swift 5
- SwiftUI
- Combine
- CoreData
- Xcode 16.1

![image](https://github.com/user-attachments/assets/fe1a27a7-64fe-410f-a411-9e5902f618bb)

GameDetail
![image](https://github.com/user-attachments/assets/bf24f44f-ffb2-4353-88c5-5a1f22352242)



EditGame
![image](https://github.com/user-attachments/assets/83575317-1d10-4147-86ed-fd911576a082)

![image](https://github.com/user-attachments/assets/0b989d91-f11c-440a-8b33-6995e43ebc34)


You can visit the website
![image](https://github.com/user-attachments/assets/437ddbe3-5e63-4370-a814-ff42aee1e931)

and the profile website
![image](https://github.com/user-attachments/assets/0d0da281-4d43-4eb1-8aa0-a7face6559e3)


also can delete the game
![image](https://github.com/user-attachments/assets/ac87579e-7635-41ec-bc8e-819324dac758)


You can search by name and by category
![image](https://github.com/user-attachments/assets/ba6c462d-2ffc-44ab-a71a-4c10aedb5fe8)

![image](https://github.com/user-attachments/assets/f76cdc2f-74a6-4dc5-8b8a-9d3d0bfa87aa)

Finally you can enable DarkMode
![image](https://github.com/user-attachments/assets/b68f91bf-3fcc-402b-8c8d-d19c7539f13b)







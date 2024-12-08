# This application fetches and displays a list of characters from the Rick and Morty API, supporting filtering by character status and pagination. It demonstrates the use of Combine, SwiftUI, UIKIt and Moya for networking.


## Instructions for building and running the application

1- Clone the Repository


2- Install Dependencies
   Swift Package Manager:
   Dependencies will resolve automatically when you open the project in Xcode.
   Build and Run

3- Select the appropriate simulator/device in Xcode.

4- Press Cmd+R or click the Run button in Xcode.


## Assumptions and Decisions

Assumptions

1- Mock Data for Unit Testing:
   Mock services and data are used for unit tests to isolate the ViewModel's behavior.
   
2- Pagination:
   Characters are fetched page-by-page, and the app automatically fetches the next page when scrolling near the end of the list.
   
   
Design Decisions

1- MVVM Architecture: 
   The app follows the MVVM pattern to separate UI logic (View) from business logic (ViewModel).
   
2- Combine Framework: 
   Combine is used for reactive bindings and event propagation between the ViewModel and Views.
   
3- SwiftUI for Custom Views: SwiftUI components (like the filter view and character cards) are used within UIKit using UIHostingController.


## Challenges and How They Were Addressed

1- Handling Pagination and Filtering 
   Challenge: 
   Combining pagination with filtering required careful management of state to ensure the correct behavior (e.g., scrolling to top on filter changes but not during pagination).
   
   Solution: 
   listen to an selection flag in the ViewModel to track filter changes and trigger a table scroll to the top only when filters are modified.
   
2- Testing ViewModel with Mock Services
   Challenge: 
   Ensuring the ViewModel behaves correctly with a mocked service implementation.
   
   Solution: 
   Introduced a protocol (RickAndMortyServiceProtocol) to abstract the API service. Created a MockRickAndMortyService class in the test suite to supply mock data during unit tests.
   
3- Mixing UIKit and SwiftUI
   Challenge: 
   Embedding SwiftUI views (FilterView and CharacterCard) inside a UIKit app without breaking the UI consistency.
   Solution: 
   Used UIHostingController to seamlessly integrate SwiftUI components into UIKit.
   
   
## Future Improvements
   
1- Enhanced Network Error And UI: 
   Parse errors And Make a dedicated error view.
   
2- Testing Coverage: 
   Add UI tests to validate the interaction between the ViewModel and Views.
   
3- Local Storage
   Add Local storage and handle networking cases   


## Author
   Mai Hassen, maihassen92@gmail.com


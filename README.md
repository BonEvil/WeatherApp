# WeatherApp
Weather app code challenge using Open Weather

## App Structure
### User Interface
This application has a main View Controller ```WeatherViewController``` for weather information which is using UIKit.
The ```LocationSearchView``` is a SwiftUI view and is used to search for a location to use for weather data. This demonstrates the use of SwiftUI within a UIKit application

### Separation of concerns
Throughout the application you will find separate items for Controllers, Models, network services, etc. There are some areas where I could make them less dependent if I spent more time on cleanup.

Also, while I have most ‘errors’ marked, I have not implemented any notifications for users if something fails nor have I implemented any kind of activity indicator for network calls at this time.

Overall, I believe this project demonstrates a fairly well planned architecture for what is a seemingly simple application but is much more involved than it appears.

## 3rd-Party dependencies
I use the term ‘3rd-party’ here somewhat loosely. This dependency is actually my own open-source project.

#### BuckarooBanzai
This is a networking layer that I created and have updated to use modern concurrency idioms. The documentation is not complete as I have only recently been able to start detailing its use. Feel free to look it over as well as part of how I design projects.

https://github.com/BonEvil/BuckarooBanzai

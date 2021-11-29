📱📗 📱📗 📱📗 📱📗
# ListenHub-iOS
Listen to books anywhere


Developed by [Burhan ARAS] with all the love on planet.

**ListenHub :** An audio book app to listen to books everywhere.

## Architecture

We have developed this application using **MVVM-C Architecture** . We haved used the **Swift** programming language along industry-proven tools and libraries.

The main players in the MVVM-C pattern are:
  - **The View** — that informs the ViewModel about the user’s actions
  - **The ViewModel** — exposes streams of data relevant to the View
  - **The DataModel** — abstracts the data source. The ViewModel works with the DataModel to get and save the data.
  - **The Coordinator** - where dependency injection happens.


In this MVVM-C architecture SwiftUI depend only on a view model (which is an Observable Object). The repository is the only class that depends on multiple other classes; in this project, the repository depends on a persistent data model and a remote backend data source.

Repository is the single source of truth for all the app data and has a clean API for UI to communicate with.

Repository fetches data from network then it saves into local database and also notifies UI View classes.

***ListenHub Architecture Overview:*** 

![alt text](https://github.com/burhanaras/AndroCoda/blob/master/screenshots/SwiftUI_Architecture.jpg "ListenHub App Architecture")


## Used technologies and libraries

We have used popular, industry-proven tools and libraries :

* **SwiftUI** SwiftUI is a modern way to declare user interfaces for any Apple platform. 
* **Combine** provides a declarative Swift API for processing values over time.
* **Realm** To save data to local db
* **KingFisher** To fetch images from network
* **XCTest** To write automated tests
* **SwiftLint** To see warnings in our code

## Package Structure

* **UI** Contains UI related classes which are SwiftUI view and ObservableObjects.
* **Repository** Single source of truth for all the app data. Contains DAO, entity classes, Realm DB implementation and everything else related to database
* **Player** AVQueuePlayer and player model objects to play audio.
* **Network** Contains Combine implementation and UrlSession service api interface and data transfer objects
* **Views** Single source of truth for all the app data
* **Coordinator** Contains a WorkManager worker to run daily and keep local db up to date
* **Extension** Swift extensions for every kind of util functionalities.
* **App** SwiftUI App class which is main entry point of the app.


## TO-DO List

* Real network implementation
* Local DB implementation
* Apple Watch client
* iPadOS client
* CarPlay client
* AppleTV client
* Siri support
* Widget support


Developed By Burhan ARAS with all the love on planet
------------

www.burhanaras.net

   [Burhan ARAS]: <http://www.burhanaras.net>


License
-------

    Copyright 2020 Burhan ARAS

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.

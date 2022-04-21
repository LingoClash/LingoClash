<p align="center">
  
  ![E3wpp7a](https://user-images.githubusercontent.com/24221801/163687599-ab8ebd9b-f19d-4c26-9d84-3127cb85527b.png)
  
  <p align="center">
    LingoClash is an iPad application to learn languages competitively. It features a battle system, a revision system, and achievements.
    <br>
    <br>
    <img src="https://github.com/LingoClash/LingoClash/actions/workflows/Testing.yml/badge.svg" />
  </p>
</p>

# Requirements

- Xcode 13.3
- Swift 5.6
- Firebase 8.14
- PromiseKit 6.17

# Background

We are a group of language enthusiasts of diverse backgrounds. Having been exposed to numerous language learning apps, we have identified some of the best apps that have helped us tremendously in our learning journey.
Among these apps, we thought that 沪江 by 开心词场 is the closest to what we have envisioned as a perfect language-learning app. Despite that, we have not seen anything that resembles it in the English community and hence we decided to recreate it in English while also incorporating some of the best features that other apps have to offer such as spaced repetition.

# Team Members

[Hong Ai Ling](https://github.com/ailing35)  
[Kevin Chua Kian Chun](https://github.com/kevinchua6)  
[Sherwin Poh Kai Xun](https://github.com/sherrpass)  
[Toh Kar Wi](https://github.com/CrownKira)

# User Manual

The user manual can be found [here](https://www.notion.so/kyletoh/User-Manual-5df7eb411366419c9803ab0c4bcc6511)

# Getting started

## Setting up Firebase

- Create a Firebase project [here](https://console.firebase.google.com/u/0/) for both Production and Development.
- Add an iOS app. Enter your app's bundle ID in the iOS bundle ID field when prompted.
- Download and place the provided GoogleService-Info.plist under both `SupportingFiles/Development` and `SupportingFiles/Production` directories.
- On the Firebase console, enable Firestore and Storage for both Production and Development, and setup security rules for both of them.

For more information refer to the [Firebase Documentation for Swift](https://firebase.google.com/docs/ios/setup).

> Note: A valid GoogleService-Info.plist file is needed for the features to work.

## Setting up the project

- Open Xcode Project file.
- Wait for all the packages to be resolved.
- Choose the scheme to work with.

<div align="center">
  
| Scheme  | Description |
| ------------- | ------------- |
| LingoClash  | Production environment. Uses the production firestore database.  |
| LingoClash Dev  | Development environment. Uses the development firestore database.  |
 
</div>
  
- In the `AppConfigs`, some Debug variables are provided, to allow toggling between modes.

<div align="center">
  
| Variable  | Description |
| ------------- | ------------- |
| enablePreloadData  | Set to `true` to preload the firestore with sample data on app initialization.  |
| enableLogin  | Set to `false` to disable login for development purposes. Only works in `LingoClash Dev` scheme.  |
  
</div>

- `Build` the project and `Run` it. Enjoy~

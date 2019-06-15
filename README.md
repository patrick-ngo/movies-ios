# movies-ios

Sample app that fetches movies from TMDb API to display movies in:
- Movie List screen
- Movie Detail screen

Libraries used (Through CocoaPods)
- Alamofire: Networking calls
- SDWebImage: Image fetching and display
- SnapKit: Programmatic UI layout
- ReSwift: Unidirection data flow architecture
- RxSwift: Bindings for certain UI actions

Other notes:
- Used RxSwift quite sparingly as I'm quite inexperienced with it
- Used a Redux-like architecture for the data, using ReSwift
- Included a few XCTestCases to test the actions and reducers

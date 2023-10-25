# Weather

## how to build the project
- There isn't any pods or setup needed, so just downloading the app and running it should suffice (If you are testing on a simulator remember to set the location for the simulator so the app can get your current location)

## 3rd parties used
- swiftlint (I used it to help write cleaner code)
- swiftGen (I used this to generate code for resources like images and colors)

## architecture
- MVVM

## Conventions
### Naming conventions
- camelcase for variable names and pascalcase for data types and class names

### Indentation and Formatting
- comma-aligned for functions
- Proper indentation for code blocks

### File Structure
- Each screen is created under the scene folder with its viewModel, Model and ViewController under the same folder
- UIComponents and UI extensions shared across the app are added to the WeatherUI
- Other helpers shared across the app are to be added in Utility
- Network request are located under the Network folder

### Error Handling
- to log errors use Logger.shared.logDebug() and not print(), debugPrint() nor dump()

### Testing
- For unit testing name your tests as test<Subject><condition><expectedResult>()

## Additional notes
- I wanted to use combine but didn't get enough time because i haven't used it before, i have always used RxSwift
- TinyConstraints would have been a good addtion as well, it helps the code look cleaner when building the UI programmatically
- GRPC would have been nice for the APIs as well but yea i couldn't change the APIs nor use any 3rd parties network clients














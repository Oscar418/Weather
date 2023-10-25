//
//  WeatherTests.swift
//  WeatherTests
//
//  Created by Ndamu Nengovhela on 2023/10/23.
//

import XCTest
@testable import Weather

final class WeatherTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testCurrentWeather_whenComparing_IsEquatable() {
        let weather1 = Weather(main: "Clear", description: "Clear sky")
        let main1 = WeatherInfoData(temp: 25.0, feelsLike: 27.0, tempMin: 20.0, tempMax: 30.0)
        let currentWeather1 = CurrentWeather(weather: [weather1], main: main1, date: 1635132123)
        
        let weather2 = Weather(main: "Clear", description: "Clear sky")
        let main2 = WeatherInfoData(temp: 25.0, feelsLike: 27.0, tempMin: 20.0, tempMax: 30.0)
        let currentWeather2 = CurrentWeather(weather: [weather2], main: main2, date: 1635132123)
        
        let weather3 = Weather(main: "Rainy", description: "Heavy rain")
        let main3 = WeatherInfoData(temp: 20.0, feelsLike: 22.0, tempMin: 18.0, tempMax: 25.0)
        let currentWeather3 = CurrentWeather(weather: [weather3], main: main3, date: 1635132124)
        
        XCTAssertTrue(currentWeather1 == currentWeather2)
        XCTAssertFalse(currentWeather1 == currentWeather3)
    }
    
    func testForecastWeather_whenComparing_IsEquatable() {
        let weather1 = Weather(main: "Clear", description: "Clear sky")
        let main1 = WeatherInfoData(temp: 25.0, feelsLike: 27.0, tempMin: 20.0, tempMax: 30.0)
        let weatherInfo1 = WeatherInfo(date: 1635132123, main: main1, weather: [weather1], dtTxt: "2023-10-25 12:00:00")
        let forecastWeather1 = ForecastWeather(list: [weatherInfo1])
        
        let weather2 = Weather(main: "Clear", description: "Clear sky")
        let main2 = WeatherInfoData(temp: 25.0, feelsLike: 27.0, tempMin: 20.0, tempMax: 30.0)
        let weatherInfo2 = WeatherInfo(date: 1635132123, main: main2, weather: [weather2], dtTxt: "2023-10-25 12:00:00")
        let forecastWeather2 = ForecastWeather(list: [weatherInfo2])
        
        let weather3 = Weather(main: "Rainy", description: "Heavy rain")
        let main3 = WeatherInfoData(temp: 20.0, feelsLike: 22.0, tempMin: 18.0, tempMax: 25.0)
        let weatherInfo3 = WeatherInfo(date: 1635132124, main: main3, weather: [weather3], dtTxt: "2023-10-25 13:00:00")
        let forecastWeather3 = ForecastWeather(list: [weatherInfo3])
        
        XCTAssertTrue(forecastWeather1 == forecastWeather2)
        XCTAssertFalse(forecastWeather1 == forecastWeather3)
    }
    
    func testCurrentWeather_WhenEncodingDecoding_isEncodableDecodable() throws {
        let weather = Weather(main: "Sunny", description: "hot")
        let mainInfo = WeatherInfoData(temp: 29.0, feelsLike: 30.0, tempMin: 25.0, tempMax: 36.0)
        let currentWeather = CurrentWeather(weather: [weather], main: mainInfo, date: 1635132123)
        
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(currentWeather)
            let decoder = JSONDecoder()
            let decodedWeather = try decoder.decode(CurrentWeather.self, from: data)
            
            XCTAssertEqual(currentWeather.weather, decodedWeather.weather)
            XCTAssertEqual(currentWeather.main, decodedWeather.main)
            XCTAssertEqual(currentWeather.date, decodedWeather.date)
        } catch {
            XCTFail("Failed to encode or decode CurrentWeather: \(error)")
        }
    }
    
    func testForecastWeather_WhenEncodingDecoding_isEncodableDecodable() {
        let weather = Weather(main: "Clear", description: "Clear sky")
        let weatherInfoData = WeatherInfoData(temp: 24.0, feelsLike: 28.0, tempMin: 21.0, tempMax: 32.0)
        let weatherInfo = WeatherInfo(date: 1635132123, main: weatherInfoData, weather: [weather], dtTxt: "2023-08-24 12:00:00")
        let forecastWeather = ForecastWeather(list: [weatherInfo])
        
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(forecastWeather)
            let decoder = JSONDecoder()
            let decodedForecastWeather = try decoder.decode(ForecastWeather.self, from: data)
            
            XCTAssertEqual(forecastWeather.list, decodedForecastWeather.list)
        } catch {
            XCTFail("Failed to encode or decode ForecastWeather: \(error)")
        }
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}

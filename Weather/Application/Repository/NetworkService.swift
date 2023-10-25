//
//  NetworkService.swift
//  Weather
//
//  Created by Ndamu Nengovhela on 2023/10/23.
//

import Foundation

final class NetworkService<T: Codable> {

    func fetchData(from baseUrl: String, queryParams: [String: String], completion: @escaping (T?) -> Void) {
        var urlComponents = URLComponents(string: baseUrl)
        urlComponents?.queryItems = queryParams.map { key, value in
            URLQueryItem(name: key, value: value)
        }
        if let url = urlComponents?.url {
            URLSession.shared.dataTask(with: url) { data, _, error in
                if let data = data {
                    do {
                        let decoder = JSONDecoder()
                        let results = try decoder.decode(T.self, from: data)
                        completion(results)
                    } catch {
                        Logger.shared.logDebug("Error decoding JSON: \(error.localizedDescription)")
                        completion(nil)
                    }
                }
            }.resume()
        }
    }
}

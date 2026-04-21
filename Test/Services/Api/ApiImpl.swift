//
//  ApiServiceImpl.swift
//  Test
//
//  Created by Дмитрий Помин on 15.04.2026.
//
import Combine
import Foundation

final class ApiImpl: ApiProtocol {
    let jsonString = """
        [
          { "awesomeField": 10, "date": "2025-01-15T10:30:00Z", "id": "a1b2c3d4-0001" },
          { "awesomeField": 25, "date": "2025-01-16T11:45:00Z", "id": "a1b2c3d4-0002" },
          { "awesomeField": 42, "date": "2025-01-17T09:20:00Z", "id": "a1b2c3d4-0003" },
          { "awesomeField": 7,  "date": "2025-01-18T14:15:00Z", "id": "a1b2c3d4-0004" },
          { "awesomeField": 99, "date": "2025-01-19T16:30:00Z", "id": "a1b2c3d4-0005" },
          { "awesomeField": 33, "date": "2025-01-20T08:00:00Z", "id": "a1b2c3d4-0006" },
          { "awesomeField": 88, "date": "2025-01-21T22:10:00Z", "id": "a1b2c3d4-0007" },
          { "awesomeField": 12, "date": "2025-01-22T13:25:00Z", "id": "a1b2c3d4-0008" },
          { "awesomeField": 56, "date": "2025-01-23T19:40:00Z", "id": "a1b2c3d4-0009" },
          { "awesomeField": 71, "date": "2025-01-24T07:55:00Z", "id": "a1b2c3d4-0010" }
        ]
        """

    func get() -> AnyPublisher<[AwesomeData], FetchError> {
        
        let data = Data(jsonString.utf8)
        let decoder = JSONDecoder()
        
        decoder.dateDecodingStrategy = .iso8601
        
        return Just(data)
            .delay(for: .seconds(0.5), scheduler: DispatchQueue.global())
            .decode(type: [AwesomeData].self, decoder: decoder)
            .mapError { error -> FetchError in
                    switch error {
                    case let urlError as FetchError:
                        return .knownError(urlError.localizedDescription)
                    default:
                        return .unknown
                }
            }
            .eraseToAnyPublisher()
    }
}

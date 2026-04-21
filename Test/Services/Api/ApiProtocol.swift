//
//  ApiServiceProtocol.swift
//  Test
//
//  Created by Дмитрий Помин on 15.04.2026.
//

protocol ApiServiceProtocol: AnyObject {
    func getAwesomeData() -> AnyPublisher<[AwesomeData], FetchError>
}

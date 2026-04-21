//
//  ApiServiceProtocol.swift
//  Test
//
//  Created by Дмитрий Помин on 15.04.2026.
//
import Combine

protocol ApiProtocol {
    func get() -> AnyPublisher<[AwesomeData], FetchError>
}

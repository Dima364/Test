//
//  AwesomeServiceProtocol.swift
//  Test
//
//  Created by Дмитрий Помин on 14.04.2026.
//

import Combine

protocol AwesomeServiceProtocol: AnyObject {
    func getAwesomeData() -> AnyPublisher<[AwesomeData], Error>
}

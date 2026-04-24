//
//  AwesomeViewModelProtocol.swift
//  Test
//
//  Created by Дмитрий Помин on 15.04.2026.
//
import Combine

protocol AwesomeViewModelProtocol: AnyObject {
    var minDateItem: AwesomeData? { get }
    var isLoading: Bool { get }
    var isLoadingPublisher: AnyPublisher<Bool, Never> { get }

    func minElement()
    func startTimer()
    func stopTimer()
}

//
//  AwesomeViewModelImpl.swift
//  Test
//
//  Created by Дмитрий Помин on 15.04.2026.
//

import Combine
import Foundation


final class AwesomeViewModelImpl: AwesomeViewModelProtocol, ObservableObject {
    @Published var isLoading: Bool = false
    var isLoadingPublisher: AnyPublisher<Bool, Never> { $isLoading.eraseToAnyPublisher() }
    
    let awesomeSetActor = AwesomeSetActor()
    var errorMessage: String?
    var minDateItem: AwesomeData?
    
    private let apiService: ApiProtocol
    private var cancellables: Set<AnyCancellable> = []
    private var timerCancellable: AnyCancellable?
    
    init(apiService: ApiProtocol) {
        self.apiService = apiService
    }
    
    private func loadData() {
        isLoading = true
        errorMessage = nil
        minDateItem = nil
        
        apiService.get()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoading = false
                switch completion {
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                case .finished:
                    break
                }
            } receiveValue: { [weak self] awesomeData in
                Task {
                    await self?.awesomeSetActor.insert(data: awesomeData)
                }
            }.store(in: &cancellables)
    }
    
    func minElement() async {
        minDateItem = await awesomeSetActor.min()
        print(minDateItem ?? "no data")
    }
    
    func startTimer() {
        stopTimer()
        
        timerCancellable = Timer.publish(every: 1.0, on: .main, in: .common)
                            .autoconnect()
            .sink { [weak self] _ in
                self?.loadData()
            }
    }
    
    func stopTimer() {
        timerCancellable?.cancel()
        timerCancellable = nil
    }
}

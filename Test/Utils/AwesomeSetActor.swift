//
//  AwesomeActorStorage.swift
//  Test
//
//  Created by Дмитрий Помин on 24.04.2026.
//

actor AwesomeSetActor {
    private var awesomeSet: Set<AwesomeData> = []
    
    func insert(data: [AwesomeData]){
        for awesomeItem in data {
            awesomeSet.insert(awesomeItem)
        }
    }
    
    func min() -> AwesomeData? {
        return awesomeSet.min(by: { $0.date < $1.date })
    }
}

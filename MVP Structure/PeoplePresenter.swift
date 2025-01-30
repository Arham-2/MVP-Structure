//
//  PeoplePresenter.swift
//  MVP Structure
//
//  Created by Arham MAC on 30/01/2025.
//

import Foundation

protocol PeopleView: AnyObject {
    func showPeople(people: [Person])
    func showError(error: Error)
}

class PeoplePresenter {
    private var apiService: APIService
    
    private weak var delegate: PeopleView?
    
    init(delegate: PeopleView, apiService: APIService = APIService()) {
        self.delegate = delegate
        self.apiService = apiService
    }
    func fetchPeopleData() {
        apiService.fetchPeople { [weak self] result in
            switch result {
            case .success(let people):
                self?.delegate?.showPeople(people: people)
            case .failure(let error):
                self?.delegate?.showError(error: error)
            }
        }
    }
}

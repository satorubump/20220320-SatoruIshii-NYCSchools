//
//  NYCSchoolsViewModel.swift
//  20220320-SatoruIshii-NYXSchools
//
//  Created by Satoru Ishii on 3/20/22.
//

import SwiftUI
import Combine

/// View Model for getting Schools
class NYCSchoolsViewModel : ObservableObject {
    @Published var nycSchoolsResponse : [NYCSchoolsResponse]?

    let nycSchoolsFetcher = NYCSchoolsFetcher()
    private var disposables = Set<AnyCancellable>()
    
    /// Get the Schools Data from NYC Schools API
    func getNYCSchools() {
        /// Call the API fetcher & receive the subscrib from data publisher
        nycSchoolsFetcher.nycSchools()
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] value in
                    guard let self = self else { print("sink guard nil"); return }
                    switch value {
                    case .failure:
                        self.nycSchoolsResponse = nil
                        do {
                            try self.getNYCSchoolsFailure()
                        } catch {
                            print("getNYCSchools Failure")
                        }
                    case .finished:
                        /// print("sink finished")
                        break
                    }
                },
                receiveValue: { [weak self] nycSchoolsResponses in
                    /// getting API responses
                    self!.nycSchoolsResponse = nycSchoolsResponses
                })
            .store(in: &disposables)
    }
    
    func getNYCSchoolsFailure() throws -> Void {
        throw NYCSchoolsError.getNYCSchoolsFailure
    }
}

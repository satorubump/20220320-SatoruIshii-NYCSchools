//
//  SATResultsViewModel.swift
//  20220320-SatoruIshii-NYXSchools
//
//  Created by Satoru Ishii on 3/20/22.
//

import SwiftUI
import Combine
import MapKit

/// SAT Results View Model
class SATResultsViewModel : ObservableObject {
    /// SAT Results API Response Data
    @Published var satResultsResponse : [SATResultsResponse]?
    
    let satResultsFetcher = SATResultsFetcher()
    private var disposables = Set<AnyCancellable>()

    /// Subscribe SATResults API Response
    func getSATResults(dbn: String) -> Void {
        /// Call the API Fetcher
        satResultsFetcher.satResults(dbn: dbn)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] value in
                    guard let self = self else { print("sink guard nil"); return }
                    switch value {
                    case .failure:
                        self.satResultsResponse = nil
                        do {
                            try self.getSATResultsFailure()
                        } catch {
                            print("getSATResults Failure")
                        }
                    case .finished:
                        /// print("sink finished")
                        break
                    }
                },
                receiveValue: { [weak self] satResultsResponses in
                    /// Receive the API Response
                    self!.satResultsResponse = satResultsResponses
                    /// print("receiveValue")
                })
            .store(in: &disposables)
    }
    
    func getCoordinate(location: String) -> CLLocationCoordinate2D? {
        var s = ""
        var isIn = false
        for c in location {
            if c == "(" {
                isIn = true
                continue
            }
            else if c == ")" {
                isIn = false
                continue
            }
            if isIn {
                s += String(c)
            }
        }
        let arc = s.components(separatedBy: ", ")
        let coordinate = CLLocationCoordinate2DMake(Double(arc[0])!, Double(arc[1])!)
        return coordinate
    }

    func getAddress(location: String) -> String {
        var n = 0
        for c in location {
            if c == "(" {
                break
            }
            n += 1
        }
        let address = String(location.prefix(n))
        return address
    }

    func getSATResultsFailure() throws -> Void {
        throw NYCSchoolsError.getSATResultsFailure
    }
}

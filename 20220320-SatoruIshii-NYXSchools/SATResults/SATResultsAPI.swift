//
//  SATResultsAPI.swift
//  20220320-SatoruIshii-NYXSchools
//
//  Created by Satoru Ishii on 3/20/22.
//

import Foundation
import Combine

/// Fetcher's result publishing protocol
protocol SATResultsConnectoable {
    func satResults(dbn: String) -> AnyPublisher<[SATResultsResponse], APIError>
}

/// The Fetch the SATResults data from SAT Results API
class SATResultsFetcher : SATResultsConnectoable {
    /// Fetch SAT Results API Response data
    func satResults(dbn: String) -> AnyPublisher<[SATResultsResponse], APIError> {
        let urlComponents = self.makeSATResultsRequestUrl(dbn: dbn)
        return satPublishConnector(urlComponents: urlComponents)
    }
    
    /// Create the SAT Results API Request Url
    private func makeSATResultsRequestUrl(dbn: String) -> URLComponents {
        var urlComp = URLComponents()
        urlComp.scheme = Constants.Scheme
        urlComp.host = Constants.Host
        urlComp.path = Constants.Path + Constants.SATResultsReq
        urlComp.queryItems = [
            URLQueryItem(name: Constants.DBN, value: dbn)
        ]
        return urlComp
    }
    
    /// Fetch the SAT Results API and Publish the response data
    private func satPublishConnector(urlComponents components: URLComponents) -> AnyPublisher<[SATResultsResponse], APIError> {
        guard let url = components.url else {
            let error = APIError.network(description: "Can't create URL")
            return Fail(error: error).eraseToAnyPublisher()
        }
        return URLSession.shared.dataTaskPublisher(for: URLRequest(url: url))
          .mapError { error in
            .network(description: error.localizedDescription)
          }
            .print()
          .flatMap(maxPublishers: .max(1)) { pair in
                self.decode(pair.data)
          }
          .eraseToAnyPublisher()
    }
    
    /// Decode json data to SATReuslts API Response Struct Data with JSONDecoder
    private func decode(_ data: Data) -> AnyPublisher<[SATResultsResponse], APIError> {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970

        return Just(data)
          .decode(type: [SATResultsResponse].self, decoder: decoder)
          .print()
          .mapError { error in
            .decoding(description: error.localizedDescription)
          }
          .eraseToAnyPublisher()
    }
}

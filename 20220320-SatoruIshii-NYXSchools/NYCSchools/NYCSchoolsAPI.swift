//
//  NYCSchoolsAPI.swift
//  20220320-SatoruIshii-NYXSchools
//
//  Created by Satoru Ishii on 3/20/22.
//

import Foundation
import Combine

enum APIError: Error {
    case network(description: String)
    case decoding(description: String)
}

/// Protocol for NYC Schools API Publisher's Response
protocol NYCSchoolsConnectorable {
    func nycSchools() -> AnyPublisher<[NYCSchoolsResponse], APIError>
}

/// The API Fetcher for The NYC Schools Service
class NYCSchoolsFetcher : NYCSchoolsConnectorable {
    /// Get Now_PlayingResponse data
    func nycSchools() -> AnyPublisher<[NYCSchoolsResponse], APIError> {
        let urlComponents = self.makeNYCSchoolsRequestUrl()
        return fetchAPIPublisher(urlComponents: urlComponents)
    }
    
    /// Create the NYC Schools request url
    private func makeNYCSchoolsRequestUrl() -> URLComponents {
        var urlComp = URLComponents()
        urlComp.scheme = Constants.Scheme
        urlComp.host = Constants.Host
        urlComp.path = Constants.Path + Constants.NYCSchoolsReq
        return urlComp
    }
    
    /// Fetch the API and Publish the data
    private func fetchAPIPublisher(urlComponents components: URLComponents) -> AnyPublisher<[NYCSchoolsResponse], APIError> {
        guard let url = components.url else {
            let error = APIError.network(description: "Can't create URL")
            return Fail(error: error).eraseToAnyPublisher()
        }
        /// Fetching and Publishing
        return URLSession.shared.dataTaskPublisher(for: URLRequest(url: url))
          .mapError { error in
            .network(description: error.localizedDescription)
          }
          .flatMap(maxPublishers: .max(1)) { pair in
                self.decode(pair.data)
          }
          .eraseToAnyPublisher()
    }
    
    /// Decode API Response Json data to codable struct data
    private func decode(_ data: Data) -> AnyPublisher<[NYCSchoolsResponse], APIError> {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        return Just(data)
          .decode(type: [NYCSchoolsResponse].self, decoder: decoder)
          .mapError { error in
            .decoding(description: error.localizedDescription)
          }
          .eraseToAnyPublisher()
    }
}

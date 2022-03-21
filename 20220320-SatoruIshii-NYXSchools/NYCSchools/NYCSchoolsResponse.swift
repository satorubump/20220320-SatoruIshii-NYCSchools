//
//  NYCSchoolsResponse.swift
//  20220320-SatoruIshii-NYXSchools
//
//  Created by Satoru Ishii on 3/20/22.
//

/// for NYC Schools API Response Data
struct NYCSchoolsResponse : Codable {
        let dbn : String
        let school_name : String
        let location : String
        let phone_number : String
        let website : String
        let total_students : String
        
        enum CodingKeys : String, CodingKey {
            case dbn
            case school_name
            case location
            case phone_number
            case website
            case total_students
        }
}

//
//  SATResultsResponse.swift
//  20220320-SatoruIshii-NYXSchools
//
//  Created by Satoru Ishii on 3/20/22.
//

struct SATResultsResponse : Codable {
    
    let dbn : String
    let school_name : String
    let num_of_sat_test_takers : String
    let sat_critical_reading_avg_score : String
    let sat_math_avg_score : String
    let sat_writing_avg_score : String
    
    enum CodingKeys : String, CodingKey {
        case dbn
        case school_name
        case num_of_sat_test_takers
        case sat_critical_reading_avg_score
        case sat_math_avg_score
        case sat_writing_avg_score
    }
}

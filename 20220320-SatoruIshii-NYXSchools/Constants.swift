//
//  Constants.swift
//  20220320-SatoruIshii-NYXSchools
//
//  Created by Satoru Ishii on 3/20/22.
//

import Foundation
import SwiftUI

struct Constants {
    /// URL Request
    static let Scheme = "https"
    static let Host = "data.cityofnewyork.us"
    static let Path = "/resource"
    static let NYCSchoolsReq = "/s3k6-pzi2.json"
    static let SATResultsReq = "/f9bf-2cp4.json"
    static let DBN = "dbn"
    
    /// Labels
    static let SCHOOLS_LIST_LABEL = "NYC School Directory"
    static let SAT_RESULTS_LABEL = "SAT Results"

    static let TestTakersLabel = "Num of SAT Test Takers"
    static let ReadingScoreLabel = "SAT Critical Reading AVG.Score"
    static let MathScoreLabel = "SAT Math AVG.Score"
    static let WritingScoreLabel = "SAT Writing AVG.Score"
    
    static let LocationLabel = "Location: "
    static let PhoneLabel = "Phone: "
    static let WebsiteLabel = "Website: "
    static let StudentsLabel = "Students Number: "
    
    /// Size Parameters
    static let Span = 0.1
    static let BodyFont : CGFloat = 18.0
    static let PropertyFont = 15.0
    static let MapHeight : CGFloat = 200.0
}

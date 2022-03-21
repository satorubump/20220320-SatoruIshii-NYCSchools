//
//  NYCSchoolsError.swift
//  20220320-SatoruIshii-NYXSchools
//
//  Created by Satoru Ishii on 3/20/22.
//

import Foundation

/// for Combine Subscribe Failure Throws in NYCSchoolsViewModel, SATResultsViewModel
public enum NYCSchoolsError : Error {
    case getNYCSchoolsFailure
    case getSATResultsFailure
}

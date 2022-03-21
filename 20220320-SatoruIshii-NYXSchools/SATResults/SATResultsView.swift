//
//  SATResultsView.swift
//  20220320-SatoruIshii-NYXSchools
//
//  Created by Satoru Ishii on 3/20/22.
//

import SwiftUI

/// Display all the SAT scores  - include Math, Reading and Writing
struct SATResultsView: View {
    /// View model for fetch and observable SAT data
    @ObservedObject var viewModel = SATResultsViewModel()
    /// Responsed SAT Data
    var school : NYCSchoolsResponse
    
    init(school: NYCSchoolsResponse) {
        self.school = school
    }
    var body: some View {
        VStack {
            if self.viewModel.satResultsResponse != nil && self.viewModel.satResultsResponse!.count > 0 {
                satScoresSection
            }
            else {
                Text("SAT Results is n/a")
            }
            mapSection
            schoolPropertySection
            Spacer()
        }
        .lineSpacing(0)
        .background(Color.white)
        .navigationBarTitle(school.school_name, displayMode: .inline)
        .onAppear {
            self.viewModel.getSATResults(dbn: self.school.dbn)
        }
        .padding(0)
    }
}

private extension SATResultsView {

    /// Display SAT Results Data
    var satScoresSection : some View {
        Section {
            VStack {
            List {
                HStack {
                    Text(Constants.TestTakersLabel)
                    Text(viewModel.satResultsResponse![0].num_of_sat_test_takers)
                        .foregroundColor(Color.black)
                }
                HStack {
                    Text(Constants.ReadingScoreLabel)
                    Text(viewModel.satResultsResponse![0].sat_critical_reading_avg_score)
                        .foregroundColor(Color.black)
                }
                HStack {
                    Text(Constants.MathScoreLabel)
                    Text(viewModel.satResultsResponse![0].sat_math_avg_score)
                        .foregroundColor(Color.black)
                }
                HStack {
                    Text(Constants.WritingScoreLabel)
                    Text(viewModel.satResultsResponse![0].sat_writing_avg_score)
                        .foregroundColor(Color.black)
                }
            }
            Spacer()
            }
            .foregroundColor(Color.gray)
            .font(.system(size: Constants.BodyFont))
        }
    }

    /// Display School Location on Map
    var mapSection : some View {
        MapView(coord: viewModel.getCoordinate(location: school.location)!)
            .frame(height: Constants.MapHeight)
            .padding(0)
    }

    /// Display School Properties
    var schoolPropertySection : some View {
        Section {
            List {
                HStack(alignment: .top) {
                    Text(Constants.LocationLabel)
                    Text(viewModel.getAddress(location: school.location))
                }
                HStack {
                    Text(Constants.PhoneLabel)
                    Text(school.phone_number)
                }
                HStack(alignment: .top) {
                    Text(Constants.WebsiteLabel)
                    Text(school.website)
                }
                HStack {
                    Text(Constants.StudentsLabel)
                    Text(school.total_students)
                        .foregroundColor(Color.black)
                }
            }
            .lineSpacing(0)
            .foregroundColor(Color.gray)
            .font(.system(size: Constants.PropertyFont))
        }
        .padding(0)
        .background(Color.white)
    }
}

//
//  NYCSchoolsView.swift
//  20220320-SatoruIshii-NYXSchools
//
//  Created by Satoru Ishii on 3/20/22.
//

import SwiftUI

/// Display a list of NYC High Schools.
struct NYCSchoolsView: View {
    /// View Model for getting NYC Schools
    @ObservedObject var viewModel : NYCSchoolsViewModel

    init(viewModel: NYCSchoolsViewModel) {
        self.viewModel = viewModel
        // Fetch the High schools data via Combine
        viewModel.getNYCSchools()
    }
    var body: some View {
        NavigationView {
            VStack {
                List {
                    /// Display each school line
                    schoolsListSection
                }
                Spacer()
            }
            .navigationBarTitle(Constants.SCHOOLS_LIST_LABEL, displayMode: .inline)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

private extension NYCSchoolsView {
    var schoolsListSection : some View {
        Section {
            if self.viewModel.nycSchoolsResponse != nil {
                ForEach(self.viewModel.nycSchoolsResponse!, id: \.dbn) { school in
                    NavigationLink(destination: SATResultsView(school: school)) {
                        HStack {
                            Text(school.school_name)
                                .foregroundColor(Color.gray)
                                .font(.system(size: Constants.BodyFont))
                        }
                    }
                }
            }
        }
    }
}

struct NYCScoolsView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = NYCSchoolsViewModel()
        NYCSchoolsView(viewModel: viewModel)
    }
}

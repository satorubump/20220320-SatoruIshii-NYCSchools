//
//  _0220320_SatoruIshii_NYXSchoolsApp.swift
//  20220320-SatoruIshii-NYXSchools
//
//  Created by Satoru Ishii on 3/20/22.
//

import SwiftUI

@main
struct _0220320_SatoruIshii_NYXSchoolsApp: App {
    var body: some Scene {
        WindowGroup {
            let viewModel = NYCSchoolsViewModel()
            NYCSchoolsView(viewModel: viewModel)
        }
    }
}

//
//  MapView.swift
//  20220320-SatoruIshii-NYXSchools
//
//  Created by Satoru Ishii on 3/20/22.
//

import SwiftUI
import MapKit

/// MapView for Display the School Location with UIViewRepresentable
struct MapView: UIViewRepresentable {
  private let coordinate: CLLocationCoordinate2D
  
    init(coord: CLLocationCoordinate2D) {
        self.coordinate = coord
    }
  
  func makeUIView(context: Context) -> MKMapView {
      MKMapView()
  }
  
  func updateUIView(_ view: MKMapView, context: Context) {
      let span = MKCoordinateSpan(latitudeDelta: Constants.Span, longitudeDelta: Constants.Span)
      let region = MKCoordinateRegion(center: coordinate, span: span)
      
      let annotation = MKPointAnnotation()
      annotation.coordinate = coordinate
      view.addAnnotation(annotation)
      view.setRegion(region, animated: true)
      view.isScrollEnabled = true
      view.isZoomEnabled = true
      view.backgroundColor = UIColor.gray
  }
}

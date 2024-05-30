//
//  MapViewController.swift
//  SeSac_0524_TravelMagazine
//
//  Created by gnksbm on 5/30/24.
//

import UIKit
import MapKit

final class MapViewController: UIViewController {
    private let list = RestaurantList().restaurantArray
    private lazy var filteredList = list
    private let defaultDistance: Double = 500
    
    private lazy var mapView = {
        let mapView = MKMapView()
        mapView.region = MKCoordinateRegion(
            center: list.getCenterPoint(),
            latitudinalMeters: defaultDistance,
            longitudinalMeters: defaultDistance
        )
        let annotations = list.map { makePointAnnotation(data: $0) }
        mapView.addAnnotations(annotations)
        mapView.delegate = self
        return mapView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLayout()
        configureNavigation()
    }
    
    func moveToRestaurant(data: Restaurant) {
        move(to: data.location)
    }
    
    private func move(to: CLLocationCoordinate2D) {
        mapView.setRegion(
            MKCoordinateRegion(
                center: to,
                latitudinalMeters: defaultDistance,
                longitudinalMeters: defaultDistance
            ),
            animated: true
        )
    }
    
    private func configureNavigation() {
        navigationItem.rightBarButtonItem = makeFilterMenuButton(
            originalList: list,
            filteredHandler: { [self] result in
                let titleList = result.map { $0.name }
                showActionSheet(
                    titleList: titleList,
                    handler: { [self] selected in
                        if let data = result.first(
                            where: { $0.name == selected }
                        ) {
                            moveToRestaurant(data: data)
                            mapView.removeAnnotations(
                                mapView.annotations.filter {
                                    $0.coordinate != data.location
                                }
                            )
                        }
                    }
                )
                filteredList = result
            },
            unfilteredHandler: { [self] list in
                let registerdLocation = mapView.annotations.map { $0.coordinate }
                mapView.addAnnotations(
                    list.removeDuplicate(with: registerdLocation)
                        .map { makePointAnnotation(data: $0) }
                )
            }
        )
    }
    
    private func configureLayout() {
        view.backgroundColor = .white
        [mapView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
        ])
    }
    
    private func makePointAnnotation(data: Restaurant) -> MKAnnotation {
        let point = MKPointAnnotation()
        point.title = data.name
        point.coordinate = data.location
        return point
    }
}

extension MapViewController: MKMapViewDelegate {
    func mapView(
        _ mapView: MKMapView,
        didSelect annotation: any MKAnnotation
    ) {
        move(to: annotation.coordinate)
        print(mapView.annotations.count)
    }
}

//
//  MapViewController.swift
//  SeSac_0524_TravelMagazine
//
//  Created by gnksbm on 5/30/24.
//

import UIKit
import MapKit
import CoreLocation

final class MapViewController: UIViewController {
    private let list = RestaurantList().restaurantArray
    private lazy var filteredList = list
    private let defaultDistance: Double = 500
    
    private lazy var locationManager = {
        let locationManager = CLLocationManager()
        locationManager.delegate = self
        return locationManager
    }()
    
    private lazy var locationButton = {
        let button = UIButton(configuration: .filled())
        button.configuration?.image = UIImage(systemName: "mappin.and.ellipse")
        button.configuration?.baseForegroundColor = .systemBackground
        button.addTarget(
            self,
            action: #selector(locationButtonTapped),
            for: .touchUpInside
        )
        return button
    }()
    
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
        view.backgroundColor = .systemBackground
        [mapView, locationButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            
            locationButton.leadingAnchor.constraint(
                equalTo: mapView.leadingAnchor,
                constant: 40
            ),
            locationButton.bottomAnchor.constraint(
                equalTo: mapView.bottomAnchor,
                constant: -40
            ),
            locationButton.widthAnchor.constraint(
                equalTo: locationButton.heightAnchor
            )
        ])
    }
    
    private func makePointAnnotation(data: Restaurant) -> MKAnnotation {
        let point = MKPointAnnotation()
        point.title = data.name
        point.coordinate = data.location
        return point
    }
    
    private func requestLocationAuthorization() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
    
    private func checkStatus() {
        let status = if #available(iOS 14, *) {
            locationManager.authorizationStatus
        } else {
            CLLocationManager.authorizationStatus()
        }
        switch status {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted, .denied:
            showAlert()
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.requestLocation()
        @unknown default:
            break
        }
    }
    
    private func showAlert() {
        let alertController = UIAlertController(
            title: "위치정보 권한이 없습니다.",
            message: "주변 음식점 정보를 확인하기 위해 권한을 변경해주세요.",
            preferredStyle: .alert
        )
        let moveToSetting = UIAlertAction(
            title: "권한 변경하러 가기",
            style: .destructive) { _ in
                if let url = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(url)
                }
            }
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        alertController.addAction(moveToSetting)
        alertController.addAction(cancel)
        present(alertController, animated: true)
    }
    
    @objc private func locationButtonTapped() {
        requestLocationAuthorization()
    }
}

extension MapViewController: CLLocationManagerDelegate {
    func locationManager(
        _ manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]
    ) {
        guard let location = locations.first else { return }
        mapView.setRegion(
            MKCoordinateRegion(
                center: location.coordinate,
                latitudinalMeters: defaultDistance,
                longitudinalMeters: defaultDistance
            ),
            animated: true
        )
    }
    
    func locationManager(
        _ manager: CLLocationManager,
        didFailWithError error: any Error
    ) {
        checkStatus()
    }
}

extension MapViewController: MKMapViewDelegate {
    func mapView(
        _ mapView: MKMapView,
        didSelect annotation: any MKAnnotation
    ) {
        move(to: annotation.coordinate)
    }
}

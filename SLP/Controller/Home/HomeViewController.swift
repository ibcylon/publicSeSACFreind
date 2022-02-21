//
//  HomeViewController.swift
//  SLP
//
//  Created by Kanghos on 2022/02/15.
//

import UIKit
import CoreLocation
import MapKit

import RxSwift

final class HomeViewController: UIViewController, AlertDisplaying {
    
    let mainView = HomeView()
    var viewModel = HomeViewModel.shared
    var disposeBag = DisposeBag()
    
    // Location
    let locationManager = CLLocationManager()
    var myLocation: CLLocation!
    let sesacCampusCoordinate = CLLocationCoordinate2D(latitude: 37.517819364682694, longitude: 126.88647317074734)
    
    var manAnnotations: [CustomAnnotation] = []
    var womanAnnotations: [CustomAnnotation] = []

    override func loadView() {
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true
        
        locationSetting()

        bind()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkStatus()
        searchNearFriends()
    }
    func bind() {
        mainView.myLocationButton.addTarget(self, action: #selector(myLocationButtonClicked), for: .touchUpInside)
        mainView.floatingButton.addTarget(self, action: #selector(floatingButtonClicked), for: .touchUpInside)
        [mainView.searchAllButton, mainView.searchMaleButton, mainView.searchFemaleButton].forEach {
            $0.addTarget(self, action: #selector(genderButtonClicked), for: .touchUpInside)
        }
        viewModel.status.bind { status in
            self.mainView.floatingButton.setImage(UIImage(named: status.image), for: .normal)
        }.disposed(by: disposeBag)
    }

    func locationSetting() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()

        locationManager.startUpdatingHeading()
        locationManager.startMonitoringSignificantLocationChanges()
        myLocation = locationManager.location

        self.mainView.mapView.setRegion(
            MKCoordinateRegion(center: sesacCampusCoordinate, span:
                                MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)),
            animated: true)
        self.mainView.mapView.delegate = self
        self.mainView.mapView.register(
            CustomAnnotationView.self,
            forAnnotationViewWithReuseIdentifier: CustomAnnotationView.identifier)
    }

    func checkStatus() {
        
        viewModel.status.accept(MatchingStatus(rawValue: UserDefaults.standard.integer(forKey: "status"))!)
    }
    
    @objc func genderButtonClicked(sender: GreenButton) {
        self.mainView.searchMaleButton.isSelected = false
        self.mainView.searchFemaleButton.isSelected = false
        self.mainView.searchAllButton.isSelected = false
        
        sender.isSelected = true
        viewModel.selectedGender.accept(Gender(rawValue: sender.tag)!)
        
        searchNearFriends()
        
    }
    @objc func floatingButtonClicked() {
        checkUserLocationServiceAuthorization()
        
        if viewModel.isLocationEnable.value == false { return }
        if (try? viewModel.user.value().gender == Gender.none.rawValue) != nil {
            view.makeToast("새싹 찾기 기능을 이용하기 위해서는 성별 설정이 필요해요!")
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.present(MyPageDetailViewController(), animated: true, completion: nil)
            }
        } else {
            let viewController = MainViewController()
            viewController.modalPresentationStyle = .fullScreen
            self.present(viewController, animated: true, completion: nil)
        }
    }
    
    @objc func myLocationButtonClicked() {
        if CLLocationManager.locationServicesEnabled() {
            switch locationManager.authorizationStatus {
                
            case .notDetermined, .restricted, .denied:
                locationManager.requestWhenInUseAuthorization()
                presentSetting()
                return
            case .authorizedAlways, .authorizedWhenInUse:
                mainView.mapView.showsUserLocation = true
                mainView.mapView.setUserTrackingMode(.follow, animated: true)
            @unknown default:
                print("Unknown error")
            }
        } else {
            print("Location service is not enabled")
        }
    }

    func searchNearFriends() {
        let onQueueDTO = OnQueueDTO(
            region: viewModel.region.value,
            lat: viewModel.latitude.value,
            long: viewModel.longitude.value
        )
//        viewModel.searchNearFriends(onQueueDTO: onQueueDTO) {  result, statusCode, error in
//
//            switch statusCode {
//            case 200: break
//            case 401: break
//            case 406, 500, 501:
//                self.mainView.makeToast("잠시 후 다시 ")
//            default: break
//            }
//        }
    }
}

extension HomeViewController: CLLocationManagerDelegate {

    func checkUserLocationServiceAuthorization() {
        let authorizationStatus: CLAuthorizationStatus
        
        if #available(iOS 14.0, *) {
            authorizationStatus = locationManager.authorizationStatus
        } else {
            authorizationStatus = CLLocationManager.authorizationStatus()
        }
        // iOS 위치 서비스 확인
        if CLLocationManager.locationServicesEnabled() {
            // 권한 상태 확인 및 권한 요청 가능(8번 메서드 실행)
            checkCurrentLocationAuthorization(authorizationStatus)
        } else {
            view.makeToast("iOS 위치 서비스를 켜주세요")
        }
    }
    func checkCurrentLocationAuthorization(_ authorizationStatus: CLAuthorizationStatus) {
        switch authorizationStatus {
        case .notDetermined:
            print("notDetermined")
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation() // 위치 접근 시작! -> didUpdateLocations 실행
        case .restricted, .denied:
            print("LocationDisable")
            viewModel.isLocationEnable.accept(false)
            viewModel.calculateRegion(
                latitude: sesacCampusCoordinate.latitude,
                longitude: sesacCampusCoordinate.longitude
            )
            presentSetting()
        case .authorizedAlways, .authorizedWhenInUse:
            print("LocationEnable")
            viewModel.isLocationEnable.accept(true)
            locationManager.startUpdatingLocation() // 위치 접근 시작! -> didUpdateLocations 실행
        @unknown default:
            print("unknown")
        }
        // 정확도 체크 : 정확도 감소가 되어있을 경우, 1시간에 4번으로 제한, 미리 알림등이 제한, 배터리는 오래쓸수있음, 워치 7부터
        if #available(iOS 14.0, *) {
            let accuracyState = locationManager.accuracyAuthorization
            switch accuracyState {
            case .fullAccuracy:
                print("full")
            case .reducedAccuracy:
                print("reduced")
            @unknown default:
                print("Unknown")
            }
        }
    }
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkUserLocationServiceAuthorization()
    }
    // deprecated
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkUserLocationServiceAuthorization()
    }

    func checkUserLocationServicesAuthorization() {
        let authorizationStatus: CLAuthorizationStatus
        if #available(iOS 14, *) {
            authorizationStatus = locationManager.authorizationStatus
        } else {
            authorizationStatus = CLLocationManager.authorizationStatus()
        }
        if CLLocationManager.locationServicesEnabled() {
            checkCurrentLocationAuthorization(authorizationStatus)
            searchNearFriends()
        }
    }

    func presentSetting() {
        displayAlertWithAction(title: "위치 권한 요청", message: "위치 서비스 사용 불가") { _ in
            guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            }
        }
    }
}

extension HomeViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let customAnnotation = annotation as? CustomAnnotation else { return nil }
        guard let customAnnotationView = mainView.mapView.dequeueReusableAnnotationView(
            withIdentifier: CustomAnnotationView.identifier
        )
        else {
            return MKAnnotationView()
        }
        let sesacImage: UIImage!
        let size = CGSize(width: 85, height: 85)
        UIGraphicsBeginImageContext(size)
        let imageName = CustomAnnotationImage(rawValue: customAnnotation.sesac_image!)?.imageName
        sesacImage = UIImage(named: imageName!)
        sesacImage.draw(in: CGRect(origin: .zero, size: size))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        customAnnotationView.image = resizedImage
        return customAnnotationView
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }

        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude
        let center = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let region = MKCoordinateRegion(center: center, latitudinalMeters: 1000, longitudinalMeters: 1000)

        viewModel.calculateRegion(latitude: latitude, longitude: longitude)
        mainView.mapView.setRegion(region, animated: true)
    }
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        let latitude = mainView.mapView.centerCoordinate.latitude
        let longitude = mainView.mapView.centerCoordinate.longitude

        viewModel.calculateRegion(latitude: latitude, longitude: longitude)
        searchNearFriends()
    }
}

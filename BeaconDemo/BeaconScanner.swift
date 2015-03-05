import CoreLocation

class BeaconScanner: NSObject, CLLocationManagerDelegate {
    
    private let locationManager = CLLocationManager()
    private var onRanged: ([CLBeacon] -> Void)?
    
    private let uuid: String
    private let identifier: String
    
    init(uuid: String, identifier: String) {
        self.uuid = uuid
        self.identifier = identifier
        
        super.init()
        
        locationManager.delegate = self
    }
    
    func start(didRangeBeacons: ([CLBeacon]) -> Void) {
        onRanged = didRangeBeacons
        
        if CLLocationManager.authorizationStatus() != CLAuthorizationStatus.AuthorizedWhenInUse {
            locationManager.requestWhenInUseAuthorization()
        }

        var region = CLBeaconRegion(proximityUUID: NSUUID(UUIDString: uuid), identifier: identifier)
        locationManager.startRangingBeaconsInRegion(region)
    }
    
    func locationManager(manager: CLLocationManager!, didRangeBeacons beacons: [AnyObject]!, inRegion region: CLBeaconRegion!) {
        let knownBeacons = beacons
            .filter{ $0.proximity != CLProximity.Unknown }
            .map{ $0 as! CLBeacon }
        
        if (knownBeacons.count > 0) && (onRanged != nil) {
            onRanged!(knownBeacons)
        }
    }

    
}
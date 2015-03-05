import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    let scanner = BeaconScanner(uuid: "B9407F30-F5F8-466E-AFF9-25556B57FE6D", identifier: "Estimotes")

    let RED_ID: Int = 13345
    let GREEN_ID: Int = 22709
    let BLUE_ID: Int = 45465
    
    var red: CGFloat = 0
    var green: CGFloat = 0
    var blue: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scanner.start { (beacons: [CLBeacon]) -> Void in
            
            if let b = self.find(beacons, minorValue: self.RED_ID) {
                self.red = self.crunchRGBValue(b.rssi)
            }
            
            if let b = self.find(beacons, minorValue: self.GREEN_ID) {
                self.green = self.crunchRGBValue(b.rssi)
            }
            
            if let b = self.find(beacons, minorValue: self.BLUE_ID) {
                self.blue = self.crunchRGBValue(b.rssi)
            }
            
            self.view.backgroundColor = UIColor(red: self.red/255, green: self.green/255, blue: self.blue/255, alpha: 1)
        }
    }
    
    func find(beacons: [CLBeacon], minorValue: Int) -> CLBeacon? {
        return beacons.filter { $0.minor.integerValue == minorValue }.first
    }
    
    func crunchRGBValue(rssi: Int) -> CGFloat {
        var based = max(rssi + 100, 0)
        var stretched = min(based * 5, 255)
        
        return CGFloat(stretched)
    }
    
}


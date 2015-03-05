import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    let scanner = BeaconScanner(uuid: "B9407F30-F5F8-466E-AFF9-25556B57FE6D", identifier: "Estimotes")

    let colors = [
        13345: UIColor(red: 84/255, green: 77/255, blue: 160/255, alpha: 1),
        22709: UIColor(red: 142/255, green: 212/255, blue: 220/255, alpha: 1),
        45465: UIColor(red: 162/255, green: 213/255, blue: 181/255, alpha: 1)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scanner.start { (beacons: [CLBeacon]) -> Void in
            self.view.backgroundColor = self.colors[beacons[0].minor.integerValue]
        }
    }
    
}


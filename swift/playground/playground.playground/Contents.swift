import UIKit




var fuel: Int?
fuel = 20
fuel = nil

if let avalibleFuel = fuel {
    print ("ok")
} else {
    print("no data")
}
fuel = 10

func checkFuel () {
    guard let avalibleFuel = fuel else {
        print("no data")
        return
    }
    print("fuel \(fuel) litters left")
    
}

checkFuel()

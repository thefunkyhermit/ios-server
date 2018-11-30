import LoggerAPI
import Health
import KituraContracts
import Foundation
struct Dog: Codable {
    var name: String
    var owner: String
}

func initializeHealthRoutes(app: App) {
    
    app.router.get("/health") { (respondWith: (Status?, RequestError?) -> Void) -> Void in
        if health.status.state == .UP {
            respondWith(health.status, nil)
        } else {
            respondWith(nil, RequestError(.serviceUnavailable, body: health.status))
        }
    }
    
    app.router.get("/balls") { request, response, next in
//        if health.status.state == .UP {
//             respondWith(health.status, nil)
//        } else {
//            respondWith(nil, RequestError(.serviceUnavailable, body: health.status))
//        }
        let dog = Dog(name: "Rex", owner: "Etgar")
        let ralph = Dog(name: "Ralph", owner: "Etgar")
        let jsonEncoder = JSONEncoder()
        let jsonData = try jsonEncoder.encode(dog)
        let ralphData = try jsonEncoder.encode(ralph)
        let json = String(data: ralphData, encoding: String.Encoding.utf8)
        let rexjson = String(data: jsonData, encoding: String.Encoding.utf8)
//        let airports: [String: String] = ["YYZ": "Toronto Pearson", "DUB": "Dublin", "YYJ": "Victoria"]
        let dogs = ["ralph": json, "rex": rexjson]
        response.send(dogs)
    }
}

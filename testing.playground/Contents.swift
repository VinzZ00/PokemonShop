import UIKit


var apitUrl : URL {
    guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon")
    else {
        fatalError("API Host has failed to connect")
    }
    return url
}



print(apitUrl.lastPathComponent)
print(apitUrl.appending(queryItems: "limit=151")

print(apitUrl.appendingPathComponent("?limit=151"))

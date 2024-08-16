import Foundation

class SearchGame: ObservableObject {
    
    @Published var gameInfo = [Game]()
    
    func search(gameName:String)  {
        gameInfo.removeAll()
        let gameNameSpaces = gameName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let url = URL(string:"https://gamestreamapi.herokuapp.com/api/games/search?contains=\(gameNameSpaces ?? "cuphead")")!
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            do{
                if let jsonData = data {
                    print("tamaño del Json \(jsonData)")
                    let decodeData = try
                    JSONDecoder().decode(Results.self, from: jsonData)
                    DispatchQueue.main.async {
                        self.gameInfo.append(contentsOf:decodeData.results)
                    }
                }
            }catch{
                print("Error: \(error)")
            }
        }.resume()
    }
}

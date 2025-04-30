import SwiftUI
// manages player data using UserDefaults
class PlayerViewModel: ObservableObject {
    @Published var players: [Player] = []
    
    private let playersKey = "Players"
    
    // initialize viewModel
    init() {
        loadPlayers()
    }
    
    // adding new player and saving - used in GameOverView
    func addNewPlayer(player: Player) {
        players.append(player)
        savePlayers()
    }
    
    private func savePlayers() {
        if let encoded = try? JSONEncoder().encode(players) {
            UserDefaults.standard.set(encoded, forKey: playersKey)
        }
    }
    //loading players from UserDefaults
    private func loadPlayers() {
        if let data = UserDefaults.standard.data(forKey: playersKey),
           let decoded = try? JSONDecoder().decode([Player].self, from: data) { //decoding the players
            players = decoded
        } else {
            //adding some default players
            players = [
                Player(name: "Harsha", score: 10),
                Player(name: "Donald", score: 20),
                Player(name: "Mickey", score: 25)
            ]
        }
    }
}

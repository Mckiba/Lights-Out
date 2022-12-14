import Foundation

// MARK: - CastResult
struct CastResult: Codable, Hashable {
    let id: Int
    let cast: [Cast]
    let crew: [Cast]

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case cast = "cast"
        case crew = "crew"
    }
}

// MARK: - Cast
struct Cast: Codable, Hashable {
    let adult: Bool
    let gender: Int
    let id: Int
    let knownForDepartment: String
    let name: String
    let originalName: String
    let popularity: Double
    let profilePath: String?
    let character: String?
    let creditID: String
    let order: Int?
    let castID: Int?
    let department: String?
    let job: String?
    
    var profileURL: URL {
        let defaultURL = URL(string:"https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200")
        return URL(string: "https://image.tmdb.org/t/p/w500\(profilePath ?? "")") ?? defaultURL!
    }
    

    enum CodingKeys: String, CodingKey {
        case adult = "adult"
        case gender = "gender"
        case id = "id"
        case knownForDepartment = "known_for_department"
        case name = "name"
        case originalName = "original_name"
        case popularity = "popularity"
        case profilePath = "profile_path"
        case character = "character"
        case creditID = "credit_id"
        case order = "order"
        case castID = "cast_id"
        case department = "department"
        case job = "job"
    }
    
    
    static func loadJson() -> [Cast]? {
        let url = Bundle.main.url(forResource: "CastData", withExtension: "JSON")
        do {
            let data = try Data(contentsOf: url!)
            let decoder = JSONDecoder()
            let jsonData = try decoder.decode([Cast].self, from: data)
            return jsonData
        } catch {
            print("error:\(error)")
        }
        return nil
    }
}



import Foundation

struct Games:Codable {
    var games:[Game]
}

struct Results:Codable {
    var results:[Game]
}




struct Game:Codable, Hashable {
    var title:String
    var studio:String
    var contentRaiting:String
    var publicationYear:String
    var description:String
    var platforms:[String]
    var tags:[String]
    var videosUrls:videoUrl
    var galleryImages:[String]
}


struct videoUrl:Codable, Hashable {
    var mobile:String
    var tablet:String
}

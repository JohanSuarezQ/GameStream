import SwiftUI

struct GameScreenView: View {
    //MARK: Definicion para traer los datos desde el modelo
    @ObservedObject var allGames = ViewModel()
    //MARK: Variables definidas para el manejo de los datos que se traen
    @State var gameviewIsActive: Bool = false
    @State var url:String = ""
    @State var titulo:String = ""
    @State var studio:String = ""
    @State var calificacion: String = ""
    @State var anoPublicacion: String = ""
    @State var descripcion:String = ""
    @State var tags:[String] = [""]
    @State var imgsUrl: [String] = [""]
    
    let textLimit = 10 //Your limit
    
    let gridForm = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    //MARK: Lógica para mostrar los juegos en pantalla
    var body: some View {
        ZStack{
            Color("Marine").ignoresSafeArea()
            VStack{
                Text("Juegos")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(EdgeInsets(top: 16, leading: 0, bottom: 64, trailing: 0))
                
                ScrollView{
                    LazyVGrid(columns:gridForm,spacing:8){
                        ForEach(allGames.gamesInfo, id: \.self){
                            game in
                            Button(action: {
                                
                                url = game.videosUrls.mobile
                                titulo = game.title
                                studio = game.studio
                                calificacion = game.contentRaiting
                                anoPublicacion = game.publicationYear
                                descripcion = game.description
                                tags = game.tags
                                imgsUrl = game.galleryImages
                                print("Juego seleccionado: \(titulo)")
                                gameviewIsActive = true
                                
                            }, label: {
                                VStack{
//                                    Image("The Witcher")
//                                        .resizable()
//                                        .scaledToFill()
//                                    
//                                    Text("The witcher")
//                                        .foregroundColor(.white)
//                                        .font(.title3)
//                                        .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: .infinity, alignment: .leading)
//                                        .background(Color("Blue-Gray"))
//                                    Text("\(game.title)")
//                                        .foregroundColor(.white)
//                                        .truncationMode(.tail)
                                    AsyncImage(url: URL(string: game.galleryImages[0])){
                                        Image in
                                        Image.resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .padding(.bottom)
                                    } placeholder: {
                                        Text(game.title)
                                            .font(.caption)
                                    }
                                    Text("\(game.title)")
                                        .foregroundColor(.white)
                                        .font(.title3)
                                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                        .frame(maxHeight: 10)
                                        .padding(.bottom)
                                        
                                    
                                    
                                    //                                Text("\(game.title)")
                                    //                                AsyncImage(url: URL(string: game.galleryImages[0])!)
                                    
                                }
                                
                                //
                            })
                        }
                        
                    }
                }
            }.padding(.horizontal,20)
            
            
            NavigationLink( destination: SingleGameView(url: url, titulo: titulo, studio: studio, calificacion: calificacion, anoPublicacion: anoPublicacion, descripcion:descripcion , tags: tags, imgsUrl: imgsUrl),
                            isActive: $gameviewIsActive,
                            label: {
                EmptyView()
            })
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarBackButtonHidden(true)
        .onAppear(
            perform: {
                if !allGames.gamesInfo.isEmpty {
                    print("Primer juego completo \(allGames.gamesInfo[0])")
                    print("Primer título de juego \(allGames.gamesInfo[0].title)")
                } else {
                    print("No hay juegos disponibles.")
                }
            })
    }
}

#Preview {
    GameScreenView()
}

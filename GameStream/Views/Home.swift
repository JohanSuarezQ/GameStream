import SwiftUI
import AVKit

struct Home: View {
    @State var tabSelected: Int = 2
    var body: some View {
        TabView(selection: $tabSelected) {
            ProfileView()
                .tabItem {
                    Image(systemName: "person")
                        .foregroundColor(.pink)
                    Text("Perfil")
                }.tag(0)
            GameScreenView()
                .font(.system(size: 30, weight: .bold, design: .rounded))
                .tabItem {
                    Image(systemName: "gamecontroller")
                    Text("Juegos")
                }.tag(1)
            homeScreen()
                .font(.system(size: 30, weight: .bold, design: .rounded))
                .tabItem {
                    Image(systemName: "house")
                    Text("Inicio")
                }.tag(2)
            FavsView()
                .font(.system(size: 30, weight: .bold, design: .rounded))
                .tabItem {
                    Image(systemName: "heart")
                    Text("Favoritos")
                }.tag(3)
        }.accentColor(Color("Dark-Cian"))
    }
    
    init() {
        UITabBar.appearance().backgroundColor = UIColor(Color("TabBarColor"))
        UITabBar.appearance().unselectedItemTintColor = .lightGray
    }
}

struct homeScreen: View {
    
    var body: some View {
        ZStack {
            Color("Marine")
                .ignoresSafeArea()
            VStack {
                Image("AppLogo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 250)
                    .padding(.horizontal, 20)
                //MARK: BArra de búsqueda
                //Moviendo módulo para hacer dinámico
                
                //
                
                ScrollView(showsIndicators: false){
                    SubModuleHome()
                                    
                                }
            }.padding(20)
        }.navigationBarHidden(true).navigationBarBackButtonHidden(true)
        
    }
//    func textSearch (){
//        print("Texto de búsqueda \(searchOn)")
//    }
}

struct SubModuleHome: View {
    
        @State var searchOn = ""
    
        @State var isGameInfoEmpty = false
    
        @ObservedObject var gameFound = SearchGame()
        
        @State var isGameViewActive = false
    
        @State var url:String = ""
        @State var titulo:String = ""
        @State var studio:String = ""
        @State var calificacion: String = ""
        @State var anoPublicacion: String = ""
        @State var descripcion:String = ""
        @State var tags:[String] = [""]
        @State var imgsUrl: [String] = [""]
    
    
       
        var body: some View {
            VStack {
                
                HStack{
                    Button(action: {
                        watchGame(name: searchOn)
                    }, label: {
                        Image(systemName: "magnifyingglass")
                            .font(.system(size: 24))
                            .foregroundColor(searchOn.isEmpty ? Color(.yellow) : Color("Dark-Cian"))
                    }).alert(isPresented: $isGameInfoEmpty){
                        Alert(title: Text("Error"), 
                              message: Text("No se encontro el juego"),
                              dismissButton: .default(Text("Entendido")))
                    }
                                        
                    ZStack(alignment: .leading) {
                        if searchOn.isEmpty {
                            Text("Buscar un video")
                                .foregroundColor(.gray)
                                .font(.title2)
                        }
                        TextField("", text: $searchOn)
                            .foregroundColor(.white)
                    }
                }.padding([.top, .leading, .bottom], 10)
                    .background(Color("Blue-Gray"))
                    .clipShape(Capsule())
                
                //MARK: Sección 1
                Text("LOS MÁS POPULARES")
                    .font(.title3)
                    .foregroundColor(.white)
                    .bold()
                    .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: .infinity, alignment: .leading)
                    .padding(.top)
                
                ZStack{
                    Button(action: {
                        watchGame(name: "The Witcher")
                    }, label: {
                        VStack(spacing: 0) {
                            Image("TheWitcher")
                                .resizable()
                                .scaledToFill()
                            
                            Text("The witcher")
                                .foregroundColor(.white)
                                .font(.title3)
                                .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: .infinity, alignment: .leading)
                                .background(Color("Blue-Gray"))
                        }
                    })
                    Image(systemName: "play.circle.fill")
                        .resizable()
                        .foregroundColor(.white)
                        .frame(width: 42, height: 42)
                }.frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: .infinity, alignment: .center)
                    .padding(.vertical)
                //MARK: Sección 2
                Text("CATEGORÍAS SUGERIDAS PARA TI")
                    .font(.title3)
                    .foregroundColor(.white)
                    .bold()
                    .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: .infinity, alignment: .leading)
                
                ScrollView(.horizontal, showsIndicators: false){
                    HStack{
                        Button(action: {}, label: {
                            ZStack{
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(Color("Blue-Gray"))
                                    .frame(width: 160, height: 90)
                                
                                Image("FPS")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 42, height: 42)
                            }
                        })
                        Button(action: {}, label: {
                            ZStack{
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(Color("Blue-Gray"))
                                    .frame(width: 160, height: 90)
                                
                                Image("RPG")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 42, height: 42)
                            }
                        })
                        Button(action: {}, label: {
                            ZStack{
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(Color("Blue-Gray"))
                                    .frame(width: 160, height: 90)
                                
                                Image("OpenWorld")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 42, height: 42)
                            }
                        })
                    }
                    
                }
                //MARK: Sección 3
                Text("RECOMENDADOS PARA TI")
                    .font(.title3)
                    .foregroundColor(.white)
                    .bold()
                    .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: .infinity, alignment: .leading)
                    .padding(.top)
                
                ScrollView(.horizontal, showsIndicators: false){
                    HStack{
                        Button(action: {
                            watchGame(name: "Grand Theft Auto V")
                        }, label: {
                            AsyncImage(url: URL(string: "https://images.igdb.com/igdb/image/upload/t_cover_big/co66qs.webp")){
                                Image in
                                Image.resizable()
                                    .scaledToFit()
                                    .frame(width: 135, height: 240)
                                    .padding(.trailing)
                            } placeholder: {
                                Text("Grand Theft Auto V")
                            }
//                            Image("Spiderman")
//                                .resizable()
//                                .scaledToFit()
//                                .frame(width: 240, height: 135)
                        })
                        Button(action: {
                            watchGame(name: "Crash Bandicoot")
                        }, label: {
                            AsyncImage(url: URL(string: "https://images.igdb.com/igdb/image/upload/t_cover_big/co1v62.webp")){
                                Image in
                                Image.resizable()
                                    .scaledToFit()
                                    .frame(width: 135, height: 240)
                                    .padding(.trailing)
                            } placeholder: {
                                Text("Crash Bandicoot")
                            }
                        })
                        Button(action: {
                            watchGame(name: "Cuphead")
                        }, label: {
                            AsyncImage(url: URL(string: "https://images.igdb.com/igdb/image/upload/t_cover_big/co65ip.webp")){
                                Image in
                                Image.resizable()
                                    .scaledToFit()
                                    .frame(width: 135, height: 240)
                                    .padding(.trailing)
                            } placeholder: {
                                Text("Cuphead")
                            }
                        })
                    }
                }
                
                //MARK: Sección 4
                Text("VIDEOS QUE PODRÍAN GUSTARTE")
                    .font(.title3)
                    .foregroundColor(.white)
                    .bold()
                    .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: .infinity, alignment: .leading)
                    .padding(.top)
                
                ScrollView(.horizontal, showsIndicators: false){
                    HStack{
                        Button(action: {
                            watchGame(name: "Hades")
                        }, label: {
                            AsyncImage(url: URL(string: "https://cdn.cloudflare.steamstatic.com/steam/apps/1145360/ss_217b70678a2eea71a974fba1a4cd8baa660581bb.600x338.jpg")){
                                Image in
                                Image.resizable()
                                    .scaledToFit()
                                    .frame(width: 240, height: 135)
                                    .padding(.trailing)
                            } placeholder: {
                                Text("Hades")
                            }
                        })
                        Button(action: {
                            watchGame(name: "Abzu")
                        }, label: {
                            AsyncImage(url: URL(string: "https://cdn.cloudflare.steamstatic.com/steam/apps/384190/ss_b1038245a188f63c24a8112b7a36311e3d851935.600x338.jpg")){
                                Image in
                                Image.resizable()
                                    .scaledToFit()
                                    .frame(width: 240, height: 135)
                                    .padding(.trailing)
                            } placeholder: {
                                Text("Abzu")
                            }
                        })
                        Button(action: {
                            watchGame(name: "Halo")
                        }, label: {
                            AsyncImage(url: URL(string: "https://cdn.cloudflare.steamstatic.com/steam/apps/976730/ss_fdaf8ebd7f3c62e08398f39c9bfa486294ea5a0a.600x338.jpg?t=1617821242")){
                                Image in
                                Image.resizable()
                                    .scaledToFit()
                                    .frame(width: 240, height: 135)
                                    .padding(.trailing)
                            } placeholder: {
                                Text("Halo")
                            }
                        })
                    }
                }
                
            }
            NavigationLink(
                destination: SingleGameView(url: url, titulo: titulo, studio: studio, calificacion: calificacion, anoPublicacion: anoPublicacion, descripcion: descripcion, tags: tags, imgsUrl: imgsUrl),
                isActive: $isGameViewActive,
                label: {
                    EmptyView()
                }
            )
        }
    
    func watchGame (name: String) {
        gameFound.search(gameName: name)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.3){
            print("Cantidad E:\(gameFound.gameInfo.count)")
            
            if gameFound.gameInfo.count == 0 {
                isGameInfoEmpty = true
            } else {
                url = gameFound.gameInfo[0].videosUrls.mobile
                titulo = gameFound.gameInfo[0].title
                studio = gameFound.gameInfo[0].studio
                calificacion = gameFound.gameInfo[0].contentRaiting
                anoPublicacion = gameFound.gameInfo[0].publicationYear
                descripcion = gameFound.gameInfo[0].description
                tags = gameFound.gameInfo[0].tags
                imgsUrl = gameFound.gameInfo[0].galleryImages
                isGameViewActive = true
            }
        }
    }
}

#Preview {
    Home()
}

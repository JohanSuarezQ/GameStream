import SwiftUI
import AVKit

struct FavsView: View {
    @ObservedObject var allVideoGames = ViewModel()
    
    //    @State var isGameViewActive:Bool = false
    //    @State var url:String = ""
    //    @State var titulo:String = ""
    //    @State var studio:String = ""
    //    @State var calificacion:String = ""
    //    @State var anoPublicacion:String = ""
    //    @State var descripcion:String = ""
    //    @State var tags:[String] = [""]
    //    @State var imgsUrl:[String] = [""]
    var body: some View{
        ZStack{
            Color("Marine").ignoresSafeArea()
            VStack() {
                Text("FAVORITOS")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
                    .padding(.bottom, 9.0)
                
                ScrollView{
                    ForEach(allVideoGames.gamesInfo, id: \.self) { game in
                        VStack(spacing: 0){

                            VideoPlayer(player: AVPlayer(url: URL(string:  game.videosUrls.mobile)!))
                                .frame( height: 300)
                            
                            Text("\(game.title)").foregroundColor(Color.white)
                                .padding()
                                .frame( maxWidth: .infinity,alignment: .leading)
                                .background(Color("Blue-Gray"))
                                .clipShape(RoundedRectangle(cornerRadius: 3.0))
                        }
                    }
                }.padding(.bottom,8)
            }.padding(.horizontal,6)
        }.navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
    }
}


struct FavoritesView_Previews: PreviewProvider {
    
    @ObservedObject var todosLosVideojuegos = ViewModel()
    static var previews: some View {
        FavsView()
    }
}

#Preview {
    FavsView()
}

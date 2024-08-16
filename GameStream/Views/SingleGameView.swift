import SwiftUI
import AVKit

struct SingleGameView: View {
    
    var url:String
    var titulo:String
    var studio:String
    var calificacion: String
    var anoPublicacion: String
    var descripcion:String
    var tags:[String]
    var imgsUrl: [String]
    
    var body: some View {
        ZStack {
            Color("Marine").ignoresSafeArea()
            VStack {
                video(url: url)
                    .frame(height: 300)
                
                ScrollView {
                    //Informacion Video
                    videoInfo(titulo:titulo,studio:studio,calificacion:calificacion,anoPublicacion:anoPublicacion,descripcion:descripcion,tags:tags)
                        .padding(.bottom)
                    
                    Gallery(imgsUrl:imgsUrl)
                    Comments()
                }.frame(maxWidth: .infinity)
            }
        }
    }
}

struct video:View {
    
    var url:String
    
    var body: some View{
        VideoPlayer(player: AVPlayer(url: URL(string: url)!)).ignoresSafeArea()
    }
}

struct videoInfo:View {
    
    var titulo:String
    var studio:String
    var calificacion:String
    var anoPublicacion:String
    var descripcion:String
    var tags:[String]

    var body: some View{
        VStack(alignment:.leading ){
            Text("\(titulo)")
                .foregroundColor(.white)
                .font(.largeTitle)
                .padding(.leading)
            HStack{
                Text("\(studio)")
                    .foregroundColor(.white)
                    .font(.subheadline)
                    .padding(.top,5)
                    .padding(.leading)
                
                Text("\(calificacion)")
                    .foregroundColor(.white)
                    .font(.subheadline)
                    .padding(.top,5)
                
                Text("\(anoPublicacion)")
                    .foregroundColor(.white)
                    .font(.subheadline)
                    .padding(.top,5)
            }
            
            Text("\(descripcion)")
                .foregroundColor(.white)
                .font(.subheadline)
                .padding(.top,5)
                .padding(.leading)

            HStack{
                ForEach(tags, id:\.self){
                    tag in
                    Text("#\(tag)")
                        .foregroundColor(.white)
                        .font(.subheadline)
                        .padding(.top,4)
                        .padding(.leading)
                }
            }
        }.frame( maxWidth: .infinity,  alignment: .leading)
    }
}

struct Gallery:View {
    
    var imgsUrl:[String]
    let gridForm = [
        GridItem(.flexible())
    ]

    var body: some View{
        
        VStack(alignment: .leading ){
            
            Text("GALERÍA")
                .foregroundColor(.white)
                .font(.title)
                .padding(.leading)
            
            ScrollView(.horizontal){
                LazyHGrid(rows:gridForm,spacing:8){
                    ForEach(imgsUrl, id: \.self){
                        imgUrl in
                        
                        //Se pintan las imágenes consumidas desde la api
                        
                        AsyncImage(url: URL(string: imgUrl)){
                            Image in
                            Image.resizable()
                                .aspectRatio(contentMode: .fill)
                                .padding(.bottom)
                        } placeholder: {
                            Text("")
                        }
                        
//                        KFImage(URL(string: imgUrl))
//                            .resizable()
//                            .aspectRatio(contentMode: .fill)
                        
                    }
                }
            }.frame( height: 180)
        }.frame( maxWidth: .infinity, alignment: .leading)
    }
}

struct Comments: View {
    
    var body: some View{
        
        VStack(alignment: .leading){
            
            Text("COMENTARIOS")
                .foregroundColor(.white)
                .font(.title)
                .padding(.leading)
            
            VStack {
                
                HStack{
                    
                    Image("imgProfile1")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 60, height: 60, alignment: .leading)
                        .padding(.top)
                        .padding(.leading)
                        .padding(.bottom)
                    
                    VStack{
                        
                        Text("Pepito Pérez")
                            .foregroundColor(.white)
                            .font(.subheadline)
                            .fontWeight(.bold)
                            .frame(alignment: .leading)
//                            .padding(.top)
                            .padding(.leading, 10)
                        
                        Text("Hace 7 días")
                            .foregroundColor(.white)
                            .font(.subheadline)
                            .frame(alignment: .leading)
                    }
                    
                }.frame(maxWidth: .infinity, alignment: .leading)
                
                Text("He visto que como media tiene una gran calificación, y estoy completamente de acuerdo. Es el mejor juego que he jugado sin ninguna duda, combina una buena trama con una buenísima experiencia de juego libre gracias a su inmenso mapa y actividades.")
                    .foregroundColor(.white)
                    .font(.subheadline)
                    .frame(alignment: .center)
                    .padding(.horizontal)
                    .padding(.bottom)
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color(red: 34/255, green: 53/255, blue: 94/255, opacity: 1.0))
                .clipShape(RoundedRectangle(cornerRadius: 8)).padding(.all, 10)
            
            VStack {
                
                HStack{
                    
                    Image("imgProfile2")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 60, height: 60, alignment: .leading)
                        .padding(.top)
                        .padding(.leading)
                        .padding(.bottom)
                    
                    VStack{
                        
                        Text("Carmen Suá")
                            .foregroundColor(.white)
                            .font(.subheadline)
                            .fontWeight(.bold)
                            .frame(alignment: .leading)
//                            .padding(.top)
                            .padding(.leading, 10)
                        
                        Text("Hace 7 días")
                            .foregroundColor(.white)
                            .font(.subheadline)
                            .frame(alignment: .leading)
                    }
                    
                }.frame(maxWidth: .infinity, alignment: .leading)
                
                Text("He visto que como media tiene una gran calificación, y estoy completamente de acuerdo. Es el mejor juego que he jugado sin ninguna duda, combina una buena trama con una buenísima experiencia de juego libre gracias a su inmenso mapa y actividades.")
                    .foregroundColor(.white)
                    .font(.subheadline)
                    .frame(alignment: .center)
                    .padding(.horizontal)
                    .padding(.bottom)
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color(red: 34/255, green: 53/255, blue: 94/255, opacity: 1.0))
                .clipShape(RoundedRectangle(cornerRadius: 8)).padding(.all, 10)
            
        }
    }
}

// estos son datos de inicio al canva, para poder evitar errores y comenzar el desarrollo de algunas funcionalidades de la aplicación
struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        SingleGameView(url: "Ejemplo.com", titulo: "Sonic", studio: "Sega", calificacion: "E+", anoPublicacion: "1991", descripcion: "Juego de Sega Genesis publicado en 1991 con más de 40 millones de copias vendidas actualmente", tags: ["plataformas","mascota"], imgsUrl: [ "https://cdn.cloudflare.steamstatic.com/steam/apps/268910/ss_615455299355eaf552c638c7ea5b24a8b46e02dd.600x338.jpg","https://cdn.cloudflare.steamstatic.com/steam/apps/268910/ss_615455299355eaf552c638c7ea5b24a8b46e02dd.600x338.jpg","https://cdn.cloudflare.steamstatic.com/steam/apps/268910/ss_615455299355eaf552c638c7ea5b24a8b46e02dd.600x338.jpg"])
    }
}

//#Preview {
//    SingleGameView()
//}

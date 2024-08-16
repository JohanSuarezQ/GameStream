import SwiftUI
//MARK: Main Screen
struct ContentView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Spacer()
                Color(red: 19/255, green: 30/255, blue: 53/255).ignoresSafeArea()
                VStack{
                    Image("AppLogo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 250)
                        .padding(.bottom, 35)
                    LoginAndRegisterView()
                }
            }.navigationBarHidden(true)
        }
    }
}
//MARK: Login & Register Screen
struct LoginAndRegisterView:View {
    @State var typeOfLogin = false
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button("Iniciar Sesión") {
                    typeOfLogin = true
                    print("Pantalla de inicio de sesión")
                }
                .foregroundColor(typeOfLogin ? .white : .gray)
                Spacer()
                Button("Regístrate") {
                    typeOfLogin = false
                    print("Pantalla de registro")
                }
                .foregroundColor(typeOfLogin ? .gray : .white)
                Spacer()
            }
            Spacer(minLength: 50)
            if typeOfLogin == true {
                LoginView()
            } else {
                RegisterView(typeOfLogin: $typeOfLogin)
            }
            
        }
    }
}

//MARK: Individual Structs for Login & register
//MARK: Struct for login view
struct LoginView: View {
    @State var email = ""
    @State var password = ""
    @State var isHomeScreenActive = false
    
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        ScrollView {
            //Campo de correo eléctronico
            VStack(alignment: .leading) {
                Text("Correo Electrónico")
                    .foregroundColor(Color("Dark-Cian"))
                
                ZStack(alignment:.leading) {
                    if email.isEmpty{
                        Text("ejemplo@gmail.com")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    TextField("", text: $email)
                        .foregroundColor(.white)
                }
                Divider()
                    .frame(height: 1)
                    .background(Color("Dark-Cian"))
                    .padding(.bottom)
            }.padding(.horizontal, 40)
            // Campo de contraseña
            VStack(alignment: .leading) {
                Text("Contraseña")
                    .foregroundColor(.white)
                ZStack(alignment:.leading) {
                    if password.isEmpty{
                        Text("Escribe tu contraseña")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    SecureField("", text: $password)
                        .foregroundColor(.white)
                }
                Divider()
                    .frame(height: 1)
                    .background(Color("Dark-Cian"))
                    .padding(.bottom)
                // Botón olvidaste contaseña
                Text("¿Olvidaste tu contraseña?")
                    .font(.footnote)
                    .frame(width: 300, alignment: .trailing)
                    .foregroundColor(Color("Dark-Cian"))
                    .padding(.bottom)
                //Botón iniciar sesión
                Button(action: login, label: {
                    Text("INICIAR SESIÓN")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .center)
                        .padding(EdgeInsets(top: 11, leading: 18, bottom: 11, trailing: 18))
                        .overlay(RoundedRectangle(cornerRadius: 6.0)
                            .stroke(Color("Dark-Cian"), lineWidth: 1.0)
                            .shadow(color: .white, radius: 5))
                }).padding(.bottom)
                //Sección inicio de sesión con redes sociales
                Text("Iniciar sesión con redes sociales")
                    .frame( maxWidth: .infinity,  alignment: .center)
                    .foregroundColor(.white)
                
                HStack{
                    Button(action: {print("Inicio de sesión con Facebook")}) {
                        Text("Facebook")
                            .font(.subheadline)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.vertical, 3.0)
                            .frame( maxWidth: .infinity, alignment: .center)
                            .background(Color("Blue-Gray"))
                            .clipShape(RoundedRectangle(cornerRadius: 4.0))
                    }.padding()
                    
                    Button(action: {print("Inicio de sesión con Twitter")}) {
                        Text("Twitter")
                            .font(.subheadline)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.vertical, 3.0)
                            .frame( maxWidth: .infinity, alignment: .center)
                            .background(Color("Blue-Gray"))
                            .clipShape(RoundedRectangle(cornerRadius: 4.0))
                    }.padding()
                }
                
            }.padding(.horizontal, 40)
            
            NavigationLink(
                destination: Home(),
                isActive: $isHomeScreenActive,
                label: {
                    EmptyView()
                }
            )
            
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Error de Inicio de Sesión"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }
    
    func login (){
        let objetoDatosUsuario = SaveData()
            alertMessage = "Correo electrónico y/o contraseña incorrecta"
            

            if objetoDatosUsuario.validar(correo: email, contrasena: password){
                isHomeScreenActive.toggle()
            }else{
                showAlert = true
                print("Tus datos son incorrectos")
            }
//        let objetoDatosUsuario = SaveData()
//        print("Mi correo es \(email) y mi contraseña es \(password)")
//
//                if objetoDatosUsuario.validar(correo: email, contrasena: password){
//                    isHomeScreenActive.toggle()
//                }else{
//                    //isPantallaHomeActive.toggle()
//                    print("Tus datos son incorrectos")
//
//                }
    }
}



//MARK: Struct for register view
struct RegisterView: View {
    @State var email = ""
    @State var password = ""
    @State var confirmPassword = ""
    
    @Binding var typeOfLogin: Bool
    
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        ScrollView {
            VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/){
                Text("Elige una foto de perfil")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                Text("Puedes cambiar o elegirla más adelante")
                    .font(.footnote)
                    .fontWeight(.light)
                    .foregroundColor(.gray)
                    .padding(.bottom)
                
                Button(action: takePhoto, label: {
                    ZStack {
                        Image("perfilEjemplo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 80, height: 80)
                        Image(systemName: "camera")
                            .foregroundColor(.white)
                        
                    }
                }).padding(.bottom)
                
            }
            
            //Campo de correo eléctronico
            VStack(alignment: .leading) {
                Text("Correo Electrónico*")
                    .foregroundColor(Color("Dark-Cian"))
                
                ZStack(alignment:.leading) {
                    if email.isEmpty{
                        Text("ejemplo@gmail.com")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    TextField("", text: $email)
                        .foregroundColor(.white)
                }
                Divider()
                    .frame(height: 1)
                    .background(Color("Dark-Cian"))
                    .padding(.bottom)
            }.padding(.horizontal, 40)
            
            // Campo de contraseña
            VStack(alignment: .leading) {
                Text("Contraseña*")
                    .foregroundColor(.white)
                ZStack(alignment:.leading) {
                    if password.isEmpty{
                        Text("Escribe tu contraseña")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    SecureField("", text: $password)
                        .foregroundColor(.white)
                }
                Divider()
                    .frame(height: 1)
                    .background(Color("Dark-Cian"))
                    .padding(.bottom)
                // Campo confirmar contraseña
                Text("Confirmar contraseña*")
                    .foregroundColor(.white)
                ZStack(alignment:.leading) {
                    if confirmPassword.isEmpty{
                        Text("Reescribe tu contraseña")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    SecureField("", text: $confirmPassword)
                        .foregroundColor(.white)
                }
                Divider()
                    .frame(height: 1)
                    .background(Color("Dark-Cian"))
                    .padding(.bottom)

                //Botón de registro
                Button(action: register, label: {
                    Text("REGÍSTRATE")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .center)
                        .padding(EdgeInsets(top: 11, leading: 18, bottom: 11, trailing: 18))
                        .overlay(RoundedRectangle(cornerRadius: 6.0)
                            .stroke(Color("Dark-Cian"), lineWidth: 1.0)
                            .shadow(color: .white, radius: 5))
                }).padding(.bottom)
                
                //Sección registro con redes sociales
                Text("Regístrate con redes sociales")
                    .frame( maxWidth: .infinity,  alignment: .center)
                    .foregroundColor(.white)
                
                HStack{
                    Button(action: {print("Inicio de sesión con Facebook")}) {
                        Text("Facebook")
                            .font(.subheadline)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.vertical, 3.0)
                            .frame( maxWidth: .infinity, alignment: .center)
                            .background(Color("Blue-Gray"))
                            .clipShape(RoundedRectangle(cornerRadius: 4.0))
                    }.padding()
                    
                    Button(action: {print("Inicio de sesión con Twitter")}) {
                        Text("Twitter")
                            .font(.subheadline)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.vertical, 3.0)
                            .frame( maxWidth: .infinity, alignment: .center)
                            .background(Color("Blue-Gray"))
                            .clipShape(RoundedRectangle(cornerRadius: 4.0))
                    }.padding()
                }
                
            }.padding(.horizontal, 40)
            
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Registro de Usuario"), message: Text(alertMessage), dismissButton: .default(Text("OK")){
                // Cambiar el tipo de login después de cerrar el alert
                if alertMessage == "Usuario registrado con éxito, presiona OK para ir a la pantalla de inicio de sesión" {
                    typeOfLogin = true
                }
            })
        }
    }
    func takePhoto (){
        print("Tomando foto de perfil")
    }

    func register (){
            // Validación de la contraseña
            if password == confirmPassword {
                let objetoActualizadorDatos = SaveData()
                let resultado = objetoActualizadorDatos.guardarDatos(correo: email, contrasena: password, nombre: "")
                print("Se guardaron los datos con éxito?: \(resultado)")
                
                alertMessage = "Usuario registrado con éxito, presiona OK para ir a la pantalla de inicio de sesión"
                showAlert = true
//                DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
//                            typeOfLogin = true
//                        }
            } else {
                print("Contraseñas diferentes, vuelve a intentarlo")
                alertMessage = "Contraseñas diferentes, vuelve a intentarlo"
                showAlert = true
            }
//        print("Me registro con el correo \(email), la contraseña \(password) y confirmación de contraseña \(confirmPassword)")
//            
//                //validación contraseña
//                if password == confirmPassword{
//                  
//                    let objetoActualizadorDatos = SaveData()
//                    
//                    let resultado = objetoActualizadorDatos.guardarDatos(correo: email, contrasena: password, nombre: "")
//                    
//                    print("Se guardaron los datos con exito?: \(resultado)")
//                    
//                }else{
//                    
//                    print("Contraseñas diferentes, vuelve a intentarlo")
//                }
                
                
    }
}



#Preview {
    ContentView()
}

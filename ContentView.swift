//
//  MaskOn
//
//  Created by Jose Fernandez del Valle on 8/21/20.
//  Copyright © 2020 me.fernandez.jose. All rights reserved.
//

import SwiftUI

// create structs for progress bars
struct noseBar: View {
    @Binding var progressNose: Float
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 10.0)
                .opacity(0.3)
                .foregroundColor(Color.red)
            
            Circle()
                .trim(from: 0.0, to: CGFloat(min(self.progressNose, 1.0)))
                .stroke(style: StrokeStyle(lineWidth: 5.0, lineCap: .round, lineJoin: .round))
                .foregroundColor(Color(#colorLiteral(red: 0.9995340705, green: 0.988355577, blue: 0.4726552367, alpha: 1)))
                .rotationEffect(Angle(degrees: 270.0))
                .animation(.linear)
        }
    }
}

struct chinBar: View {
    @Binding var progressChin: Float
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 10.0)
                .opacity(0.3)
                .foregroundColor(Color.red)
            
            Circle()
                .trim(from: 0.0, to: CGFloat(min(self.progressChin, 1.0)))
             .stroke(style: StrokeStyle(lineWidth: 5.0, lineCap: .round, lineJoin: .round))
             .foregroundColor(Color(#colorLiteral(red: 0.9995340705, green: 0.988355577, blue: 0.4726552367, alpha: 1)))
             .rotationEffect(Angle(degrees: 270.0))
             .animation(.linear)
        }
    }
}

struct okBar: View {
    @Binding var progressOk: Float
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 10.0)
                .opacity(0.3)
                .foregroundColor(Color.red)
            
            Circle()
                .trim(from: 0.0, to: CGFloat(min(self.progressOk, 1.0)))
             .stroke(style: StrokeStyle(lineWidth: 5.0, lineCap: .round, lineJoin: .round))
             .foregroundColor(Color(#colorLiteral(red: 0.9995340705, green: 0.988355577, blue: 0.4726552367, alpha: 1)))
             .rotationEffect(Angle(degrees: 270.0))
             .animation(.linear)
        }
    }
}

// create struc for sheetview
struct SheetView: View {
    @Binding var showSheetView: Bool
    
    var body: some View {
        NavigationView {
            
            VStack{
            Image("error")
                .resizable()
                .renderingMode(.original)
                .frame(width: 360, height: 550)
            }
            .navigationBarTitle(Text("Importante"), displayMode: .inline)
                .navigationBarItems(trailing: Button(action: {
                    print("Dismissing sheet view...")
                    self.showSheetView = false
                }) {
                    Text("Ok").bold()
                })
        }
    }
}

// contentview
struct ContentView: View {
    
    // declare variables
     @State private var mask = ["nose", "chin", "ok"]
     @State private var showingAlert = false
     @State private var alertTitle = ""
     @State private var alertMessage = ""
     @State var selection: Int? = nil
     @State var animationAmount: Double = 0
     @State var showSheetView = false
    
    
     @State private var noseFace:Float = 0.0
    
    func noseFaceInt() -> Int {
        let noseFaceInt = Int(noseFace * 10)
        return noseFaceInt
    }
    
    
    
     @State private var chinFace:Float = 0.0
    
    func chinFaceInt() -> Int {
        let chinFaceInt = Int(chinFace * 10)
        return chinFaceInt
    }
    
    
     @State private var okFace:Float = 0.0
    
    func okFaceInt() -> Int {
        let okFaceInt = Int(okFace * 10)
        return okFaceInt
    }
    
   // body starts
    var body: some View {
        
        // stack for navigation link
        VStack(alignment: .leading){
           Button(action: {
           self.showSheetView.toggle()
              }) {
           Image(systemName: "info.circle")
            .font(.title)
            .padding()
                }.sheet(isPresented: $showSheetView) {
            SheetView(showSheetView: self.$showSheetView)
              }
        
    
        ZStack{
            
            LinearGradient(gradient: Gradient(colors: [.black, .gray]), startPoint: .top, endPoint: .bottom)
            .edgesIgnoringSafeArea(.all)
            
        
        VStack(spacing: 50){
         
    //stack for buttons
            ZStack{
                
            VStack(spacing: 60){
        
            //add buttons
            ForEach(0..<3) { number in
            
            Button(action: {
                    
                self.buttonTapped(number)
                self.selection = number

                withAnimation{
                    self.animationAmount += 360
                }
                
            }) {
                
                Image(self.mask[number])
                    .resizable()
                    .renderingMode(.original)
                    .frame(width: 125.0, height: 125.0)
                    .clipShape(Capsule())
                    .shadow(color: Color.black, radius: 2)
                
                }
                .rotation3DEffect(.degrees(self.selection == number ? self.animationAmount : 0), axis: (x: 0, y: 1, z: 0))
        }
        
            
        }
         
                
      // sack for labels
            VStack(spacing: 60){
                
           noseBar(progressNose: self.$noseFace)
                  .frame(width: 125, height: 125)
                
           chinBar(progressChin: self.$chinFace)
                  .frame(width: 125, height: 125)
                
            okBar(progressOk: self.$okFace)
                   .frame(width: 125, height: 125)
                    
                }
                
                
            VStack(spacing: 120){
                
            Text("  \(noseFaceInt())  ")
                .font(.title)
                .fontWeight(.black)
                .background(Color(#colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)))
                .clipShape(Capsule())
                .shadow(color: Color.red, radius: 2)
                .foregroundColor(Color(#colorLiteral(red: 0.9995340705, green: 0.988355577, blue: 0.4726552367, alpha: 1)))
                .offset(x: 70, y: -90)

                
            Text("  \(chinFaceInt())  ")
                .font(.title)
                .fontWeight(.black)
                .background(Color(#colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)))
                .clipShape(Capsule())
                .shadow(color: Color.red, radius: 2)
                .foregroundColor(Color(#colorLiteral(red: 0.9995340705, green: 0.988355577, blue: 0.4726552367, alpha: 1)))
                .offset(x: 70, y: -60)
                
                
            Text("  \(okFaceInt())  ")
                .font(.title)
                .fontWeight(.black)
                .background(Color(#colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)))
                .clipShape(Capsule())
                .shadow(color: Color.green, radius: 2)
                .foregroundColor(Color(#colorLiteral(red: 0.9995340705, green: 0.988355577, blue: 0.4726552367, alpha: 1)))
                .offset(x: 70, y: -30)
                    
                }
                    
                
            }
            
            }
            
                 // alert based on logic
               .alert(isPresented: $showingAlert) {
                   Alert(title: Text(alertTitle),
                         message: Text(alertMessage),
                         dismissButton: .default(Text("Vuelve a Jugar!")))
               }
        }
            
    }
        
    }


     //function for app logic

     func buttonTapped(_ number: Int) {
        
        if number == 0 {
            noseFace += 0.1
            
        } else if number == 1 {
            chinFace += 0.1
            
        } else {
            okFace += 0.1
            
        }
        
        
        if noseFaceInt() > 9 {
            alertTitle = "Cuidado!"
            alertMessage = "👃 Hay que taparse la nariz!"
            noseFace = 0.0
            chinFace = 0.0
            okFace = 0.0
            showingAlert = true
            
        } else if chinFaceInt() > 9 {
            alertTitle = "Cuidado!"
            alertMessage = "😱 Hay que taparse la boca!"
            noseFace = 0.0
            chinFace = 0.0
            okFace = 0.0
            showingAlert = true
            
        } else if okFaceInt() > 9 {
            alertTitle = "Perfecto!"
            alertMessage = "👏 Bien, pero estate atento!"
            noseFace = 0.0
            chinFace = 0.0
            okFace = 0.0
            showingAlert = true
            
        } else {
        
        }
        
    }
    
   
    
}


 // Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

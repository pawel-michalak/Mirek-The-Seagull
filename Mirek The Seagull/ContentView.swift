//
//  ContentView.swift
//  Mirek The Seagull
//
//  Created by Paweł Michalak on 12/03/2021.
//

import SwiftUI
import AVKit

struct ContentView: View {

    @State private var audioPlayer: AVAudioPlayer!
    @State private var tapped = false
    
    var body: some View {
        VStack {
            Text("Mirek")
                .font(.title)
                .fontWeight(.bold)
            
            Text("The Seagull")
                .font(.caption)
            
            Spacer()
            
            Image( tapped ? "seagull" : "seagull_ready")
                .scaleEffect(tapped ? 1 : 0.5)
                .padding(.leading, 20)
                .frame(width: 250, height: 250, alignment: .center)
                .animation(nil)
                .clipShape(Circle())
                .overlay(Circle().stroke(tapped ? Color.blue : Color.white, lineWidth: 4))
                .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                .animation(.easeIn)
                .onTapGesture {
                    if tapped {
                        audioPlayer.stop()
                        print("Stopping sound...")
                        return
                    }
                    let sound = Bundle.main.path(forResource: "seagull_laugh", ofType: "m4a")
                    do {
                        audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
                        audioPlayer.play()
                        print("Playing sound...")
                    } catch {
                        print("Cannot create audio player :(")
                    }
                }
                .onAppear {
                    DispatchQueue.global(qos: .background).async {
                        repeat {
                            if let player = audioPlayer, self.tapped != player.isPlaying {
                                DispatchQueue.main.async {
                                    tapped = player.isPlaying
                                }
                            }
                        } while true
                    }
                }
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

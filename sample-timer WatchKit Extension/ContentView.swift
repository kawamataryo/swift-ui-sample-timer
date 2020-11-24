//
//  ContentView.swift
//  sample-timer WatchKit Extension
//
//  Created by 川俣涼 on 2020/11/21.
//

import SwiftUI

struct ContentView: View {
    @State var timeVal = 1
    @State var timerScreenShow:Bool = false
    
    var body: some View {
        VStack {
            Text("Timer \(self.timeVal) seconds").font(.body)
            Picker(selection: self.$timeVal, label: Text("")) {
                Text("1").tag(1).font(.title2)
                Text("5").tag(5).font(.title2)
                Text("10").tag(10).font(.title2)
                Text("30").tag(30).font(.title2)
                Text("60").tag(60).font(.title2)
            }
            NavigationLink(
                destination: TimerView(timerScreenShow: self.$timerScreenShow, timeVal: self.timeVal, initialTime: self.timeVal),
                isActive: $timerScreenShow,
                label: {
                    Text("Start")
                })
        }
    }
}

struct TimerView: View {
    @Binding var timerScreenShow:Bool
    @State var timeVal:Int
    let initialTime:Int

    var body: some View {
        if timeVal > -1 {
            VStack {
                ZStack {
                    Text("\(self.timeVal)").font(.system(size: 40))
                        .onAppear() {
                            Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
                                if self.timeVal > -1 {
                                    self.timeVal -= 1
                                }
                            }
                        }
                    ProgressBar(progress: self.timeVal, initial: self.initialTime).frame(width: 90.0, height: 90.0)
                }
                Button(action: {
                    self.timerScreenShow = false
                }, label: {
                    Text("Cancel")
                        .foregroundColor(Color.red)
                })
                .padding(.top)
            }
        } else {
            Button(action: {
                self.timerScreenShow = false
            }, label: {
                Text("Done!")
                    .font(.title)
                    .foregroundColor(Color.green)
            }).onAppear() {
                WKInterfaceDevice.current().play(.notification)
            }
        }
    }
}

struct ProgressBar: View {
    let progress: Int
    let initial: Int
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 15.0)
                .opacity(0.3)
                .foregroundColor(Color.red)
            Circle()
                .trim(from: 0.0, to: CGFloat(min(Float(self.progress) / Float(self.initial), 1.0)))
                .stroke(style: StrokeStyle(lineWidth: 15.0, lineCap: .round, lineJoin: .round))
                .foregroundColor(Color.red)
                .rotationEffect(Angle(degrees: 270.0))
                .animation(.linear)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

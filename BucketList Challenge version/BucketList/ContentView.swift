//
//  ContentView.swift
//  BucketList
//
//  Created by Roberto Gutierrez on 01/12/20.
//  Copyright © 2020 Roberto Gutierrez. All rights reserved.
//

import LocalAuthentication
import MapKit
import SwiftUI

struct ContentView: View {
    @State private var isUnlocked = false
    @State private var isErrorShowing = false
    
    var body: some View {
        ZStack {
            if isUnlocked {
                UnlockedView()
            } else {
                Button("Unlock Places") {
                    self.authenticate()
                }
            .padding()
                .background(Color.orange)
                .foregroundColor(.black)
            .clipShape(Capsule())
            }
        }
        .alert(isPresented: $isErrorShowing) {
            Alert(title: Text("Somehing went wrong"), message: Text("The biometric authenticaton failed."), dismissButton: .default(Text("Ok")))
        }
    }
    
    func authenticate() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Please authenticate yourself to unlock your places."
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                DispatchQueue.main.async {
                    if success {
                        self.isUnlocked = true
                    } else {
                        // error
                    }
                }
            }
        } else{
            self.isErrorShowing = true
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

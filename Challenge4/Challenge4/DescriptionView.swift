//
//  DescriptionView.swift
//  Challenge4
//
//  Created by Roberto Gutiérrez on 30/09/20.
//

import SwiftUI

struct DescriptionView: View {
    let activity: Activity
    
    var body: some View {
        NavigationView {
            List{
                Text(activity.description)
            }
        .navigationTitle(Text(activity.name))
        }
    }
}

struct DescriptionView_Previews: PreviewProvider {
    static var previews: some View {
        let trialActivity = Activity(name: "Trial", totalPracticeTime: "1:30", description: "This is a trial activity for description View")
        
        DescriptionView(activity: trialActivity)
    }
}

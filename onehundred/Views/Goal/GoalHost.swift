//
//  GoalHost.swift
//  onehundred
//
//  Created by Peter Flickinger on 10/1/19.
//  Copyright © 2019 Peter Flickinger. All rights reserved.
//

import SwiftUI

struct GoalHost: View {
    @Environment(\.editMode) var mode
    @ObservedObject var goalVM: GoalViewModel
    @State var draftGoalVM = GoalViewModel()
                
    init(goalID: UUID){
        self.goalVM = GoalViewModel(goalID: goalID)
    }
    
    init(goalVM: GoalViewModel){
        self.goalVM = goalVM
    }
    
    func save(){
        goalVM.text = draftGoalVM.text
        goalVM.checkpointLength = draftGoalVM.checkpointLength
        goalVM.durration = draftGoalVM.durration

        goalVM.save()
    }
    
    var body: some View{
        
        VStack{
            if self.mode?.wrappedValue == .inactive {
                GoalView(goalVM: self.goalVM)
            } else {
                GoalEditor(goalVM: self.draftGoalVM)
                .onAppear(perform: {
                    self.draftGoalVM = self.goalVM
                })
                .onDisappear(perform: {
                    self.save()
                })
            }
        }
        .navigationBarTitle(self.goalVM.text)
        .navigationBarItems(trailing:
            EditButton()
         )
    }
}



//
//struct GoalHost_Previews: PreviewProvider {
//    static var previews: some View {
//        GoalHost(goalID: GoalDataManager().getFirstGoal().id)
//    }
//}
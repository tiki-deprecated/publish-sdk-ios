/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */
import SwiftUI

struct EndingError: View{
    
    @Environment(\.colorScheme) private var colorScheme
    @Binding var pendingPermissions: [Permission]?
    var onAuthorized: () -> Void
    
    var body: some View {
        Ending(
            title: AnyView(Whoops()),
            message: "Permission Required",
            footnote: AnyView(
                VStack(spacing:0){
                    Text("Offer declined.")
                        .font(.custom(TikiSdk.theme(colorScheme).fontRegular, size: 18))
                        .foregroundColor(Color(.black).opacity(0.6))
                    HStack(spacing:0){
                        Text("To proceed, allow ")
                            .font(.custom(TikiSdk.theme(colorScheme).fontRegular, size: 18))
                            .foregroundColor(Color(.black).opacity(0.6))
                        Text("\(getPendingPermissionsNames()).").font(.custom(TikiSdk.theme(colorScheme).fontRegular, size: 18))
                            .font(.custom(TikiSdk.theme(colorScheme).fontRegular, size: 18))
                            .foregroundColor(Color(.black).opacity(0.6))
                            .underline()
                            .onTapGesture {
                                guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                                    return
                                }
                                if UIApplication.shared.canOpenURL(settingsUrl) {
                                    UIApplication.shared.open(settingsUrl, completionHandler: { (success) in })
                                }
                                
                            }
                    }
                }
            )
        ).onAppear{
            requestPendingPermissions()
        }
    }
    
    
    func getPendingPermissionsNames() -> String{
            if(pendingPermissions!.count == 1){
                return pendingPermissions!.first!.name()
            }
            var nameList : [String] = []
            pendingPermissions!.forEach{ perm in
                nameList.append(perm.name())
            }
            return nameList.joined(separator: ", ")
    }
    
    func requestPendingPermissions(){
        if(pendingPermissions!.isEmpty){
            onAuthorized()
            return
        }
        pendingPermissions![0].requestAuth{ isAuthorized in
            if(isAuthorized){
                pendingPermissions!.remove(at: 0)
                requestPendingPermissions()
            }
        }
    }
}

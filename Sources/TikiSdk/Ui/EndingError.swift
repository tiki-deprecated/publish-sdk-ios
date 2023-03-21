import SwiftUI

struct EndingError: View{
    
    @Environment(\.colorScheme) private var colorScheme
    var pendingPermissions: String
    
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
                        Text("\(pendingPermissions).").font(.custom(TikiSdk.theme(colorScheme).fontRegular, size: 18))
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
        )
    }
}

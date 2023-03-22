import SwiftUI

public struct LearnMore : View{
    
    @Environment(\.colorScheme) var colorScheme
    
    var learnMoreText: LocalizedStringKey = try! LocalizedStringKey(String(
        contentsOfFile: Bundle.main.path(forResource: "learnMore", ofType: "md")!,
        encoding: String.Encoding(rawValue: NSUTF8StringEncoding)))
    
    public var body: some View {
        return ScrollView(.vertical){
            Text(learnMoreText)
            .font(.custom(TikiSdk.theme(colorScheme).fontRegular, size:16))}
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.horizontal, 30)
        .padding(.top, 25)
        .padding(.bottom, 0)
    }
}

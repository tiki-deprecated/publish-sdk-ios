/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import SwiftUI
import TikiSdk

@main
struct TikiSdkExampleApp: App {
    
    @State var isShowingOfferPrompt = false
    
    init() {
        Task{
            let publishingId = "e12f5b7b-6b48-4503-8b39-28e4995b5f88"
            try await TikiSdk.config()
                .offer
                    .id("test_offer")
                    .ptr("test_offer")
                    .reward("offerImage")
                    .bullet(text: "Learn how our ads perform ", isUsed: true)
                    .bullet(text: "Reach you on other platforms", isUsed: false)
                    .bullet(text: "Sold to other companies", isUsed: false)
                    .use(usecases: [LicenseUsecase(LicenseUsecaseEnum.support)])
                    .permission(PermissionType.contacts)
                    .tag(TitleTag(TitleTagEnum.advertisingData))
                    .description("Trade your IDFA (kind of like a serial # for your phone) for a discount.")
                    .terms("**Lorem ipsum dolor sit amet**, consectetur adipiscing elit. Phasellus lobortis risus ac ultrices faucibus. Nullam vel pulvinar neque. Morbi ultrices maximus est, quis blandit urna vestibulum nec. Morbi et finibus nisi. Vestibulum dignissim rutrum mi sit amet sagittis. Aenean id ligula eget enim feugiat luctus vitae vitae orci. Maecenas aliquam semper nunc vel pellentesque. Ut cursus neque non est mattis consequat. Duis posuere odio et tellus aliquam, et tristique erat pharetra. Mauris sollicitudin lorem ligula. Ut lacinia, neque ac ornare gravida, libero turpis fermentum nibh, eget sodales diam magna sit amet lacus. Aliquam pretium suscipit mi eget luctus. Aliquam ut velit ut magna elementum sollicitudin in et magna. Ut a elementum tellus, eu cursus lacus. Pellentesque neque nisi, semper ac mi vel, fringilla semper nisl. Morbi at vulputate lectus, non ornare nulla.\nVestibulum convallis rutrum tellus sed vulputate. Suspendisse condimentum mauris quis odio aliquet, at posuere augue egestas. Nulla finibus nibh ac placerat pretium. Mauris volutpat urna sit amet vehicula fermentum. Praesent semper est diam, sit amet elementum orci luctus ac. Quisque condimentum ipsum in venenatis rutrum. Donec rutrum nisl id elit porttitor, vel scelerisque quam ultricies. Donec vulputate, mi at tempor hendrerit, risus tortor consequat neque, non laoreet orci ante tempor dolor. Curabitur placerat convallis risus, a facilisis diam mollis in.\nMauris in ex dolor. Nunc eu mollis mi. Integer ut nulla egestas, finibus tellus in, congue sem. Vestibulum sit amet velit cursus, consequat purus id, porttitor ligula. Aliquam pellentesque non augue quis tincidunt. Duis a pulvinar odio, non ultrices metus. Sed eu risus quam. Nam vehicula ligula id aliquet aliquet. Quisque faucibus odio pulvinar tellus tristique, eget tempus tellus accumsan. Nulla vehicula nunc quis dapibus lobortis. Sed urna magna, commodo vitae enim eget, scelerisque hendrerit mi. Pellentesque lobortis lectus vitae convallis facilisis.\nPhasellus lobortis purus sit amet sodales efficitur. Mauris sapien lorem, pretium id turpis eu, tristique maximus tellus. Donec porttitor, enim ut scelerisque dapibus, lectus tellus laoreet ante, a ornare dolor nisi sed risus. Vestibulum facilisis mollis urna in suscipit. Pellentesque sit amet lobortis nulla. Fusce semper rhoncus urna a gravida. In congue nec nisi eu hendrerit. Donec sed felis elementum lacus posuere porttitor eget quis dolor. Maecenas eu iaculis dolor. Nam venenatis tempor velit vel finibus. Phasellus purus nunc, condimentum sit amet porttitor nec, rhoncus et ante. Fusce tristique nibh quis sem varius ultricies. Maecenas egestas justo sed enim maximus consectetur.\nPhasellus malesuada magna a ex mollis varius. Quisque a vulputate metus. Cras in nibh lorem. Proin in enim efficitur, pellentesque elit sed, dictum turpis. Duis sagittis lectus eu magna imperdiet maximus. Nullam condimentum scelerisque arcu ac auctor. Phasellus malesuada erat quis gravida mollis.")
                    .duration(365 * 24 * 60 * 60)
                .add()
                .onAccept { offer, license in print("accepted")}
                .onDecline { offer, license in print("declined")}
                .onSettings  { print("settings") }
                .disableAcceptEnding(false)
                .disableDeclineEnding(false)
                .initialize(publishingId: publishingId)
        }
    }
    
    var body: some Scene {
        WindowGroup {
                Button(action: {
                    TikiSdk.present()
                }) {
                    Text("Start").font(.custom("SpaceGrotesk-Regular", size:20))
                }
//                Button(action: {
//                    TikiSdk.settings()
//                }) {
//                    Text("Settings").font(.custom("SpaceGrotesk-Regular", size:20))
//                }
        }
    }
}

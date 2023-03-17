import AVFoundation
import Photos
import CoreLocation
import EventKit
import Contacts
import HealthKit
import CoreMotion
import Speech
import MediaPlayer
import AppTrackingTransparency
import CoreBluetooth

public enum PermissionType {
    /// Permission to access the device's camera.
    case camera
    
    /// Permission to access the device's microphone.
    case microphone
    
    /// Permission to access the device's photo library.
    case photoLibrary
    
    /// Permission to access the device's location during app usage.
    case locationInUse
    
    /// Permission to access the device's location.
    case locationAlways
    
    /// Permission to send notifications to the user.
    case notifications
    
    /// Permission to access the device's calendar.
    case calendar
    
    /// Permission to access the device's contacts.
    case contacts
    
    /// Permission to access the device's reminders.
    case reminders
    
    /// Permission to use speech recognition.
    case speechRecognition
    
    /// Permission to access the user's health data.
    case health
    
    /// Permission to access the device's media library.
    case mediaLibrary
    
    /// Permission to access the device's motion data.
    case motion
    
    /// Permission to track the user across apps and websites.
    case tracking
    
    
    public func name() -> String{
        switch self{
            
        case .camera:
            return "camera"
        case .microphone:
            return "microphone"
        case .photoLibrary:
            return "photo library"
        case .locationInUse:
            return "location (in use)"
        case .locationAlways:
            return "location (always)"
        case .notifications:
            return "notifications"
        case .calendar:
            return "calendar"
        case .contacts:
            return "contacts"
        case .reminders:
            return "reminders"
        case .speechRecognition:
            return "speech recognition"
        case .health:
            return "health"
        case .mediaLibrary:
            return "media library"
        case .motion:
            return "motion"
        case .tracking:
            return "tracking"
        }
    }
    
    public func isAuthorized() -> Bool {
        switch self {
        case .camera:
            return AVCaptureDevice.authorizationStatus(for: .video) == .authorized
        case .microphone:
            return AVCaptureDevice.authorizationStatus(for: .audio) == .authorized
        case .photoLibrary:
            return PHPhotoLibrary.authorizationStatus() == .authorized
        case .locationInUse:
            return CLLocationManager().authorizationStatus == .authorizedWhenInUse
        case .locationAlways:
            return CLLocationManager().authorizationStatus == .authorizedAlways
        case .notifications:
            var auth = false
            UNUserNotificationCenter.current().getNotificationSettings { (settings) in
                auth = settings.authorizationStatus == .authorized
            }
            return auth
        case .calendar:
            return EKEventStore.authorizationStatus(for: .event) == .authorized
        case .contacts:
            return CNContactStore.authorizationStatus(for: .contacts) == .authorized
        case .reminders:
            return EKEventStore.authorizationStatus(for: .reminder) == .authorized
        case .speechRecognition:
            return SFSpeechRecognizer.authorizationStatus() == .authorized
        case .health:
            return HKHealthStore().authorizationStatus(for: HKObjectType.workoutType()) == .sharingAuthorized
        case .mediaLibrary:
            return MPMediaLibrary.authorizationStatus() == .authorized
        case .motion:
            return CMMotionActivityManager.authorizationStatus() == .authorized
        case .tracking:
            if #available(iOS 14.5, *) {
                return ATTrackingManager.trackingAuthorizationStatus == .authorized
            } else {
                return false
            }
        }
    }
    
    public func requestAuth(_ completion: @escaping ((Bool) -> Void) = {_ in }) {
        switch self {
            case .camera:
                AVCaptureDevice.requestAccess(for: .video) { granted in
                    completion(granted)
                }
            case .microphone:
                AVCaptureDevice.requestAccess(for: .audio) { granted in
                    completion(granted)
                }
            case .photoLibrary:
                PHPhotoLibrary.requestAuthorization { status in
                    completion(status == .authorized)
                }
            case .locationAlways:
                let locationManager = CLLocationManager()
                locationManager.requestAlwaysAuthorization()
                completion(locationManager.authorizationStatus == .authorizedAlways || locationManager.authorizationStatus == .authorizedAlways)
            case .locationInUse:
                let locationManager = CLLocationManager()
                locationManager.requestWhenInUseAuthorization()
                completion(locationManager.authorizationStatus == .authorizedWhenInUse)
            case .notifications:
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
                    completion(granted)
                }
            case .calendar:
                let eventStore = EKEventStore()
                eventStore.requestAccess(to: .event) { granted, error in
                    completion(granted)
                }
            case .contacts:
                let contactStore = CNContactStore()
                contactStore.requestAccess(for: .contacts) { granted, error in
                    completion(granted)
                }
            case .reminders:
                let eventStore = EKEventStore()
                eventStore.requestAccess(to: .reminder) { granted, error in
                    completion(granted)
                }
            case .speechRecognition:
                SFSpeechRecognizer.requestAuthorization { status in
                    completion(status == .authorized)
                }
            case .health:
                let healthStore = HKHealthStore()
                let typesToShare: Set<HKSampleType> = [HKSampleType.workoutType()]
                healthStore.requestAuthorization(toShare: typesToShare, read: nil) { granted, error in
                    completion(granted)
                }
            case .mediaLibrary:
                MPMediaLibrary.requestAuthorization { status in
                    completion(status == .authorized)
                }
            case .motion:
                let motionActivityManager = CMMotionActivityManager()
                motionActivityManager.queryActivityStarting(from: Date(), to: Date(), to: .main) { activities, error in
                    completion(true)
                }
            case .tracking:
                if #available(iOS 14.5, *) {
                    ATTrackingManager.requestTrackingAuthorization(completionHandler: { status in
                        completion(status == .authorized)
                    })
                } else {
                    completion(false)
                }
        }
    }

}

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
    
    /// Permission to access the device's location.
    case location
    
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
    
    /// Permission to act as a Bluetooth peripheral device.
    case bluetoothPeripheral
    
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
        case .location:
            return "location"
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
        case .bluetoothPeripheral:
            return "bluetooth peripheral"
        case .tracking:
            return "tracking"
        }
    }
    /**
     Returns the authorization status for the specified permission type.
     
     - Parameter type: The type of permission to check.
     - Returns: The authorization status for the specified permission type.
     */
    public func authorizationStatus() -> Any {
        switch self {
        case .camera:
            return AVCaptureDevice.authorizationStatus(for: .video)
        case .microphone:
            return AVCaptureDevice.authorizationStatus(for: .audio)
        case .photoLibrary:
            return PHPhotoLibrary.authorizationStatus()
        case .location:
            return CLLocationManager().authorizationStatus
        case .notifications:
            var auth: UNAuthorizationStatus? = nil
            UNUserNotificationCenter.current().getNotificationSettings { (settings) in
                auth = settings.authorizationStatus
            }
            return auth!
        case .calendar:
            return EKEventStore.authorizationStatus(for: .event)
        case .contacts:
            return CNContactStore.authorizationStatus(for: .contacts)
        case .reminders:
            return EKEventStore.authorizationStatus(for: .reminder)
        case .speechRecognition:
            return SFSpeechRecognizer.authorizationStatus()
        case .health:
            return HKHealthStore().authorizationStatus(for: HKObjectType.workoutType())
        case .mediaLibrary:
            return MPMediaLibrary.authorizationStatus()
        case .motion:
            return CMMotionActivityManager.authorizationStatus()
        case .bluetoothPeripheral:
            if #available(iOS 13.1, *) {
                return CBPeripheralManager.authorization
            } else {
                return CBPeripheralManager.authorizationStatus()
            }
        case .tracking:
            if #available(iOS 14.5, *) {
                return ATTrackingManager.trackingAuthorizationStatus
            } else {
                return ATTrackingManager.AuthorizationStatus.notDetermined
            }
        }
    }
}




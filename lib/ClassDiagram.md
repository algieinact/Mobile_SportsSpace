classDiagram
    class User {
        -String userId
        -String username
        -String email
        -String password
        -String fullName
        -String phoneNumber
        -String profilePicture
        -Date dateJoined
        -Boolean isActive
        +login()
        +logout()
        +updateProfile()
        +verifyAccount()
    }

    class Admin {
        -String adminId
        -String[] permissions
        +manageUsers()
        +manageContent()
        +generateReports()
        +moderateContent()
    }

    class SportsEnthusiast {
        -String[] interests
        -String skillLevel
        -String[] preferredSports
        +joinCommunity()
        +leaveCommunity()
        +bookVenue()
        +participateInActivity()
    }

    class PemilikLapangan {
        -String businessLicense
        -String verificationStatus
        +addVenue()
        +updateVenueInfo()
        +manageBookings()
        +setAvailability()
    }

    class Lapangan {
        -String lapanganId
        -String name
        -String description
        -String address
        -Double latitude
        -Double longitude
        -String sportType
        -Double pricePerHour
        -String[] facilities
        -String[] photos
        -Double rating
        -Boolean isAvailable
        -String ownerId
        +updateInfo()
        +setAvailability()
        +calculatePrice()
    }

    class Komunitas {
        -String komunitasId
        -String name
        -String description
        -String sportType
        -String location
        -Integer memberCount
        -Boolean isPublic
        -Date createdDate
        -String adminId
        +addMember()
        +removeMember()
        +createActivity()
        +updateInfo()
    }

    class Postingan {
        -String postId
        -String title
        -String content
        -String authorId
        -String komunitasId
        -Date createdDate
        -Integer likes
        -Boolean isActive
        +create()
        +update()
        +delete()
        +addLike()
        +addComment()
    }

    class Komentar {
        -String commentId
        -String content
        -String authorId
        -String postId
        -Date createdDate
        +create()
        +update()
        +delete()
    }

    class Like {
        -String likeId
        -String userId
        -String postId
        -Date createdDate
        +addLike()
        +removeLike()
    }

    class Booking {
        -String bookingId
        -String userId
        -String lapanganId
        -Date bookingDate
        -Time startTime
        -Time endTime
        -Double totalPrice
        -String status
        -String paymentStatus
        +createBooking()
        +cancelBooking()
        +confirmPayment()
    }

    class Aktivitas {
        -String activityId
        -String title
        -String description
        -String komunitasId
        -String lapanganId
        -Date scheduledDate
        -Integer maxParticipants
        -Integer currentParticipants
        -String createdBy
        +createActivity()
        +joinActivity()
        +leaveActivity()
        +updateDetails()
    }

    class Reward {
        -String rewardId
        -String name
        -String description
        -Integer pointsRequired
        -String category
        -Boolean isActive
        +redeem()
        +updateInfo()
    }

    class UserReward {
        -String userRewardId
        -String userId
        -String rewardId
        -Date redeemedDate
        -String status
        +redeemReward()
        +trackStatus()
    }

    class Point {
        -String pointId
        -String userId
        -Integer points
        -String source
        -Date earnedDate
        +addPoints()
        +deductPoints()
        +getBalance()
    }

    class Sarana {
        -String saranaId
        -String name
        -String description
        -String lapanganId
        -Boolean isAvailable
        +updateAvailability()
    }

    class GroupOlahraga {
        -String groupId
        -String name
        -String description
        -String sportType
        -String createdBy
        -Integer memberLimit
        -Integer currentMembers
        +createGroup()
        +joinGroup()
        +leaveGroup()
    }

    class WebContent {
        -String contentId
        -String title
        -String content
        -String contentType
        -Date publishDate
        -Boolean isPublished
        +publish()
        +update()
        +archive()
    }

    class DataSarana {
        -String dataId
        -String saranaId
        -Date maintenanceDate
        -String condition
        -String notes
        +updateCondition()
        +scheduleMaintenance()
    }

    %% Relationships
    User <|-- Admin
    User <|-- SportsEnthusiast
    User <|-- PemilikLapangan

    PemilikLapangan "1" --o "many" Lapangan
    Lapangan "1" --o "many" Sarana
    Lapangan "1" --o "many" Booking
    Lapangan "1" --o "many" Aktivitas

    SportsEnthusiast "1" --o "many" Komunitas
    SportsEnthusiast "1" --o "many" Booking
    SportsEnthusiast "1" --o "many" Aktivitas
    SportsEnthusiast "1" --o "many" GroupOlahraga

    Komunitas "1" --o "many" Postingan
    Komunitas "1" --o "many" Aktivitas

    Postingan "1" --o "many" Komentar
    Postingan "1" --o "many" Like

    User "1" --o "many" Postingan
    User "1" --o "many" Komentar
    User "1" --o "many" Like
    User "1" --o "many" Point
    User "1" --o "many" UserReward

    Reward "1" --o "many" UserReward
    Sarana "1" --o "many" DataSarana

    Admin "1" --o "many" WebContent

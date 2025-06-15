@startuml SportSpace_ClassDiagram

!define ENTITY_COLOR #E1F5FE
!define USER_COLOR #FFF3E0
!define SYSTEM_COLOR #F3E5F5

' ===== USER CLASSES =====
abstract class User   {
  - userId: String
  - username: String
  - email: String
  - password: String
  - fullName: String
  - phoneNumber: String
  - profilePicture: String
  - dateJoined: Date
  - isActive: Boolean
  --
  + login(): Boolean
  + logout(): void
  + updateProfile(): void
  + verifyAccount(): Boolean
  + {abstract} getRole(): String
}

class Admin   {
  - adminId: String
  - permissions: List<String>
  - accessLevel: Integer
  --
  + manageUsers(): void
  + manageContent(): void
  + generateReports(): Report
  + moderateContent(): void
  + banUser(userId: String): void
  + getRole(): String
}

class SportsEnthusiast   {
  - interests: List<String>
  - skillLevel: String
  - preferredSports: List<String>
  - totalPoints: Integer
  --
  + joinCommunity(komunitas: Komunitas): void
  + leaveCommunity(komunitas: Komunitas): void
  + bookVenue(lapangan: Lapangan): Booking
  + participateInActivity(activity: Aktivitas): void
  + getRole(): String
}

class PemilikLapangan   {
  - businessLicense: String
  - verificationStatus: String
  - taxNumber: String
  --
  + addVenue(): Lapangan
  + updateVenueInfo(lapangan: Lapangan): void
  + manageBookings(): List<Booking>
  + setAvailability(lapangan: Lapangan): void
  + getRole(): String
}

' ===== CORE BUSINESS CLASSES =====
class Lapangan   {
  - lapanganId: String
  - name: String
  - description: String
  - address: String
  - latitude: Double
  - longitude: Double
  - sportType: String
  - pricePerHour: Double
  - facilities: List<String>
  - photos: List<String>
  - rating: Double
  - isAvailable: Boolean
  - createdDate: Date
  --
  + updateInfo(): void
  + setAvailability(status: Boolean): void
  + calculatePrice(hours: Integer): Double
  + addPhoto(photo: String): void
  + updateRating(newRating: Double): void
}

class Komunitas   {
  - komunitasId: String
  - name: String
  - description: String
  - sportType: String
  - location: String
  - memberCount: Integer
  - maxMembers: Integer
  - isPublic: Boolean
  - createdDate: Date
  --
  + addMember(user: SportsEnthusiast): Boolean
  + removeMember(user: SportsEnthusiast): Boolean
  + createActivity(): Aktivitas
  + updateInfo(): void
  + isFull(): Boolean
}

class Aktivitas   {
  - activityId: String
  - title: String
  - description: String
  - scheduledDate: Date
  - startTime: Time
  - endTime: Time
  - maxParticipants: Integer
  - currentParticipants: Integer
  - status: String
  - requirements: String
  --
  + createActivity(): void
  + joinActivity(user: SportsEnthusiast): Boolean
  + leaveActivity(user: SportsEnthusiast): Boolean
  + updateDetails(): void
  + isAvailable(): Boolean
}

class Booking   {
  - bookingId: String
  - bookingDate: Date
  - startTime: Time
  - endTime: Time
  - totalPrice: Double
  - status: String
  - paymentStatus: String
  - bookingTime: DateTime
  - notes: String
  --
  + createBooking(): Boolean
  + cancelBooking(): Boolean
  + confirmPayment(): Boolean
  + calculateTotal(): Double
  + isActive(): Boolean
}

' ===== CONTENT MANAGEMENT =====
class Postingan   {
  - postId: String
  - title: String
  - content: String
  - createdDate: Date
  - updatedDate: Date
  - likes: Integer
  - views: Integer
  - isActive: Boolean
  - isPinned: Boolean
  --
  + create(): Boolean
  + update(): Boolean
  + delete(): Boolean
  + pin(): void
  + incrementViews(): void
}

class Komentar   {
  - commentId: String
  - content: String
  - createdDate: Date
  - updatedDate: Date
  - likes: Integer
  - parentCommentId: String
  --
  + create(): Boolean
  + update(): Boolean
  + delete(): Boolean
  + reply(comment: Komentar): Komentar
}

class Like   {
  - likeId: String
  - createdDate: Date
  - type: String
  --
  + addLike(): Boolean
  + removeLike(): Boolean
}

' ===== REWARD SYSTEM =====
class Reward   {
  - rewardId: String
  - name: String
  - description: String
  - pointsRequired: Integer
  - category: String
  - stockQuantity: Integer
  - isActive: Boolean
  - expiryDate: Date
  --
  + redeem(): Boolean
  + updateInfo(): void
  + checkAvailability(): Boolean
}

class UserReward   {
  - userRewardId: String
  - redeemedDate: Date
  - status: String
  - usedDate: Date
  - expiryDate: Date
  --
  + redeemReward(): Boolean
  + useReward(): Boolean
  + trackStatus(): String
}

class Point   {
  - pointId: String
  - points: Integer
  - source: String
  - earnedDate: Date
  - description: String
  - isActive: Boolean
  --
  + addPoints(amount: Integer): void
  + deductPoints(amount: Integer): Boolean
  + getBalance(): Integer
}

' ===== SUPPORT CLASSES =====
class Sarana   {
  - saranaId: String
  - name: String
  - description: String
  - category: String
  - condition: String
  - isAvailable: Boolean
  - purchaseDate: Date
  --
  + updateAvailability(status: Boolean): void
  + updateCondition(condition: String): void
}

class DataSarana   {
  - dataId: String
  - maintenanceDate: Date
  - condition: String
  - notes: String
  - cost: Double
  - nextMaintenanceDate: Date
  --
  + updateCondition(): void
  + scheduleMaintenance(): void
  + calculateMaintenanceCost(): Double
}

class GroupOlahraga   {
  - groupId: String
  - name: String
  - description: String
  - sportType: String
  - memberLimit: Integer
  - currentMembers: Integer
  - isPrivate: Boolean
  - createdDate: Date
  --
  + createGroup(): Boolean
  + joinGroup(user: SportsEnthusiast): Boolean
  + leaveGroup(user: SportsEnthusiast): Boolean
  + inviteMember(user: SportsEnthusiast): void
}

class WebContent   {
  - contentId: String
  - title: String
  - content: String
  - contentType: String
  - publishDate: Date
  - isPublished: Boolean
  - viewCount: Integer
  --
  + publish(): Boolean
  + update(): Boolean
  + archive(): Boolean
  + incrementViews(): void
}

' ===== INHERITANCE RELATIONSHIPS =====
User <|-- Admin
User <|-- SportsEnthusiast
User <|-- PemilikLapangan

' ===== COMPOSITION RELATIONSHIPS (Strong ownership - diamond filled) =====
' Lapangan terdiri dari Sarana (jika lapangan dihapus, sarana juga terhapus)
Lapangan *-- "1..*" Sarana : contains

' Komunitas terdiri dari Postingan (jika komunitas dihapus, postingan juga terhapus)
Komunitas *-- "0..*" Postingan : contains

' Postingan terdiri dari Komentar (jika postingan dihapus, komentar juga terhapus)
Postingan *-- "0..*" Komentar : contains

' Sarana memiliki DataSarana (strong relationship untuk maintenance data)
Sarana *-- "0..*" DataSarana : maintenance_data

' ===== AGGREGATION RELATIONSHIPS (Weak ownership - diamond empty) =====
' PemilikLapangan memiliki Lapangan (lapangan bisa exist tanpa pemilik)
PemilikLapangan o-- "0..*" Lapangan : owns

' SportsEnthusiast adalah bagian dari Komunitas (user bisa exist tanpa komunitas)
SportsEnthusiast o-- "0..*" Komunitas : member_of

' SportsEnthusiast adalah bagian dari GroupOlahraga
SportsEnthusiast o-- "0..*" GroupOlahraga : member_of

' User memiliki Point (user bisa exist tanpa point)
User o-- "0..*" Point : earns

' ===== ASSOCIATION RELATIONSHIPS (Regular relationships) =====
' User membuat Postingan
User --> "0..*" Postingan : creates

' User membuat Komentar
User --> "0..*" Komentar : writes

' User memberikan Like
User --> "0..*" Like : gives

' SportsEnthusiast membuat Booking
SportsEnthusiast --> "0..*" Booking : makes

' Booking untuk Lapangan
Booking --> "1" Lapangan : books

' Aktivitas menggunakan Lapangan
Aktivitas --> "0..1" Lapangan : uses

' Komunitas mengadakan Aktivitas
Komunitas --> "0..*" Aktivitas : organizes

' SportsEnthusiast ikut Aktivitas
SportsEnthusiast "0..*" --> "0..*" Aktivitas : participates

' Postingan menerima Like
Postingan --> "0..*" Like : receives

' Komentar menerima Like
Komentar --> "0..*" Like : receives

' Admin mengelola WebContent
Admin --> "0..*" WebContent : manages

' ===== DEPENDENCY RELATIONSHIPS (Uses/depends on) =====
' UserReward depends on User and Reward
User ..> UserReward : redeems
Reward ..> UserReward : granted_as

' Point system dependencies
Point ..> Reward : redeemable_for
UserReward ..> Point : costs



@enduml
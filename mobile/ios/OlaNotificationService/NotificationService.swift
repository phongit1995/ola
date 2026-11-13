import Intents
import UIKit
import UserNotifications

final class NotificationService: UNNotificationServiceExtension {
  private static let downloadTimeout: TimeInterval = 20
  private static let avatarSize = CGSize(width: 192, height: 192)

  private var contentHandler: ((UNNotificationContent) -> Void)?
  private var bestAttempt: UNMutableNotificationContent?

  override func didReceive(
    _ request: UNNotificationRequest,
    withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void
  ) {
    guard let content = request.content.mutableCopy() as? UNMutableNotificationContent else {
      contentHandler(request.content)
      return
    }
    self.contentHandler = contentHandler
    bestAttempt = content

    let imageURL = Self.url(content.userInfo["imageUrl"])
    let avatarURL = Self.url(content.userInfo["senderAvatar"])
    let group = DispatchGroup()
    var imageFile: URL?
    var avatarData: Data?

    if let imageURL {
      group.enter()
      Self.downloadImage(imageURL, maxSide: nil) { image in
        imageFile = image.flatMap(Self.writeTemporaryJPEG)
        group.leave()
      }
    }
    if let avatarURL {
      group.enter()
      Self.downloadImage(avatarURL, maxSide: Self.avatarSize.width) { image in
        avatarData = image?.pngData()
        group.leave()
      }
    }

    group.notify(queue: .main) { [weak self] in
      guard let self else { return }
      if let imageFile,
         let attachment = try? UNNotificationAttachment(identifier: "image", url: imageFile) {
        content.attachments = [attachment]
      }
      self.finish(Self.communicationContent(from: content, avatar: avatarData) ?? content)
    }
  }

  override func serviceExtensionTimeWillExpire() {
    DispatchQueue.main.async { [weak self] in
      guard let self, let bestAttempt = self.bestAttempt else { return }
      self.finish(bestAttempt)
    }
  }

  private func finish(_ content: UNNotificationContent) {
    guard let handler = contentHandler else { return }
    contentHandler = nil
    handler(content)
  }

  private static func url(_ value: Any?) -> URL? {
    guard let raw = value as? String, !raw.isEmpty else { return nil }
    return URL(string: raw)
  }

  private static func downloadImage(
    _ url: URL,
    maxSide: CGFloat?,
    completion: @escaping (UIImage?) -> Void
  ) {
    var request = URLRequest(url: url)
    request.timeoutInterval = downloadTimeout
    URLSession.shared.dataTask(with: request) { data, response, _ in
      guard let data,
            let http = response as? HTTPURLResponse,
            (200..<300).contains(http.statusCode),
            let image = UIImage(data: data) else {
        completion(nil)
        return
      }
      completion(maxSide.map { resized(image, maxSide: $0) } ?? image)
    }.resume()
  }

  private static func resized(_ image: UIImage, maxSide: CGFloat) -> UIImage {
    let longest = max(image.size.width, image.size.height)
    guard longest > maxSide else { return image }
    let scale = maxSide / longest
    let size = CGSize(width: image.size.width * scale, height: image.size.height * scale)
    return UIGraphicsImageRenderer(size: size).image { _ in
      image.draw(in: CGRect(origin: .zero, size: size))
    }
  }

  private static func writeTemporaryJPEG(_ image: UIImage) -> URL? {
    guard let data = image.jpegData(compressionQuality: 0.85) else { return nil }
    let file = FileManager.default.temporaryDirectory
      .appendingPathComponent(UUID().uuidString)
      .appendingPathExtension("jpg")
    do {
      try data.write(to: file)
      return file
    } catch {
      return nil
    }
  }

  private static func communicationContent(
    from content: UNMutableNotificationContent,
    avatar: Data?
  ) -> UNNotificationContent? {
    guard #available(iOSApplicationExtension 15.0, *),
          content.userInfo["type"] as? String == "dm",
          let senderId = content.userInfo["senderId"] as? String,
          !senderId.isEmpty else {
      return nil
    }
    let image = avatar.map { INImage(imageData: $0) }
    let sender = INPerson(
      personHandle: INPersonHandle(value: senderId, type: .unknown),
      nameComponents: nil,
      displayName: content.title,
      image: image,
      contactIdentifier: nil,
      customIdentifier: senderId
    )
    let intent = INSendMessageIntent(
      recipients: nil,
      outgoingMessageType: .outgoingMessageText,
      content: content.body,
      speakableGroupName: nil,
      conversationIdentifier: content.userInfo["conversationId"] as? String,
      serviceName: nil,
      sender: sender,
      attachments: nil
    )
    if let image {
      intent.setImage(image, forParameterNamed: \.sender)
    }
    let interaction = INInteraction(intent: intent, response: nil)
    interaction.direction = .incoming
    interaction.donate(completion: nil)
    guard let updated = try? content.updating(from: intent),
          let merged = updated.mutableCopy() as? UNMutableNotificationContent else {
      return nil
    }
    merged.attachments = content.attachments
    return merged
  }
}

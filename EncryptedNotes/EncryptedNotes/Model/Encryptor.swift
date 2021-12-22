import Foundation
import CryptoKit

final class Encryptor {
		
	init() {

	}
	
	private static func createKey(text: String) -> SymmetricKey {
		let keyData = Data(SHA256.hash(data: Data(text.utf8)))
		return SymmetricKey(data: keyData)
	}
	
	public static func encrypt(password: String, text: String) throws -> String {
		let key = createKey(text: password)
		let sealBox = try AES.GCM.seal(Data(text.utf8), using: key)
		let encrypted =  sealBox.combined!.base64EncodedString()
		return encrypted
	}
	
	public static func decrypt(cipherText: String, password: String) throws -> String {
		let key = createKey(text: password)
		guard let data = Data(base64Encoded: cipherText) else {
			return "Could not decode text: \(cipherText)"
		}
		let sealedBox: AES.GCM.SealedBox
		do {
			sealedBox = try AES.GCM.SealedBox(combined: data)
		} catch {
			return "Error decrypting message: \(error.localizedDescription)"
		}
		let decryptedData = try AES.GCM.open(sealedBox, using: key)
		guard let text = String(data: decryptedData, encoding: .utf8) else {
			return "Could not decode data: \(decryptedData)"
		}
		return text
	}
	
}

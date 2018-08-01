//
//  String + Ext.swift
//  Airbuk
//
//  Created by Apple on 20/10/16.
//  Copyright © 2016 Apple. All rights reserved.
//

import UIKit

extension String {
    
    var localized: String {
        //return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
         return LanguageManager.sharedInstance.getTranslationForKey(self, value: self)
    }
//    func localized() -> String {
//        return LanguageManager.sharedInstance.getTranslationForKey(self, value: self)
//    }

    subscript (i: Int) -> Character {
        return self[self.index(self.startIndex, offsetBy: i)]
    }
    
    subscript (i: Int) -> String {
        return String(self[i] as Character)
    }
    
    func getHeightWithConstrainedWidth(_ width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: font], context: nil)
        return ceil(boundingBox.height + 1)
    }
    
    func isValidEmail() -> Bool {
        do {
            let regex = try NSRegularExpression(pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}", options: .caseInsensitive)
            return regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.characters.count)) != nil
        } catch {
            return false
        }
    }
    
    var html2AttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            return try NSAttributedString(data: Data(utf8),
                                          options: [.documentType: NSAttributedString.DocumentType.html,
                                                    .characterEncoding: String.Encoding.utf8.rawValue],
                                          documentAttributes: nil)
        } catch {
            print("error: ", error)
            return nil
        }
    }
    
    var html2String: String {
        return html2AttributedString?.string ?? ""
    }
    
    func chopPrefix(_ count: Int = 1) -> String {
        return substring(from: characters.index(startIndex, offsetBy: count))
    }
    
    func range(from nsRange: NSRange) -> Range<String.Index>? {
        guard
            let from16 = utf16.index(utf16.startIndex, offsetBy: nsRange.location, limitedBy: utf16.endIndex),
            let to16 = utf16.index(from16, offsetBy: nsRange.length, limitedBy: utf16.endIndex),
            let from = String.Index(from16, within: self),
            let to = String.Index(to16, within: self)
            else { return nil }
        return from ..< to
    }
    
    func withAttributes(_ arrAttributes: [NSAttributedStringKey: Any]) -> NSMutableAttributedString {
        return NSMutableAttributedString(string: self, attributes: arrAttributes)
    }
    
    func custom(color: UIColor?, fontName: String?, fontSize: CGFloat?, lineSpacing: CGFloat?) -> NSMutableAttributedString {
        var attrDict = Dictionary<NSAttributedStringKey, Any>()
        if color != nil {
            attrDict[NSAttributedStringKey.foregroundColor] = color!
        }
        if fontName != nil && fontSize != nil {
            attrDict[NSAttributedStringKey.font] = UIFont(name: fontName!, size: fontSize!)!
        }
        if lineSpacing != nil {
            let paraStyle = NSMutableParagraphStyle()
            paraStyle.lineSpacing = lineSpacing!
            attrDict[NSAttributedStringKey.paragraphStyle] = paraStyle
        }
        return self.withAttributes(attrDict)
    }
    
    func setLineSpacing(_ spacing: CGFloat) -> NSMutableAttributedString {
        let paraStyle = NSMutableParagraphStyle()
        paraStyle.lineSpacing = spacing
        return self.withAttributes([NSAttributedStringKey(rawValue: NSAttributedStringKey.paragraphStyle.rawValue): paraStyle])
    }
    
    func isValidString() -> Bool {
        
        let strCheck = self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let isValid = (strCheck.characters.count > 0 ? true : false)
        return isValid;
    }
}

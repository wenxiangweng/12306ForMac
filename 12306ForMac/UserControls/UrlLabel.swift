//
//  UrlLabel.swift
//  12306ForMac
//
//  Created by fancymax on 16/8/10.
//  Copyright © 2016年 fancy. All rights reserved.
//

import Cocoa

class UrlLabel: NSTextField {
    
    @IBInspectable var urlString:String!
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit(){
        self.isSelectable = false
        self.isEditable = false
        self.drawsBackground = false
        //        self.bordered =
        
        self.textColor = NSColor.blue
//        [self setBordered:NSNoBorder];
//        [[self cell] setControlSize:NSSmallControlSize];
//        [[self cell] setLineBreakMode:NSLineBreakByTruncatingMiddle];
    }

    override func awakeFromNib() {
        self.textColor = NSColor.blue
    }
    
    override func mouseUp(with theEvent: NSEvent) {
        var curPoint = theEvent.locationInWindow
        curPoint = self.convert(curPoint, from: nil)
        if !NSPointInRect(curPoint, self.bounds) {
            return
        }
        NSWorkspace.shared().open(URL(string: urlString)!);
    }
    
    override func resetCursorRects() {
        super.resetCursorRects()
        self.addCursorRect(self.bounds, cursor: NSCursor.pointingHand())
    }
    
}

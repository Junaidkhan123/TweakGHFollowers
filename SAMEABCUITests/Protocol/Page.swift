//
//  Page.swift
//  TweakGHFollowers
//
//  Created by Junaid Khan on 05/05/2025.
//


import Foundation
import SBTUITestTunnelClient

protocol Page {
    var app: SBTUITunneledApplication { get }
    
    @discardableResult
    func reachedPage() -> Self
    
    init(app: SBTUITunneledApplication)
}

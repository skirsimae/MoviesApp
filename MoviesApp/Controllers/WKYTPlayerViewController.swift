//
//  WKYTPlayerView.swift
//  MoviesApp
//
//  Created by SilvaKirsimae on 03/05/2020.
//  Copyright © 2020 Silva. All rights reserved.
//

import UIKit
import YoutubePlayer_in_WKWebView

class WKYTPlayerViewController: UIViewController {
    
    @IBOutlet weak var playerView: WKYTPlayerView!
    var key: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playerView.load(withVideoId: key)
    }
}

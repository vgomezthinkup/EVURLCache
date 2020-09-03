//
//  ViewController.swift
//  EVURLCache
//
//  Created by Edwin Vermeer on 11/7/15.
//  Copyright © 2015 evict. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {

    @IBOutlet weak var webView: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        webView.navigationDelegate = self
        //EVURLCache.RECREATE_CACHE_RESPONSE = false // This flag is only used for debuging the small difference between recreating a response and unarchiving a response. Recreating (which is the default) seems to be working best...
        
        
        if let url = URL(string: "https://evict.nl") {
            NSLog("navigating to \(url)")
            webView.load(URLRequest(url: url))
        }
    }

    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: ((WKNavigationActionPolicy) -> Void)) {
        if let redirectURL = EVURLCache.shouldRedirect(request: navigationAction.request) {
            let r = URLRequest(url: redirectURL)
            webView.load(r)
        }
        return

    }
    
// Other test url's that were used to debug specific situations
//    http://game.zorropk.com/gamenow/xiao5haiyanglixianji/
//    http://www.newser.com/story/229485/aetna-doing-something-about-workers-student-loans.html
//    http://www.beckershospitalreview.com/payer-issues/when-the-doctor-orders-time-in-the-park-humana-metcare-partner-for-nature-driven-prescriptions.html
//    http://www.beckershospitalreview.com/healthcare-information-technology/10-largest-hipaa-settlement-fines.html
//    http://m.newser.com/story/229485/aetna-doing-something-about-workers-student-loans.html
//    https://m.promobutler.be/api/purge-publication?publicationId=1040516&url=https%3A%2F%2Fm.promobutler.be%2Fnl%2Ffolders%2Fwoodtex%3Ffid%3D65209%26embedded%3Dtrue&linksVersion=29
}

//
//  DetailViewController.swift
//  Spotify
//
//  Created by Daniel Klinkert Houfer on 4/27/18.
//  Copyright © 2018 Daniel Klinkert Houfer. All rights reserved.
//

import UIKit
import SafariServices

class DetailViewController: BaseUIViewController {

    @IBOutlet weak var albumLink: UIButton!
    @IBOutlet weak var albumImage: UIImageView!
    var album:Album?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.tintColor = UIColor.white
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func configureAppearance() {
        super.configureAppearance()
        albumLink.backgroundColor = UIColor.primaryColor
        title   = album?.name
        guard let album = album, let albumLink = URL(string:album.albumImageUrl) else {
            return
        }
        albumImage.af_setImage(withURL: albumLink)
    }
    
    func presentSafariViewController(url:URL) {
        let controller = SFSafariViewController(url: url)
        self.present(controller, animated: true, completion: nil)
        controller.delegate = self
    }
    
    @IBAction func ListenOfSpotifyAction(_ sender: Any) {
        guard let album = album, let albumLink = URL(string:album.link) else {
            return
        }
        presentSafariViewController(url:albumLink)
    }

}

extension DetailViewController:SFSafariViewControllerDelegate {
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
}

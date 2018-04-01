import UIKit

extension String {
    func loadImage (into imageView: UIImageView) {
        let session = URLSession.shared
        
        if let url = URL(string: self) {
            session.dataTask(with: url, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) in
                
                if error == nil, data != nil, let image = UIImage(data: data!) {
                    OperationQueue.main.addOperation {
                        imageView.image = image
                    }
                } else {
                    print("💩 error downloading image from: " + self)
                }
                
            }).resume()
        }
    }
}

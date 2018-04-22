import UIKit

extension String {
    func loadImage(into imageView: UIImageView) {
        guard let url = URL(string: self) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async() {
                imageView.image = UIImage(data: data)
            }
            }.resume()
    }
}

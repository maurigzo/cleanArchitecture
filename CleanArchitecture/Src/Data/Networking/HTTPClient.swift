protocol HTTPClient {
    func makeRequest(endpoint: String) -> AnyPublisher<Data, HTTPClientError>
}
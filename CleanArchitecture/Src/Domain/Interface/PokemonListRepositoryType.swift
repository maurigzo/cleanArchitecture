protocol PokemonListRepositoryType {
    func fetchPokemonList() async -> AnyPublisher<[Pokemon], DomainError>
}
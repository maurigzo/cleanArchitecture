protocol PokemonDataSourceType {
    func fetchPokemonList() async -> AnyPublisher<Pokemon, DomainError>
}
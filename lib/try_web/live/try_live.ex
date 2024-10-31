defmodule TryWeb.TryLive do
  use TryWeb, :live_view

  def mount(_params, _session, socket) do
    Pokemon.start()
    pokemon_info = get_new_pokemon()

    {:ok, assign(socket, pokemon_info: pokemon_info, pokemon_name: "", message: "", score: 0)}
  end

  def handle_event("guess_pokemon", %{"pokemon_name" => pokemon_name}, socket) do
    if socket.assigns.pokemon_info.name == String.downcase(pokemon_name) do
      IO.inspect(socket.assigns.pokemon_info.name, label: "Nome do Pokémon correto")
      new_pokemon_info = get_new_pokemon()
      IO.inspect(new_pokemon_info, label: "Novo Pokémon obtido")
      new_score = socket.assigns.score + 1

      {:noreply,
       assign(socket,
         pokemon_info: new_pokemon_info,
         message: "Correto! O Pokémon é #{socket.assigns.pokemon_info.name}",
         score: new_score
       )}
    else
      new_score = socket.assigns.score - 1
      {:noreply, assign(socket, message: "Errado! Tente novamente.", score: new_score)}
    end
  end

  defp get_new_pokemon do
    Pokemon.start()

    %{
      name: Pokemon.get_name(),
      types: Pokemon.get_types(),
      moves: Pokemon.get_moves(),
      species: Pokemon.get_species(),
      abilities: Pokemon.get_abilities(),
      image: Pokemon.get_image()
    }
  end

  def render(assigns) do
    ~H"""
    <header>
      <h1>Quem é esse Pokémon?</h1>
    </header>

    <main>
      <div class="pokemon-info">
        <p>Nome: <%= @pokemon_info.name %></p>
        
        <p><strong>Tipos:</strong> <%= Enum.join(@pokemon_info.types, ", ") %></p>
        
        <p><strong>Movimentos:</strong> <%= Enum.join(@pokemon_info.moves, ", ") %></p>
        
        <p><strong>Habilidades:</strong> <%= Enum.join(@pokemon_info.abilities, ", ") %></p>
         <img src={@pokemon_info.image} alt="Imagem do Pokémon" />
      </div>
      
      <div class="guess-form">
        <form phx-submit="guess_pokemon">
          <input
            name="pokemon_name"
            value={@pokemon_name}
            type="text"
            class="guess-input"
            placeholder="Digite o nome do Pokémon..."
          /> <button class="guess-button" type="submit">Chutar!</button>
        </form>
        
        <p><%= @message %></p>
        <!-- Contador de Score estilizado -->
        <div class="score-container">
          <span class="score-label">Score:</span> <span class="score-value"><%= @score %></span>
        </div>
      </div>
    </main>

    <footer>
      <p>&copy; 2024 Poke Guess</p>
    </footer>
    """
  end
end

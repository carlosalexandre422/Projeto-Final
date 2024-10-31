defmodule TryWeb.PageController do
  use TryWeb, :controller

  alias Try.PokeGuess

  def home(conn, _params) do
    Pokemon.start()
    types = Pokemon.get_types()
    moves = Pokemon.get_moves()
    specie = Pokemon.get_species()
    abilities = Pokemon.get_abilities()
    image = Pokemon.get_image()

    render(
      conn,
      :home,
      layout: false,
      types: types,
      moves: moves,
      specie: specie,
      abilities: abilities,
      image: image
    )
  end
end

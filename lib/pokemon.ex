defmodule Pokemon do
  def start() do
    pokemon = Try.get_random_pokemon()

    if Process.whereis(__MODULE__) == nil do
      Agent.start_link(fn -> pokemon end, name: __MODULE__)
    else
      Agent.stop(__MODULE__)
      start()
    end
  end

  # string
  def get_name() do
    pk = Agent.get(__MODULE__, fn map -> map end)
    pk["name"]
  end

  def get_types() do
    pk = Agent.get(__MODULE__, fn map -> map end)

    Enum.take(pk["types"], 3)
    |> Enum.reduce([], fn e, acc -> [e["type"]["name"] | acc] end)
  end

  def get_moves() do
    pk = Agent.get(__MODULE__, fn map -> map end)

    Enum.take(pk["moves"], 3)
    |> Enum.reduce([], fn e, acc -> [e["move"]["name"] | acc] end)
  end

  # string
  def get_species() do
    pk = Agent.get(__MODULE__, fn map -> map end)
    pk["species"]["name"]
  end

  def get_abilities() do
    pk = Agent.get(__MODULE__, fn map -> map end)

    Enum.take(pk["abilities"], 3)
    |> Enum.reduce([], fn e, acc -> [e["ability"]["name"] | acc] end)
  end

  def get_image() do
    pk = Agent.get(__MODULE__, fn map -> map end)

    pk["sprites"]["front_default"]
  end
end

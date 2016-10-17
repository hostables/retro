defmodule Retro.CardControllerTest do
  use Retro.ConnCase, async: true

  alias Retro.Card

  ### Test fixtures
  @card1 %{
    title: "Test Card 1"
  }
  @card2 %{
    title: "Test Card 2"
  }


  # TODO 1: Uncomment example tests, pass them then write the todo tests
  ### Index controller tests
  describe "index/2" do
    test "returns an array of cards when there are 2+ cards", %{conn: conn} do
      cards = [Card.changeset(%Card{}, @card1),
               Card.changeset(%Card{}, @card2)]

      # We need the id which was autogenerated, so we'll capture it on insert.
      # Repo.insert returns objects with metadata and atoms for keys.
      # We need no metadata and strings for keys, so we map our conversion
      # to get our expected Map
      expected = Enum.map(cards, &Repo.insert!(&1))
      |> Enum.map(&Map.take(&1, [:id, :title]))
      |> Enum.map(&Enum.reduce(&1, %{},
        fn ({key, val}, acc) ->
          Map.put(acc, Atom.to_string(key), val)
        end))

      response = conn
      |> get(card_path(conn, :index))
      |> json_response(200)

      assert response == expected
    end

    test "returns an array with 1 card when there is 1 card", %{conn: conn} do
      cards = [Card.changeset(%Card{}, @card2)]

      # We need the id which was autogenerated, so we'll capture it on insert.
      # Repo.insert returns objects with metadata and atoms for keys.
      # We need no metadata and strings for keys, so we map our conversion
      # to get our expected Map
      expected = Enum.map(cards, &Repo.insert!(&1))
      |> Enum.map(&Map.take(&1, [:id, :title]))
      |> Enum.map(&Enum.reduce(&1, %{},
        fn ({key, val}, acc) ->
          Map.put(acc, Atom.to_string(key), val)
        end))

      response = conn
      |> get(card_path(conn, :index))
      |> json_response(200)

      assert response == expected
    end

    test "returns an empty array when there are no cards", %{conn: conn} do
      expected = []
      response = conn
      |> get(card_path(conn, :index))
      |> json_response(200)

      assert response == expected
    end
  end


  ### Show controller tests
  describe "show/2" do
    test "returns a card when it exists", %{conn: conn} do
      card = Repo.insert!(%Card{title: "best test"})
      expected = %{"title" => "best test", "id" => card.id}

      response = get(conn, card_path(conn, :show, card.id))
      |> json_response(200)

      assert response == expected
    end

    test "returns a server message with 404 error when a card does not exist", %{conn: conn} do
      expected = %{
        "code" => 404,
        "description" => "Card not found.",
        "fields" => ["id"]
      }

      response = conn
      |> get(card_path(conn, :show, Ecto.UUID.generate()))
      |> json_response(404)

      assert response == expected
    end

    test "returns a server message with 400 error when a non-uuid id is provided", %{conn: conn} do
      expected = %{
        "code" => 400,
        "description" => "Invalid request.",
        "fields" => ["id"]
      }

      response = conn
      |> get(card_path(conn, :show, "Fake ID"))
      |> json_response(400)

      assert response == expected
    end
  end


  # TODO 3: Do what the test todos say
  ### Create controller tests
  describe "create/2" do
    test "returns the card with id when card is valid", %{conn: conn} do
      # TODO: uncomment this test and pass it

    end

    test "returns location header when card is valid", %{conn: conn} do
      # TODO: uncomment this test and pass it
    end

    test "returns a server message with 422 error when card is invalid", %{conn: conn} do
    end

    test "does not return a location header when card is invalid", %{conn: conn} do
    end
  end


  # TODO 4:
  ### Update controller tests
  describe "update/2" do
    test "returns updated card when valid complete card is provided", %{conn: conn} do
    end

    test "returns updated card when valid partial card is provided", %{conn: conn} do
    end

    test "returns a server message with 422 when invalid card is provided", %{conn: conn} do
    end

    test "returns server message with 404 when card is not found", %{conn: conn} do
    end

    test "returns a server message with 400 when a non-uuid id is provided", %{conn: conn} do
    end
  end


  # TODO 5:
  ### Delete controller tests
  describe "delete/2" do
    test "returns no content when card did exist", %{conn: conn} do
    end

    test "delete should return a server message with 404 error when card does not exist", %{conn: conn} do
    end

    test "delete should return a server message with 400 error when a non-uuid id is provided", %{conn: conn} do
    end
  end
end

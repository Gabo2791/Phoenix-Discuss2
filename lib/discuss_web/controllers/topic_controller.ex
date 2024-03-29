defmodule DiscussWeb.TopicController do
  @moduledoc """

  """
  use DiscussWeb, :controller

  alias Discuss.Schema.{Comment, Topic}

  plug DiscussWeb.Plugs.RequireAuth when action in [:new, :create, :edit, :update, :delete]
  plug :check_topic_owner when action in [:update, :edit, :delete]

  # Controlador que te redirige a la página principal
  def index(conn, _params) do
    topics = Repo.all(Topic)
    render(conn, "index.html", topics: topics)
  end

  def show(conn, %{"id" => topic_id}) do
    topic = Repo.get!(Topic, topic_id)
    changeset = Comment.changeset(%Comment{}, %{})
    render(conn, "show.html", topic: topic, changeset: changeset, message: nil)
  end

  # Controlador que realiza el despliegue de un formulario para ingresar nuevos tópicos
  def new(conn, _params) do
    changeset = Topic.changeset(%Topic{}, %{})
    render(conn, "new.html", changeset: changeset)
  end

  # Controlador que realiza la creación de un nuevo topico
  def create(conn, %{"topic" => topic}) do
    changeset =
      conn.assigns.user
      |> build_assoc(:topics)
      |> Topic.changeset(topic)

    # Funcion que realiza la insercion de un nuevo topico en la base de datos
    case Repo.insert(changeset) do
      {:ok, _topic} ->
        conn
        |> put_flash(:info, "Topic Created!")
        |> redirect(to: Routes.topic_path(conn, :index))

      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  # Controlador que despliega el formulario para editar tópicos existentes
  def edit(conn, %{"id" => topic_id}) do
    topic = Repo.get(Topic, topic_id)
    changeset = Topic.changeset(topic)
    render(conn, "edit.html", changeset: changeset, topic: topic)
  end

  # Controlador que realiza la actualización de los datos de un tópico en particular y lo graba en la base de datos
  def update(conn, %{"id" => topic_id, "topic" => topic}) do
    old_topic = Repo.get(Topic, topic_id)
    # changeset = Topic.changeset(old_topic, topic)

    # Usando el pipe operator, la línea anterior queda de la siguiente manera:
    changeset =
      Repo.get(Topic, topic_id)
      |> Topic.changeset(topic)

    case Repo.update(changeset) do
      {:ok, _topic} ->
        conn
        |> put_flash(:info, "Topic Updated!")
        |> redirect(to: Routes.topic_path(conn, :index))

      {:error, changeset} ->
        render(conn, "edit.html", changeset: changeset, topic: old_topic)
    end
  end

  def delete(conn, %{"id" => topic_id}) do
    Repo.get!(Topic, topic_id)
    |> Repo.delete!()

    conn
    |> put_flash(:info, "Topic Deleted!")
    |> redirect(to: Routes.topic_path(conn, :index))
  end

  def check_topic_owner(conn, _params) do
    # Pattern matching
    %{params: %{"id" => topic_id}} = conn

    if Repo.get(Topic, topic_id).user_id == conn.assigns.user.id do
      conn
    else
      conn
      |> put_flash(:error, "You cannot edit that!")
      |> redirect(to: Routes.topic_path(conn, :index))
      |> halt()
    end
  end
end

defmodule VinylizeWeb.ProductLive.FormComponent do
  use VinylizeWeb, :live_component

  alias Vinylize.Catalog

  @impl true
  def update(%{product: product} = assigns, socket) do
    changeset = Catalog.change_product(product)

    Process.sleep(250)
    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)
     |> allow_upload(:image, accept: ~w(.jpg .jpeg .png),
      max_entries: 1,
      max_file_size: 9_000_000,
      auto_upload: true,
      progress: &handle_progress/3)}
  end

  @impl true
  def handle_event("validate", %{"product" => product_params}, socket) do
    changeset =
      socket.assigns.product
      |> Catalog.change_product(product_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  @impl true
  def handle_event("save", %{"product" => product_params}, socket) do
    save_product(socket, socket.assigns.action, product_params)
  end

  defp save_product(socket, :edit, product_params) do
    case Catalog.update_product(socket.assigns.product, Map.put(product_params, "image", socket.assigns.image)) do
      {:ok, _product} ->
        {:noreply,
         socket
         |> put_flash(:info, "Product updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_product(socket, :new, product_params) do
    case Catalog.create_product(Map.put(product_params, "image", socket.assigns.image)) do
      {:ok, _product} ->
        {:noreply,
          socket
          |> put_flash(:info, "Product created successfully")
          |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end

  defp handle_progress(:image, entry, socket) do
    :timer.sleep(200)
    if entry.done? do
      path =
        consume_uploaded_entry(
          socket,
          entry,
          &upload_static_file(&1, socket)
        )
        {:noreply,
        socket
        |> put_flash(:info, "file #{entry.client_name} uploaded")
        |> assign(:image, path)}
      else
        {:noreply, socket}
    end
  end

  defp upload_static_file(%{path: path}, socket) do
    dest = Path.join("priv/static/images", Path.basename(path))
    File.cp!(path, dest)
    {:ok, Routes.static_path(socket, "/images/#{Path.basename(dest)}")}
  end

  def update_changeset(%{assigns: %{changeset: changeset}} = socket, key, value) do
    socket
    |> assign(:changeset, Ecto.Changeset.put_change(changeset, key, value))
  end

  def friendly_error(:too_large), do: "Image too large"
  def friendly_error(:too_many_files), do: "Too many files"
  def friendly_error(:not_accepted), do: "Unacceptable file type"
end

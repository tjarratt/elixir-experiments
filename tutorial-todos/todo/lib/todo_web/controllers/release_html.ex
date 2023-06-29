defmodule TodoWeb.ReleaseHTML do
  use TodoWeb, :html

  embed_templates "release_html/*"

  @doc """
  Renders a release form.
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true

  def release_form(assigns)
end

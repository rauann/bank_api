defmodule BankAPI.Accounts.Projections.Account do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:uuid, :binary_id, autogenerate: false}

  schema "accounts" do
    field :current_balance, :integer
    field :initial_balance, :integer

    timestamps()
  end

  def changeset(account, attrs) do
    account
    |> cast(attrs, [:initial_balance])
    |> validate_required([:initial_balance])
    |> validate_number(:initial_balance, greater_than: 0)
  end
end

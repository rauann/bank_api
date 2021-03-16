defmodule BankAPI.Accounts.Events.AccountOpened do
  @moduledoc """
  Note: event signifies a change that has already taken place on an aggregate.
  """
  @derive [Jason.Encoder]

  defstruct [
    :account_uuid,
    :initial_balance
  ]
end

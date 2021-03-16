defmodule BankAPI.Accounts.Projectors.AccountOpened do
  @moduledoc """
  Projector picks up the event and materializes it on the database.

  The projector is quick, but not instantaneous. We say in this case that the system behaves in an eventually consistent manner, because the account will be present at some time in the (hopefully immediate) future.
  """
  use Commanded.Projections.Ecto,
    name: "Accounts.Projectors.AccountOpened",
    application: BankAPI,
    consistency: :strong

  alias BankAPI.Accounts.Events.AccountOpened
  alias BankAPI.Accounts.Projections.Account

  project(%AccountOpened{} = evt, _metadata, fn multi ->
    Ecto.Multi.insert(multi, :account_opened, %Account{
      uuid: evt.account_uuid,
      current_balance: evt.initial_balance
    })
  end)
end

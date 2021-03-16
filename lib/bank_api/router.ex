defmodule BankAPI.Router do
  use Commanded.Commands.Router

  alias BankAPI.Accounts.Aggregates.Account
  alias BankAPI.Accounts.Commands.OpenAccount

  identify(Account, by: :account_uuid)
  dispatch([OpenAccount], to: Account)
end

defmodule BankAPI.Accounts.Aggregates.Account do
  @moduledoc """
  An aggregate is comprised of its state, public command functions, and state mutators.

  In a CQRS application all state must be derived from the published domain events. This prevents tight coupling between aggregate instances, such as querying for their state, and ensures their state isn't exposed.

  If an aggregate needs data owned by another aggregate, then you should lookup the data from a projection and include it in the command before dispatch. Usually this would be a projection into a read model built for querying. You can use Commanded Ecto projections to project events into a SQL database.
  """
  defstruct uuid: nil,
            current_balance: nil

  alias __MODULE__
  alias BankAPI.Accounts.Commands.OpenAccount
  alias BankAPI.Accounts.Events.AccountOpened

  def execute(
        %Account{uuid: nil},
        %OpenAccount{
          account_uuid: account_uuid,
          initial_balance: initial_balance
        }
      )
      when initial_balance > 0 do
    %AccountOpened{
      account_uuid: account_uuid,
      initial_balance: initial_balance
    }
  end

  def execute(
        %Account{uuid: nil},
        %OpenAccount{
          initial_balance: initial_balance
        }
      )
      when initial_balance <= 0 do
    {:error, :initial_balance_must_be_above_zero}
  end

  def execute(%Account{}, %OpenAccount{}) do
    {:error, :account_already_opened}
  end

  # state mutators

  def apply(
        %Account{} = account,
        %AccountOpened{
          account_uuid: account_uuid,
          initial_balance: initial_balance
        }
      ) do
    %Account{
      account
      | uuid: account_uuid,
        current_balance: initial_balance
    }
  end
end

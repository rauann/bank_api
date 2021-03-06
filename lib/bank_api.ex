defmodule BankAPI do
  @moduledoc """
  BankAPI keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """
  use Commanded.Application, otp_app: :bank_api

  router(BankAPI.Router)
end

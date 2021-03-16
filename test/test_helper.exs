ExUnit.start()
ExUnit.configure(formatters: [ExUnit.CLIFormatter, ExUnitNotifier])
Ecto.Adapters.SQL.Sandbox.mode(BankAPI.Repo, :manual)
# {:ok, _} = Application.ensure_all_started(:bank_api)

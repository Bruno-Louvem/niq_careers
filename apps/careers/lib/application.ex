defmodule Careers.Application do
    use Application
    require Logger

    def start (_type,_args) do
        import Supervisor.Spec, warn: false

        children = [
            supervisor(Careers.Repo,[]),
        ]

        Logger.info "Started Aplication"
        opts = [strategy: :one_for_one, name: Careers.Supervisor]

        Supervisor.start_link(children,opts)
    end
end

class Heroku::Command::Apps < Heroku::Command::Base

  # apps:status [--app APP]
  #
  # display current status of your app(s)
  #
  #Examples:
  #
  # $ heroku apps:status
  # === Apps Status
  # my-first-app: up
  # my-second-app: idle
  # my-third-app: maintenance
  # my-fourth-app: no dynos
  # ...
  #
  # $ cd my-app
  # $ heroku apps:status
  # === Apps Status
  # my-app: up
  #
  # $ heroku apps:status --app my-app
  # === Apps Status
  # my-app: up
  #
  def status
    validate_arguments!
    styled_header('Apps Status')

    if app
      response = api_request("/apps/#{app}")
      app_data = response.body
      display(app_status(app_data))
    else
      response = api_request("/apps")
      apps = response.body

      unless apps.empty?
        apps.each { |app| display(app_status(app)) }
      else
        display('You have no apps.')
      end
    end
  end

  private

    def api_request(path)
      api.request(
        :expects => 200,
        :method => :get,
        :path => path,
        :headers => {
          'Accept' => 'application/vnd.heroku+json; version=3',
          'Content-Type' => 'application/json'
        }
      )
    end

    def app_status(app)
      status = if app['maintenance']
        'maintenance'
      else
        response = api_request("/apps/#{app['name']}/dynos/web.1")
        dyno = response.body
        dyno['id'] == 'not_found' ? 'no dynos' : dyno['state']
      end

      "#{regionized_app_name(app)}: #{status}"
    end

    def app
      super
    rescue Heroku::Command::CommandFailed
      nil
    end
end

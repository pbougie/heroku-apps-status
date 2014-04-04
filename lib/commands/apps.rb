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
    init_http_client
    styled_header('Apps Status')

    if app
      response = @http.get(:path => "/apps/#{app}")
      app_data = json_decode(response.body)

      display(app_status(app_data))
    else
      response = @http.get(:path => '/apps')
      apps = json_decode(response.body)

      unless apps.empty?
        apps.each { |app| display(app_status(app)) }
      else
        display('You have no apps.')
      end
    end
  end

  private

    def init_http_client
      # Heroku API version 3 required; Heroku CLI uses version 2
      api_key = Base64.encode64(":#{Heroku::Auth.password}").strip
      headers = {
        'Accept' => 'application/vnd.heroku+json; version=3',
        'Authorization' => "Basic #{api_key}"
      }
      @http = Excon.new('https://api.heroku.com', headers: headers)
    end

    def app_status(app)
      status = if app['maintenance']
        'maintenance'
      else
        response = @http.get(:path => "/apps/#{app['name']}/dynos/web.1")
        dyno = json_decode(response.body)
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

worker_processes 3    # amount of unicorn workers to spin up
timeout 60            # restarts workers that hang for 30 seconds

if ENV['RACK_ENV'] == 'development'
  worker_processes 1
  listen "#{ENV['BOXEN_SOCKET_DIR']}/jackson", :backlog => 1024
  timeout 120
end


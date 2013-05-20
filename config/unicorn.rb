RAILS_ROOT = '/var/rails/SMSGateway/'
rails_env = ENV['RAILS_ENV'] || 'production'
worker_processes 4
preload_app true
timeout 30
listen RAILS_ROOT + 'tmp/sockets/unicorn.sock', :backlog => 64

# Set the path of the log files 
stderr_path RAILS_ROOT + 'log/unicorn.stderr.log'
stdout_path RAILS_ROOT + 'log/unicorn.stdout.log'

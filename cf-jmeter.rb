require "ruby-jmeter"

if ARGV.size != 2
  puts <<-EOF
------- CF perf test: ERROR! --------
Usage:
  bundle exec ruby cf-jmeter.rb <domain> <threads>
EOF
  exit 1
end

domain       = ARGV[0]
thread_count = ARGV[1].to_i

test do

  http_request_defaults domain: "cf-example-ruby-sinatra.#{domain}"

  threads name: 'CPU', count: thread_count, continue_forever: true, scheduler: false do
    visit name: 'CPU', url: "/simplecpuload"
  end

  threads name: 'Memory', count: thread_count, continue_forever: true, scheduler: false do
    visit name: 'Memory', url: "/mem/alloc/10/0/0"
  end

  view_results_tree
  summary_report
  graph_results
end.jmx
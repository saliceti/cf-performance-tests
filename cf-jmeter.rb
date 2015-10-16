require "ruby-jmeter"

if ARGV.size != 3
  puts <<-EOF
------- CF perf test: ERROR! --------
Usage:
  bundle exec ruby cf-jmeter.rb <domain> <threads> <loops>
EOF
  exit 1
end

domain       = ARGV[0].to_i
thread_count = ARGV[1].to_i
loop_count   = ARGV[2].to_i

test do

  threads count: thread_count, loops: loop_count do
    visit name: 'CPU', url: "http://cf-example-ruby-sinatra.#{domain}/simplecpuload"
  end

  threads count: thread_count, loops: loop_count do
    visit name: 'Memory', url: "http://cf-example-ruby-sinatra.#{domain}/mem/alloc/10/0/0"
  end

  view_results_tree
  summary_report
  graph_results
end.jmx
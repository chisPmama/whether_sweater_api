def instantiate_users
  User.create({email: "abc@def.com", password: "123", password_confirmation: "123"})
  User.create({email: "mama@def.com", password: "123", password_confirmation: "123"})
  User.create({email: "baba@def.com", password: "123", password_confirmation: "123"})
end

def instantiate_chisP
  @chisP = User.create({ "email": "chisPwants2code@goodgirl.com",
                "password": "dogeatworld",
                "password_confirmation": "dogeatworld"})
end

def login_chisP
  user_info = {
    "email": "chisPwants2code@goodgirl.com",
    "password": "dogeatworld",
  }

  post "/api/v0/sessions", params: user_info
end

def stub_mapquest
  json_response = File.read('spec/fixtures/mpls_mn_coord.json')
  stub_request(:get, "https://www.mapquestapi.com/geocoding/v1/address?key=#{Rails.application.credentials.mapquest[:key]}&location=minneapolis,mn").
  with(
    headers: {
   'Accept'=>'*/*',
   'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
   'User-Agent'=>'Faraday v2.9.0'
    }).
  to_return(status: 200, body: json_response, headers: {})
end

def stub_weatherapi
  json_response = File.read('spec/fixtures/mpls_data_5_days.json')
  stub_request(:get, "http://api.weatherapi.com/v1/forecast.json?days=5&key=#{Rails.application.credentials.weatherapi[:key]}&q=44.97902,-93.26494").
  with(
    headers: {
   'Accept'=>'*/*',
   'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
   'User-Agent'=>'Faraday v2.9.0'
    }).
  to_return(status: 200, body: json_response, headers: {})
end

def stub_directions
  json_response = File.read('spec/fixtures/mpls_to_elp_directions.json')
  stub_request(:post, "https://www.mapquestapi.com/directions/v2/route?key=#{Rails.application.credentials.mapquest[:key]}").
  with(
    body: {"locations"=>["Minneapolis,MN", "ElPaso,TX"]},
    headers: {
   'Accept'=>'*/*',
   'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
   'User-Agent'=>'Faraday v2.9.0'
    }).
  to_return(status: 200, body: json_response, headers: {})
end

RSpec.configure do |config|
  # rspec-expectations config goes here. You can use an alternate
  # assertion/expectation library such as wrong or the stdlib/minitest
  # assertions if you prefer.
  config.expect_with :rspec do |expectations|
    # This option will default to `true` in RSpec 4. It makes the `description`
    # and `failure_message` of custom matchers include text for helper methods
    # defined using `chain`, e.g.:
    #     be_bigger_than(2).and_smaller_than(4).description
    #     # => "be bigger than 2 and smaller than 4"
    # ...rather than:
    #     # => "be bigger than 2"
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  # rspec-mocks config goes here. You can use an alternate test double
  # library (such as bogus or mocha) by changing the `mock_with` option here.
  config.mock_with :rspec do |mocks|
    # Prevents you from mocking or stubbing a method that does not exist on
    # a real object. This is generally recommended, and will default to
    # `true` in RSpec 4.
    mocks.verify_partial_doubles = true
  end

  # This option will default to `:apply_to_host_groups` in RSpec 4 (and will
  # have no way to turn it off -- the option exists only for backwards
  # compatibility in RSpec 3). It causes shared context metadata to be
  # inherited by the metadata hash of host groups and examples, rather than
  # triggering implicit auto-inclusion in groups with matching metadata.
  config.shared_context_metadata_behavior = :apply_to_host_groups

# The settings below are suggested to provide a good initial experience
# with RSpec, but feel free to customize to your heart's content.
=begin
  # This allows you to limit a spec run to individual examples or groups
  # you care about by tagging them with `:focus` metadata. When nothing
  # is tagged with `:focus`, all examples get run. RSpec also provides
  # aliases for `it`, `describe`, and `context` that include `:focus`
  # metadata: `fit`, `fdescribe` and `fcontext`, respectively.
  config.filter_run_when_matching :focus

  # Allows RSpec to persist some state between runs in order to support
  # the `--only-failures` and `--next-failure` CLI options. We recommend
  # you configure your source control system to ignore this file.
  config.example_status_persistence_file_path = "spec/examples.txt"

  # Limits the available syntax to the non-monkey patched syntax that is
  # recommended. For more details, see:
  # https://rspec.info/features/3-12/rspec-core/configuration/zero-monkey-patching-mode/
  config.disable_monkey_patching!

  # Many RSpec users commonly either run the entire suite or an individual
  # file, and it's useful to allow more verbose output when running an
  # individual spec file.
  if config.files_to_run.one?
    # Use the documentation formatter for detailed output,
    # unless a formatter has already been configured
    # (e.g. via a command-line flag).
    config.default_formatter = "doc"
  end

  # Print the 10 slowest examples and example groups at the
  # end of the spec run, to help surface which specs are running
  # particularly slow.
  config.profile_examples = 10

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = :random

  # Seed global randomization in this process using the `--seed` CLI option.
  # Setting this allows you to use `--seed` to deterministically reproduce
  # test failures related to randomization by passing the same `--seed` value
  # as the one that triggered the failure.
  Kernel.srand config.seed
=end
end

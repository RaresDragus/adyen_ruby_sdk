FactoryBot.define do
  factory :browser_info, class: Adyen::Common::BrowserInfo do
    color_depth         { [1, 4, 8, 15, 16, 24, 32, 48].sample }
    java_enabled        { true }
    java_script_enabled { [true, false].sample }
    language            { 'en-US' }
    screen_height       { 1024 }
    screen_width        { 1024 }
    time_zone_offset    { 120 }

    accept_header do
      'text\/html,application\/xhtml+xml,application\/xml;q=0.9,image\/webp,image\/apng,*\/*;q=0.8'
    end
    user_agent do
      'Mozilla\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\/537.36 (KHTML, like Gecko) '\
      'Chrome\/70.0.3538.110 Safari\/537.36'
    end
  end
end

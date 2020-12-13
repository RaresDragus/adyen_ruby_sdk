require 'spec_helper'

RSpec.describe Adyen::Common::BrowserInfo, type: :model do
  it_behaves_like 'a Model with factory',              :browser_info, %i[accept_header color_depth java_script_enabled
                                                                         java_enabled language screen_height
                                                                         screen_width time_zone_offset user_agent]
  it_behaves_like 'a Model with required properties',  :browser_info, %i[accept_header color_depth language
                                                                         screen_height screen_width time_zone_offset
                                                                         user_agent]
end

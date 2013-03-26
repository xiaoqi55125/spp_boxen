require 'spec_helper'

describe 'postgis' do
  let(:facts) do
    {
      :boxen_home => '/opt/boxen'
    }
  end

  it do
    should contain_package('postgis')
  end
end

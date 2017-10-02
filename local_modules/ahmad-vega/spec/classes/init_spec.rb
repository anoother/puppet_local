require 'spec_helper'
describe 'vega' do

  context 'with defaults for all parameters' do
    it { should contain_class('vega') }
  end
end

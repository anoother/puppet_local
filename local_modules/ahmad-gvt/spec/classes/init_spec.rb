require 'spec_helper'
describe 'gvt' do

  context 'with defaults for all parameters' do
    it { should contain_class('gvt') }
  end
end

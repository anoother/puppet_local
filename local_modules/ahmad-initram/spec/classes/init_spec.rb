require 'spec_helper'
describe 'initram' do

  context 'with defaults for all parameters' do
    it { should contain_class('initram') }
  end
end

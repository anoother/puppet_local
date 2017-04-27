require 'spec_helper'
describe 'autogpu' do

  context 'with defaults for all parameters' do
    it { should contain_class('autogpu') }
  end
end

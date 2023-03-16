# To check the correct dependancies are set up for Zot.

require 'spec_helper'
describe 'zot' do
  let(:facts) { { is_virtual: false } }
  let :pre_condition do
    'file { "foo.rb":
      ensure => present,
      path => "/etc/tmp",
      notify => Service["zot"] }'
  end

  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) do
        os_facts.merge(super())
      end

      it { is_expected.to compile.with_all_deps }
      describe 'Testing the dependancies between the classes' do
        it { is_expected.to contain_class('zot::install') }
        it { is_expected.to contain_class('zot::config') }
        it { is_expected.to contain_class('zot::service') }
        it { is_expected.to contain_class('zot::install').that_comes_before('Class[zot::config]') }
        it { is_expected.to contain_class('zot::service').that_subscribes_to('Class[zot::config]') }
        it { is_expected.to contain_file('foo.rb').that_notifies('Service[zot]') }
      end
    end
  end
end

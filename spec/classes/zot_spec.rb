# frozen_string_literal: true

require 'spec_helper'

describe 'zot' do
  on_supported_os.each do |os, os_facts|
    let(:facts) { os_facts }

    context "on #{os} installed using url" do
      let(:params) do
        {
          'install_method' => 'url'
        }
      end

      it { is_expected.to compile.with_all_deps }
    end

    context "on #{os} installed with package" do
      let(:params) do
        {
          'install_method' => 'package'
        }
      end

      it { is_expected.to compile.with_all_deps }
    end
  end
end

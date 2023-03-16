# frozen_string_literal: true

# https://github.com/puppetlabs/puppet-specifications/blob/master/language/func-api.md#the-4x-api
Puppet::Functions.create_function(:"zot::to_yaml") do
  dispatch :to_yaml do
    param 'Any', :data
    optional_param 'Integer', :depth
    optional_param 'Hash', :options
  end

  def to_yaml(data, depth = 0, options = {})
    raw_yaml = data.to_yaml(options)
    stripped_yaml = raw_yaml.gsub(%r{^---\n}, '')
    ident = options.key?('indentation') ? options.indentation : 2
    prefix = ' ' * ident * depth
    stripped_yaml.gsub(%r{^.}, "#{prefix}\\0")
  end
end

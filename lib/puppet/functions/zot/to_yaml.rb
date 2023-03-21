# frozen_string_literal: true

# https://github.com/puppetlabs/puppet-specifications/blob/master/language/func-api.md#the-4x-api
Puppet::Functions.create_function(:"zot::to_yaml") do
  # @param data The data that should be transformed to YAML.
  # @param depth Optional. An Integer which described the number of space characters used to indent.
  # @param options Optional. Pass a Hash of additional options. Refer to Ruby's psych library.
  # @return Returns a String with the structured data in YAML format.
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

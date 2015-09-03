# encoding: utf-8
# copyright: 2015, Vulcano Security GmbH
# license: All rights reserved

require 'json'

class RegistryKey < Vulcano.resource(1)
  name 'registry_key'

  attr_accessor :reg_key

  def initialize(name, reg_key = nil)
    # if we have one parameter, we use it as name
    reg_key = name if reg_key == nil
    @name = name
    @reg_key = reg_key
  end

  def getRegistryValue(path, key)
    cmd = "(Get-Item 'Registry::#{path}').GetValue('#{key}')"
    command_result ||= @runner.run_command(cmd)
    val = { :exit_code => command_result.exit_status.to_i, :data => command_result.stdout }
    val
  end

  def convertValue(value)
    val = value.strip
    val = val.to_i if val.match(/^\d+$/)
  end

  # returns nil, if not existant or value
  def method_missing(meth)

    # get data
    val = getRegistryValue(@reg_key, meth)

    # verify data
    if (val[:exit_code] == 0)
      val = convertValue(val[:data])
    else
      nil
    end

  end

  def to_s
    "Registry Key #{@name}"
  end

end

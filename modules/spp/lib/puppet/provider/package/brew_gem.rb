require "puppet/provider/package/homebrew"

Puppet::Type.type(:package).provide :brew_gem, :parent => :homebrew do
  def install
    execute [ "brew", "gem", @resource[:name] ], command_opts
  end
end

title "Namespace clashing control"

control 'my_control' do
only_if { input('my_control', value: 'false') == 'false' }
  describe file("/tmp") do
    it { should be_directory }
  end
end

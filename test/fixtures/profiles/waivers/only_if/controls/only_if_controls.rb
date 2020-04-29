
# This fixture will cause a "skip due to only if" if waivers are
# not working correctly (should be waivered)
control "01_only_if" do
  only_if("test_message_from_dsl") { false }
  describe true do
    it { should eq true }
  end
end

# This fixture ensures that the namespace of the control may clash
# with inputs
control "02_only_if_namespace_clash" do
  only_if {input('02_only_if_namespace_clash', value: 'false') == 'false' }
  describe file("/tmp") do
    it { should be_directory }
  end
end

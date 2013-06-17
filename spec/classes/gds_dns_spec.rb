require 'spec_helper'

describe 'gds_dns' do
  let(:facts) {{
    :osfamily => 'Debian',
  }}

  context 'includes' do
    it { should include_class('hosts') }
    it { should contain_class('resolvconf').with_use_local(true) }
  end

  context 'server false' do
    it {
      should contain_class('gds_dns::client').with(
        :before  => 'Class[Resolvconf]',
        :require => 'Class[Hosts]', 
      )
    }
  end

  context 'server true' do
    let(:params) {{
      :server => true,
    }}

    it {
      should contain_class('gds_dns::server').with(
        :before  => 'Class[Resolvconf]',
        :require => 'Class[Hosts]', 
      )
    }
  end
end

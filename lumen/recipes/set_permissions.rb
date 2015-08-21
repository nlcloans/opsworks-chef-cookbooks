node[:deploy].each do |application, deploy|
  script "set_permissions" do
    interpreter "bash"
    user "root"
    cwd "#{deploy[:deploy_to]}/current"
    code <<-EOH
    touch storage/logs/lumen.log
    chmod -R 777 ./storage
    chmod -R 777 ./public/docs

    EOH

    log 'message' do
      message 'PERMISSIONS DONE!'
      level :info
    end

  end
end

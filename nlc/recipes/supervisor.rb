node[:deploy].each do |application, deploy|

  # INSTALL AND ADD QUEUE TO SUPERVISOR
  script "download_supervisor" do
    interpreter "bash"
    user "root"
    cwd "#{deploy[:deploy_to]}/current"
    code <<-EOH
    apt-get -y install supervisor
    EOH
  end

  # write out .env file
  template "/etc/supervisor/conf.d/queue.conf" do
    source 'supervisor.erb'
    mode '0660'
    owner deploy[:user]
    group deploy[:group]
  end

  script "run_supervisor" do
    interpreter "bash"
    user "root"
    code <<-EOH
    supervisorctl stop queue:
    supervisorctl remove queue
    supervisorctl reread
    supervisorctl add queue
    EOH
  end
  #END SUPERVISOR INSTALL

end

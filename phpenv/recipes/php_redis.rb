node[:deploy].each do |application, deploy|

  template "/etc/php5/apache2/conf.d/redis.ini" do
    source "redis.ini.erb"
    owner deploy[:user] 
    group deploy[:group]
    mode "0666"

    only_if do
     File.directory?("/etc/php5/apache2/conf.d")
    end
  end

  script "php_redis" do
    interpreter "bash"
    user "root"
    cwd "/"
    code <<-EOH
    pecl install redis
    service apache2 restart
    EOH
  end
end 
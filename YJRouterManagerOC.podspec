version = "0.0.2";

Pod::Spec.new do |s|

    s.name         = "YJRouterManagerOC"
    s.version      = version
    s.summary      = "YJRouterManagerOC iOS 路由器, Author's email:houmanager@Hotmail.com 工作地点:BeiJing"
    s.description      = <<-DESC
                        YJRouterManagerOC iOS 路由器, Author's email:houmanager@Hotmail.com 工作地点:BeiJing. 欢迎一起交流.
                        DESC
    s.homepage     = "https://github.com/YJManager/YJRouterManagerOC"
    s.license      = { :type => "MIT", :file => "LICENSE" }
    s.author       = { "houmanager" => "houmanager@Hotmail.com" }
    s.platform     = :ios, "8.0"
    s.source       = { :git => "https://github.com/YJManager/YJRouterManagerOC.git", :tag => "#{version}"}
    s.source_files  = "YJRouterManager/**/*.{h,m}"
    s.requires_arc = true

end

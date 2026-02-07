workspace "Requiem-Engine"
  configurations { "Debug", "Release", "Dist" }
  architecture "x86_64"
  startproject "application"
  toolset "clang"


project "engine"
  location "engine"
  kind "SharedLib"
  language "C++"

  -- targetdir ("bin/" .. outputDir .. "/%{prj.name}")
  -- objdir ("bin-int/" .. outputDir .. "/%{prj.name}")
  targetdir "bin/%{cfg.buildcfg}/engine"
  objdir "bin-int/%{cfg.buildcfg}/engine"


  files { "engine/src/**.h", "engine/src/**.cpp", "engine/vendor/spdlog/src/**.cpp" }

  includedirs { "$(VULKAN_SDK)/Include", "engine/src", "engine/vendor/spdlog/include/" }
  libdirs { "$(VULKAN_SDK)/Lib", "vendor/" }

  defines { "RQEXPORT", "GLFW_INCLUDE_VULKAN",  "SPDLOG_COMPILED_LIB" }

  links { "vulkan-1", }

  filter { "system:windows" }
    cppdialect "C++17"
    staticruntime "On"
    systemversion "latest"
    defines { "RQPLATFORM_WINDOWS", }
    postbuildcommands { "{COPYFILE} %{cfg.buildtarget.relpath} ../bin/%{cfg.buildcfg}/application" }
    -- postbuildcommands { "{COPY} '%{cfg.buildtarget.relpath}' ../bin/" .. outputDir .. "/Application" }
    -- postbuildcommands { "{COPYFILE} bin/Debug-windows-x86_64/Requiem/Requiem.dll bin/Debug-windows-x86_64/Application/" }
    -- postbuildcommands { "{COPYFILE} %{cfg.buildtarget.relpath} ../bin" .. outputDir .. "Application" }
  
  filter { "configurations:Debug" }
    symbols "On"
    defines { "RQDEBUG" }
  filter { "configurations:Release" }
    optimize "On"
    defines { "RQRELEASE" }
  filter { "configurations:Dist" }
    optimize "On"
    defines { "RQDIST" }


project "application"
  location "application"
  kind "ConsoleApp"
  language "C++"

  targetdir "bin/%{cfg.buildcfg}/application"
  objdir "bin-int/%{cfg.buildcfg}/application"


  files { "application/src/**.h", "application/src/**.cpp" }

  includedirs { "$(VULKAN_SDK)/Include", "engine/src", "engine/vendor/spdlog/include/" }
  libdirs { "$(VULKAN_SDK)/Lib", "bin/%{cfg.buildcfg}/engine" }

  links { "engine" }

  filter { "system:windows" }
    cppdialect "C++17"
    staticruntime "On"
    systemversion "latest"
    defines { "RQPLATFORM_WINDOWS" }
  
  filter { "configurations:Debug" }
    symbols "On"
    defines { "RQDEBUG" }
  filter { "configurations:Release" }
    optimize "On"
    defines { "RQRELEASE" }
  filter { "configurations:Dist" }
    optimize "On"
    defines { "RQDIST" }






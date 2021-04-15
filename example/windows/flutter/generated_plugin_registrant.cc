//
//  Generated file. Do not edit.
//

#include "generated_plugin_registrant.h"

#include <flutter_curiosity/curiosity_plugin.h>
#include <url_launcher_windows/url_launcher_plugin.h>

void RegisterPlugins(flutter::PluginRegistry* registry) {
  CuriosityPluginRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("CuriosityPlugin"));
  UrlLauncherPluginRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("UrlLauncherPlugin"));
}

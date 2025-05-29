//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <url_launcher_linux/url_launcher_plugin.h>
#include <zdl_erp_sdk/zdl_erp_sdk_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) url_launcher_linux_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "UrlLauncherPlugin");
  url_launcher_plugin_register_with_registrar(url_launcher_linux_registrar);
  g_autoptr(FlPluginRegistrar) zdl_erp_sdk_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "ZdlErpSdkPlugin");
  zdl_erp_sdk_plugin_register_with_registrar(zdl_erp_sdk_registrar);
}

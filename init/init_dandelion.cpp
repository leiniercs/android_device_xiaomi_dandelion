/*
   Copyright (c) 2015, The Linux Foundation. All rights reserved.
   Copyright (C) 2016 The CyanogenMod Project.
   Copyright (C) 2019 The LineageOS Project.
   Redistribution and use in source and binary forms, with or without
   modification, are permitted provided that the following conditions are
   met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above
      copyright notice, this list of conditions and the following
      disclaimer in the documentation and/or other materials provided
      with the distribution.
    * Neither the name of The Linux Foundation nor the names of its
      contributors may be used to endorse or promote products derived
      from this software without specific prior written permission.
   THIS SOFTWARE IS PROVIDED "AS IS" AND ANY EXPRESS OR IMPLIED
   WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
   MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT
   ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS
   BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
   CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
   SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
   BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
   WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
   OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN
   IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#include <cstdlib>
#include <stdlib.h>
#include <fstream>
#include <string.h>
#include <sys/sysinfo.h>
#include <unistd.h>

#include <android-base/properties.h>
#define _REALLY_INCLUDE_SYS__SYSTEM_PROPERTIES_H_
#include <sys/_system_properties.h>

#include "vendor_init.h"
#include "property_service.h"

using android::base::GetProperty;
using android::base::SetProperty;

char const *heapstartsize;
char const *heapgrowthlimit;
char const *heapsize;
char const *heapminfree;
char const *heapmaxfree;
char const *heaptargetutilization;

void property_override(std::string prop, std::string value) {
    auto pi = (prop_info*)__system_property_find(prop.c_str());

    if (pi != nullptr) {
        __system_property_update(pi, value.c_str(), value.size());
    } else {
        __system_property_add(prop.c_str(), prop.size(), value.c_str(), value.size());
    }
}

void check_device() {
    struct sysinfo sys;

    sysinfo(&sys);

    if (sys.totalram > 5072ull * 1024 * 1024) {
        // from - phone-xhdpi-6144-dalvik-heap.mk
        heapstartsize = "16m";
        heapgrowthlimit = "256m";
        heapsize = "512m";
        heaptargetutilization = "0.5";
        heapminfree = "8m";
        heapmaxfree = "32m";
    } else if (sys.totalram > 3072ull * 1024 * 1024) {
        // from - phone-xxhdpi-4096-dalvik-heap.mk
        heapstartsize = "8m";
        heapgrowthlimit = "256m";
        heapsize = "512m";
        heaptargetutilization = "0.6";
        heapminfree = "8m";
        heapmaxfree = "16m";
    } else {
        // from - phone-xhdpi-2048-dalvik-heap.mk
        heapstartsize = "8m";
        heapgrowthlimit = "192m";
        heapsize = "512m";
        heaptargetutilization = "0.75";
        heapminfree = "512k";
        heapmaxfree = "8m";
    }
}

void vendor_load_properties() {
    std::string region = GetProperty("ro.boot.hwc", "");
    std::string hwName = GetProperty("ro.boot.hwname", "");
    std::string productSKU = GetProperty("ro.boot.product.hw.sku", "");
    std::string manufacturer = "Xiaomi";
    std::string brand = "Redmi";
    std::string device = "dandelion";
    std::string name;
    std::string model;
    std::string marketName;

    // Set a friendly Build ID
    property_override("ro.build.display.id", "SQ3A.220705.004");

    // Get adecuated values Dalvik VM heap size
    check_device();

    // Set Dalvik VM heap size properties values
    property_override("dalvik.vm.heapstartsize", heapstartsize);
    property_override("dalvik.vm.heapgrowthlimit", heapgrowthlimit);
    property_override("dalvik.vm.heapsize", heapsize);
    property_override("dalvik.vm.heaptargetutilization", heaptargetutilization);
    property_override("dalvik.vm.heapminfree", heapminfree);
    property_override("dalvik.vm.heapmaxfree", heapmaxfree);

    // Set identification properties values
    if (hwName == "dandelion") {
        if (productSKU == "std" || productSKU.empty() == true) {
            if (region.substr(0, 2) == "CN") {
                name = "dandelion";
                model = "M2006C3LC";
            } else if (region == "Global") {
                name = "dandelion_global";
                model = "M2006C3LG";
            } else {
                name = "dandelion_global";
                model = "M2004C3L";
            }
            marketName = "Redmi 9A";
        }
        if (productSKU == "hcg") {
            if (region == "India_9i") {
                model = "M2006C3LII";
                marketName = "Redmi 9i";
            } else {
                model = "M2006C3LI";
                marketName = "Redmi 9A Sport";
            }
            name = "dandelion_in";
        }
        if (productSKU == "pro") {
            name = "dandelion_global";
            model = "M2006C3LVG";
            marketName = "Redmi 9AT";
        }
    } else {
        if (productSKU == "std" || productSKU.empty() == true) {
            if (region.substr(0, 2) == "CN") {
                model = "220233L2C";
            } else {
                model = "220233L2G";
            }
            name = "dandelion_c3l2";
            marketName = "Redmi 10A";
        }
        if (productSKU == "hcg") {
            name = "dandelion_id2";
            model = "220233L2I";
            marketName = "Redmi 10A Sport";
        }
    }

    // Override partitions' properties
    std::string partitions[] = { "", "odm.", "vendor.", "product.", "system.", "system_ext" };
    for (const std::string &partition : partitions) {
        property_override(std::string("ro.product.") + partition + std::string("manufacturer"), manufacturer);
        property_override(std::string("ro.product.") + partition + std::string("brand"), brand);
        property_override(std::string("ro.product.") + partition + std::string("device"), device);
        property_override(std::string("ro.product.") + partition + std::string("model"), model);
        property_override(std::string("ro.product.") + partition + std::string("name"), name);
        property_override(std::string("ro.product.") + partition + std::string("marketname"), marketName);
    }
}

package com.facebook.places.internal;

import java.util.List;

/* JADX INFO: loaded from: classes.dex */
public interface WifiScanner {
    WifiScanResult getConnectedWifi();

    List<WifiScanResult> getWifiScans();

    void initAndCheckEligibility();

    boolean isWifiScanningEnabled();
}

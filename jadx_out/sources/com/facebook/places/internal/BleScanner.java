package com.facebook.places.internal;

import java.util.List;

/* JADX INFO: loaded from: classes.dex */
public interface BleScanner {
    int getErrorCode();

    List<BluetoothScanResult> getScanResults();

    void initAndCheckEligibility();

    void startScanning();

    void stopScanning();
}

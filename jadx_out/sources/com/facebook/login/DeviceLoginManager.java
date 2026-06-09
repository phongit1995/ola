package com.facebook.login;

import android.net.Uri;
import com.facebook.login.LoginClient;
import java.util.Collection;

/* JADX INFO: loaded from: classes.dex */
public class DeviceLoginManager extends LoginManager {
    private static volatile DeviceLoginManager instance;
    private Uri deviceRedirectUri;

    public static DeviceLoginManager getInstance() {
        if (instance == null) {
            synchronized (DeviceLoginManager.class) {
                if (instance == null) {
                    instance = new DeviceLoginManager();
                }
            }
        }
        return instance;
    }

    @Override // com.facebook.login.LoginManager
    protected LoginClient.Request createLoginRequest(Collection<String> collection) {
        LoginClient.Request requestCreateLoginRequest = super.createLoginRequest(collection);
        Uri deviceRedirectUri = getDeviceRedirectUri();
        if (deviceRedirectUri != null) {
            requestCreateLoginRequest.setDeviceRedirectUriString(deviceRedirectUri.toString());
        }
        return requestCreateLoginRequest;
    }

    public Uri getDeviceRedirectUri() {
        return this.deviceRedirectUri;
    }

    public void setDeviceRedirectUri(Uri uri) {
        this.deviceRedirectUri = uri;
    }
}

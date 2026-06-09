package com.facebook.accountkit.ui;

import android.app.Activity;
import android.support.annotation.Nullable;
import com.google.android.gms.common.api.GoogleApiClient;

/* JADX INFO: loaded from: classes.dex */
abstract class ContentFragment extends LoginFragment {
    ContentFragment() {
    }

    @Nullable
    protected LoginFlowState getCurrentState() {
        Activity activity = getActivity();
        if (activity == null || !(activity instanceof AccountKitActivity)) {
            return null;
        }
        return ((AccountKitActivity) activity).getCurrentState();
    }

    @Nullable
    protected GoogleApiClient getGoogleApiClient() {
        Activity activity = getActivity();
        if (activity == null || !(activity instanceof AccountKitActivity)) {
            return null;
        }
        return ((AccountKitActivity) activity).getGoogleApiClient();
    }

    abstract LoginFlowState getLoginFlowState();

    abstract boolean isKeyboardFragment();
}

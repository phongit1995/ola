package com.facebook.accountkit.ui;

import android.app.Fragment;
import android.support.annotation.Nullable;
import com.facebook.accountkit.ui.UIManager;

/* JADX INFO: loaded from: classes.dex */
public interface AdvancedUIManager extends UIManagerStub {

    @Deprecated
    public interface AdvancedUIManagerListener extends UIManager.UIManagerListener {
    }

    @Nullable
    Fragment getActionBarFragment(LoginFlowState loginFlowState);

    void setAdvancedUIManagerListener(AdvancedUIManagerListener advancedUIManagerListener);
}

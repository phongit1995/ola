package com.facebook.accountkit.ui;

import android.app.Fragment;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.view.View;

/* JADX INFO: loaded from: classes.dex */
abstract class ViewStateFragment extends Fragment {
    private final Bundle viewState = new Bundle();
    public static final String TAG = "ViewStateFragment";
    private static final String VIEW_STATE_KEY = TAG + ".VIEW_STATE_KEY";
    protected static final String UI_MANAGER_KEY = TAG + ".UI_MANAGER_KEY";

    ViewStateFragment() {
    }

    @Nullable
    protected UIManager getUIManager() {
        return (UIManager) this.viewState.get(UI_MANAGER_KEY);
    }

    protected Bundle getViewState() {
        return this.viewState;
    }

    @Override // android.app.Fragment
    public void onActivityCreated(Bundle bundle) {
        super.onActivityCreated(bundle);
        View view = getView();
        if (view != null) {
            onViewReadyWithState(view, this.viewState);
        }
    }

    @Override // android.app.Fragment
    public void onCreate(Bundle bundle) {
        if (bundle != null) {
            this.viewState.putAll(bundle.getBundle(VIEW_STATE_KEY));
        }
        if (this.viewState.containsKey(UI_MANAGER_KEY)) {
            super.onCreate(bundle);
            setRetainInstance(true);
        } else {
            throw new RuntimeException("You must supply a UIManager to " + TAG);
        }
    }

    @Override // android.app.Fragment
    public void onSaveInstanceState(Bundle bundle) {
        bundle.putBundle(VIEW_STATE_KEY, this.viewState);
        super.onSaveInstanceState(bundle);
    }

    protected void onViewReadyWithState(View view, Bundle bundle) {
    }
}

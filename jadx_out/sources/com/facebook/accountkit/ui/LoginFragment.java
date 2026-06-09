package com.facebook.accountkit.ui;

import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

/* JADX INFO: loaded from: classes.dex */
abstract class LoginFragment extends ViewStateFragment {
    LoginFragment() {
    }

    protected abstract View createView(LayoutInflater layoutInflater, ViewGroup viewGroup, Bundle bundle);

    @Override // android.app.Fragment
    public View onCreateView(LayoutInflater layoutInflater, ViewGroup viewGroup, Bundle bundle) {
        View viewOnCreateView = super.onCreateView(layoutInflater, viewGroup, bundle);
        if (viewOnCreateView == null) {
            viewOnCreateView = createView(layoutInflater, viewGroup, bundle);
        }
        ViewUtility.applyThemeAttributes(getActivity(), getUIManager(), viewOnCreateView);
        return viewOnCreateView;
    }
}

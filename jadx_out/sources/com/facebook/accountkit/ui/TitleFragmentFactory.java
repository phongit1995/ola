package com.facebook.accountkit.ui;

import android.os.Bundle;
import android.support.annotation.NonNull;
import android.support.annotation.Nullable;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;
import com.facebook.accountkit.R;
import com.facebook.accountkit.internal.Utility;

/* JADX INFO: loaded from: classes.dex */
final class TitleFragmentFactory {

    public static class TitleFragment extends LoginFragment {
        private static final String TITLE_KEY = "title";
        private static final String TITLE_RESOURCE_ARGS_KEY = "titleResourceArgs";
        private static final String TITLE_RESOURCE_ID_KEY = "titleResourceId";
        protected TextView titleView;

        private String getTitle() {
            return getViewState().getString("title");
        }

        @Nullable
        private String[] getTitleResourceArgs() {
            return getViewState().getStringArray(TITLE_RESOURCE_ARGS_KEY);
        }

        private int getTitleResourceId() {
            return getViewState().getInt(TITLE_RESOURCE_ID_KEY);
        }

        private void updateTitleView() {
            int titleResourceId;
            if (this.titleView == null) {
                return;
            }
            String title = getTitle();
            if (Utility.isNullOrEmpty(title)) {
                titleResourceId = getTitleResourceId();
                String[] titleResourceArgs = getTitleResourceArgs();
                if (titleResourceId > 0 && titleResourceArgs != null && titleResourceArgs.length != 0 && getActivity() != null) {
                    title = getString(titleResourceId, titleResourceArgs);
                    titleResourceId = 0;
                }
            } else {
                titleResourceId = 0;
            }
            if (!Utility.isNullOrEmpty(title)) {
                this.titleView.setText(title);
            } else {
                if (titleResourceId <= 0) {
                    this.titleView.setVisibility(8);
                    return;
                }
                this.titleView.setText(titleResourceId);
            }
            this.titleView.setVisibility(0);
        }

        @Override // com.facebook.accountkit.ui.LoginFragment
        protected View createView(LayoutInflater layoutInflater, ViewGroup viewGroup, Bundle bundle) {
            return layoutInflater.inflate(R.layout.com_accountkit_fragment_title, viewGroup, false);
        }

        @Override // com.facebook.accountkit.ui.ViewStateFragment, android.app.Fragment
        public /* bridge */ /* synthetic */ void onActivityCreated(Bundle bundle) {
            super.onActivityCreated(bundle);
        }

        @Override // com.facebook.accountkit.ui.ViewStateFragment, android.app.Fragment
        public /* bridge */ /* synthetic */ void onCreate(Bundle bundle) {
            super.onCreate(bundle);
        }

        @Override // com.facebook.accountkit.ui.LoginFragment, android.app.Fragment
        public /* bridge */ /* synthetic */ View onCreateView(LayoutInflater layoutInflater, ViewGroup viewGroup, Bundle bundle) {
            return super.onCreateView(layoutInflater, viewGroup, bundle);
        }

        @Override // com.facebook.accountkit.ui.ViewStateFragment, android.app.Fragment
        public /* bridge */ /* synthetic */ void onSaveInstanceState(Bundle bundle) {
            super.onSaveInstanceState(bundle);
        }

        @Override // com.facebook.accountkit.ui.ViewStateFragment
        protected void onViewReadyWithState(View view, Bundle bundle) {
            super.onViewReadyWithState(view, bundle);
            this.titleView = (TextView) view.findViewById(R.id.com_accountkit_title);
            updateTitleView();
        }

        public void setTitle(@Nullable String str) {
            getViewState().putString("title", str);
            updateTitleView();
        }

        public void setTitleResourceId(int i, @Nullable String... strArr) {
            Bundle viewState = getViewState();
            viewState.putInt(TITLE_RESOURCE_ID_KEY, i);
            viewState.putStringArray(TITLE_RESOURCE_ARGS_KEY, strArr);
            updateTitleView();
        }
    }

    TitleFragmentFactory() {
    }

    public static TitleFragment create(@NonNull UIManager uIManager) {
        TitleFragment titleFragment = new TitleFragment();
        titleFragment.getViewState().putParcelable(ViewStateFragment.UI_MANAGER_KEY, uIManager);
        return titleFragment;
    }

    public static TitleFragment create(@NonNull UIManager uIManager, int i, @Nullable String... strArr) {
        TitleFragment titleFragmentCreate = create(uIManager);
        titleFragmentCreate.setTitleResourceId(i, strArr);
        return titleFragmentCreate;
    }
}

package com.facebook.accountkit.ui;

import android.graphics.drawable.Animatable;
import android.os.Bundle;
import android.support.annotation.NonNull;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import com.facebook.accountkit.R;

/* JADX INFO: loaded from: classes.dex */
final class StaticContentFragmentFactory {
    private static final String LAYOUT_RESOURCE_ID_KEY = "layoutResourceId";
    private static final String LOGIN_FLOW_STATE_KEY = "loginFlowState";

    public static final class StaticContentFragment extends ContentFragment {
        @Override // com.facebook.accountkit.ui.LoginFragment
        protected View createView(LayoutInflater layoutInflater, ViewGroup viewGroup, Bundle bundle) {
            return layoutInflater.inflate(getViewState().getInt(StaticContentFragmentFactory.LAYOUT_RESOURCE_ID_KEY, R.layout.com_accountkit_fragment_static_content), viewGroup, false);
        }

        @Override // com.facebook.accountkit.ui.ContentFragment
        LoginFlowState getLoginFlowState() {
            return LoginFlowState.valueOf(getViewState().getString(StaticContentFragmentFactory.LOGIN_FLOW_STATE_KEY, LoginFlowState.NONE.name()));
        }

        @Override // com.facebook.accountkit.ui.ContentFragment
        boolean isKeyboardFragment() {
            return false;
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
            View viewFindViewById = view.findViewById(R.id.com_accountkit_icon_view);
            if (viewFindViewById != null) {
                int color = ViewUtility.useLegacy(getUIManager()) ? ViewUtility.getColor(getActivity(), R.attr.com_accountkit_icon_color, -1) : ViewUtility.getPrimaryColor(getActivity(), getUIManager());
                if (!(viewFindViewById instanceof ImageView)) {
                    ViewUtility.applyThemeColor(getActivity(), viewFindViewById.getBackground(), color);
                    return;
                }
                ImageView imageView = (ImageView) viewFindViewById;
                ViewUtility.applyThemeColor(getActivity(), imageView, color);
                bundle.getString(StaticContentFragmentFactory.LOGIN_FLOW_STATE_KEY);
                if (imageView.getDrawable() instanceof Animatable) {
                    ((Animatable) imageView.getDrawable()).start();
                }
            }
        }
    }

    StaticContentFragmentFactory() {
    }

    static StaticContentFragment create(@NonNull UIManager uIManager, LoginFlowState loginFlowState) {
        StaticContentFragment staticContentFragment = new StaticContentFragment();
        Bundle viewState = staticContentFragment.getViewState();
        viewState.putParcelable(ViewStateFragment.UI_MANAGER_KEY, uIManager);
        viewState.putString(LOGIN_FLOW_STATE_KEY, loginFlowState.name());
        return staticContentFragment;
    }

    static StaticContentFragment create(@NonNull UIManager uIManager, LoginFlowState loginFlowState, int i) {
        StaticContentFragment staticContentFragmentCreate = create(uIManager, loginFlowState);
        staticContentFragmentCreate.getViewState().putInt(LAYOUT_RESOURCE_ID_KEY, i);
        return staticContentFragmentCreate;
    }
}

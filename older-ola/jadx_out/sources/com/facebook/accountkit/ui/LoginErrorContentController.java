package com.facebook.accountkit.ui;

import android.content.Intent;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.v4.content.LocalBroadcastManager;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import com.facebook.accountkit.R;
import com.facebook.accountkit.internal.AccountKitController;
import com.facebook.accountkit.ui.LoginFlowBroadcastReceiver;

/* JADX INFO: loaded from: classes.dex */
final class LoginErrorContentController extends ErrorContentController {
    private static final LoginFlowState LOGIN_FLOW_STATE = LoginFlowState.ERROR;
    private BottomFragment bottomFragment;
    private final LoginFlowState returnState;

    public static final class BottomFragment extends ContentFragment {
        private static final String RETURN_LOGIN_FLOW_STATE = TAG + ".RETURN_LOGIN_FLOW_STATE";

        @Override // com.facebook.accountkit.ui.LoginFragment
        protected View createView(LayoutInflater layoutInflater, ViewGroup viewGroup, Bundle bundle) {
            return layoutInflater.inflate(R.layout.com_accountkit_fragment_error_bottom, viewGroup, false);
        }

        @Override // com.facebook.accountkit.ui.ContentFragment
        LoginFlowState getLoginFlowState() {
            return LoginErrorContentController.LOGIN_FLOW_STATE;
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
        protected void onViewReadyWithState(View view, final Bundle bundle) {
            super.onViewReadyWithState(view, bundle);
            View viewFindViewById = view.findViewById(R.id.com_accountkit_start_over_button);
            if (viewFindViewById != null) {
                viewFindViewById.setOnClickListener(new View.OnClickListener() { // from class: com.facebook.accountkit.ui.LoginErrorContentController.BottomFragment.1
                    @Override // android.view.View.OnClickListener
                    public void onClick(View view2) {
                        AccountKitController.Logger.logUIErrorInteraction(Buttons.TRY_AGAIN.name());
                        Intent intent = new Intent(LoginFlowBroadcastReceiver.ACTION_UPDATE);
                        intent.putExtra(LoginFlowBroadcastReceiver.EXTRA_EVENT, LoginFlowBroadcastReceiver.Event.ERROR_RESTART);
                        intent.putExtra(LoginFlowBroadcastReceiver.EXTRA_RETURN_LOGIN_FLOW_STATE, (Integer) bundle.get(BottomFragment.RETURN_LOGIN_FLOW_STATE));
                        LocalBroadcastManager.getInstance(view2.getContext()).sendBroadcast(intent);
                    }
                });
            }
        }
    }

    LoginErrorContentController(LoginFlowState loginFlowState, AccountKitConfiguration accountKitConfiguration) {
        super(accountKitConfiguration);
        this.returnState = loginFlowState;
    }

    @Override // com.facebook.accountkit.ui.ContentController
    public ContentFragment getBottomFragment() {
        if (this.bottomFragment == null) {
            setBottomFragment(new BottomFragment());
        }
        return this.bottomFragment;
    }

    LoginFlowState getReturnState() {
        return this.returnState;
    }

    @Override // com.facebook.accountkit.ui.ContentController
    public void setBottomFragment(@Nullable ContentFragment contentFragment) {
        if (contentFragment instanceof BottomFragment) {
            this.bottomFragment = (BottomFragment) contentFragment;
            this.bottomFragment.getViewState().putParcelable(ViewStateFragment.UI_MANAGER_KEY, this.configuration.getUIManager());
            this.bottomFragment.getViewState().putInt(BottomFragment.RETURN_LOGIN_FLOW_STATE, this.returnState.ordinal());
        }
    }
}

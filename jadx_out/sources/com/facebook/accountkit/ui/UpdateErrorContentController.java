package com.facebook.accountkit.ui;

import android.content.Intent;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.v4.content.LocalBroadcastManager;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import com.facebook.accountkit.R;
import com.facebook.accountkit.UpdateFlowBroadcastReceiver;
import com.facebook.accountkit.internal.AccountKitController;

/* JADX INFO: loaded from: classes.dex */
final class UpdateErrorContentController extends ErrorContentController {
    private BottomFragment bottomFragment;

    public static final class BottomFragment extends ContentFragment {
        @Override // com.facebook.accountkit.ui.LoginFragment
        protected View createView(LayoutInflater layoutInflater, ViewGroup viewGroup, Bundle bundle) {
            return layoutInflater.inflate(R.layout.com_accountkit_fragment_error_bottom, viewGroup, false);
        }

        @Override // com.facebook.accountkit.ui.ContentFragment
        LoginFlowState getLoginFlowState() {
            return LoginFlowState.ERROR;
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
            View viewFindViewById = view.findViewById(R.id.com_accountkit_start_over_button);
            if (viewFindViewById != null) {
                viewFindViewById.setOnClickListener(new View.OnClickListener() { // from class: com.facebook.accountkit.ui.UpdateErrorContentController.BottomFragment.1
                    @Override // android.view.View.OnClickListener
                    public void onClick(View view2) {
                        AccountKitController.Logger.logUIErrorInteraction(Buttons.TRY_AGAIN.name());
                        LocalBroadcastManager.getInstance(view2.getContext()).sendBroadcast(new Intent(UpdateFlowBroadcastReceiver.ACTION_UPDATE).putExtra(UpdateFlowBroadcastReceiver.EXTRA_EVENT, UpdateFlowBroadcastReceiver.Event.RETRY));
                    }
                });
            }
        }
    }

    UpdateErrorContentController(AccountKitConfiguration accountKitConfiguration) {
        super(accountKitConfiguration);
    }

    @Override // com.facebook.accountkit.ui.ContentController
    public ContentFragment getBottomFragment() {
        if (this.bottomFragment == null) {
            setBottomFragment(new BottomFragment());
        }
        return this.bottomFragment;
    }

    @Override // com.facebook.accountkit.ui.ContentController
    public void setBottomFragment(@Nullable ContentFragment contentFragment) {
        if (contentFragment instanceof BottomFragment) {
            this.bottomFragment = (BottomFragment) contentFragment;
            this.bottomFragment.getViewState().putParcelable(ViewStateFragment.UI_MANAGER_KEY, this.configuration.getUIManager());
        }
    }
}

package com.facebook.accountkit.ui;

import android.os.Bundle;
import android.text.Spanned;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;
import com.facebook.accountkit.R;
import com.facebook.accountkit.internal.AccountKitController;
import com.facebook.accountkit.ui.CustomLinkMovement;

/* JADX INFO: loaded from: classes.dex */
abstract class TextContentFragment extends ContentFragment {
    private static final String CONTENT_PADDING_BOTTOM_KEY = "contentPaddingBottom";
    private static final String CONTENT_PADDING_TOP_KEY = "contentPaddingTop";
    private NextButtonTextProvider nextButtonTextProvider;
    private TextView textView;

    public interface NextButtonTextProvider {
        String getNextButtonText();
    }

    TextContentFragment() {
    }

    private void updateContentPadding() {
        if (this.textView == null) {
            return;
        }
        this.textView.setPadding(this.textView.getPaddingLeft(), getContentPaddingTop(), this.textView.getPaddingRight(), getContentPaddingBottom());
    }

    @Override // com.facebook.accountkit.ui.LoginFragment
    protected View createView(LayoutInflater layoutInflater, ViewGroup viewGroup, Bundle bundle) {
        return layoutInflater.inflate(R.layout.com_accountkit_fragment_phone_login_text, viewGroup, false);
    }

    public int getContentPaddingBottom() {
        return getViewState().getInt(CONTENT_PADDING_BOTTOM_KEY, 0);
    }

    public int getContentPaddingTop() {
        return getViewState().getInt(CONTENT_PADDING_TOP_KEY, 0);
    }

    protected abstract Spanned getText(String str);

    @Override // android.app.Fragment
    public void onStart() {
        super.onStart();
        updateText();
    }

    @Override // com.facebook.accountkit.ui.ViewStateFragment
    protected void onViewReadyWithState(View view, Bundle bundle) {
        super.onViewReadyWithState(view, bundle);
        this.textView = (TextView) view.findViewById(R.id.com_accountkit_text);
        if (this.textView != null) {
            this.textView.setMovementMethod(new CustomLinkMovement(new CustomLinkMovement.OnURLClickedListener() { // from class: com.facebook.accountkit.ui.TextContentFragment.1
                @Override // com.facebook.accountkit.ui.CustomLinkMovement.OnURLClickedListener
                public void onURLClicked(String str) {
                    AccountKitController.Logger.logUIPhoneLoginInteraction(Buttons.POLICY_LINKS.name(), str);
                }
            }));
        }
        updateContentPadding();
        updateText();
    }

    public void setContentPaddingBottom(int i) {
        getViewState().putInt(CONTENT_PADDING_BOTTOM_KEY, i);
        updateContentPadding();
    }

    public void setContentPaddingTop(int i) {
        getViewState().putInt(CONTENT_PADDING_TOP_KEY, i);
        updateContentPadding();
    }

    public void setNextButtonTextProvider(NextButtonTextProvider nextButtonTextProvider) {
        this.nextButtonTextProvider = nextButtonTextProvider;
    }

    void updateText() {
        if (this.textView == null || this.nextButtonTextProvider == null || getActivity() == null) {
            return;
        }
        this.textView.setText(getText(this.nextButtonTextProvider.getNextButtonText()));
    }
}

package com.facebook.accountkit.ui;

import android.app.Fragment;
import android.os.Parcel;
import android.os.Parcelable;
import android.support.annotation.Nullable;
import android.support.annotation.StyleRes;
import com.facebook.accountkit.AccountKitError;
import com.facebook.accountkit.ui.UIManager;

/* JADX INFO: loaded from: classes.dex */
@Deprecated
public class AdvancedUIManagerWrapper extends BaseUIManager {
    public static final Parcelable.Creator<AdvancedUIManagerWrapper> CREATOR = new Parcelable.Creator<AdvancedUIManagerWrapper>() { // from class: com.facebook.accountkit.ui.AdvancedUIManagerWrapper.1
        /* JADX WARN: Can't rename method to resolve collision */
        @Override // android.os.Parcelable.Creator
        public AdvancedUIManagerWrapper createFromParcel(Parcel parcel) {
            return new AdvancedUIManagerWrapper(parcel);
        }

        /* JADX WARN: Can't rename method to resolve collision */
        @Override // android.os.Parcelable.Creator
        public AdvancedUIManagerWrapper[] newArray(int i) {
            return new AdvancedUIManagerWrapper[i];
        }
    };
    private final AdvancedUIManager advancedUIManager;

    public AdvancedUIManagerWrapper(Parcel parcel) {
        super(parcel);
        this.advancedUIManager = (AdvancedUIManager) parcel.readParcelable(getClass().getClassLoader());
    }

    public AdvancedUIManagerWrapper(AdvancedUIManager advancedUIManager, @StyleRes int i) {
        super(i);
        this.advancedUIManager = advancedUIManager;
    }

    @Override // com.facebook.accountkit.ui.BaseUIManager, android.os.Parcelable
    public int describeContents() {
        return 0;
    }

    @Deprecated
    public AdvancedUIManager getAdvancedUIManager() {
        return this.advancedUIManager;
    }

    @Override // com.facebook.accountkit.ui.BaseUIManager, com.facebook.accountkit.ui.UIManagerStub
    @Nullable
    public Fragment getBodyFragment(LoginFlowState loginFlowState) {
        Fragment bodyFragment = this.advancedUIManager.getBodyFragment(loginFlowState);
        return bodyFragment == null ? super.getBodyFragment(loginFlowState) : bodyFragment;
    }

    @Override // com.facebook.accountkit.ui.BaseUIManager, com.facebook.accountkit.ui.UIManagerStub
    @Nullable
    public ButtonType getButtonType(LoginFlowState loginFlowState) {
        return this.advancedUIManager.getButtonType(loginFlowState);
    }

    @Override // com.facebook.accountkit.ui.BaseUIManager, com.facebook.accountkit.ui.UIManagerStub
    @Nullable
    public Fragment getFooterFragment(LoginFlowState loginFlowState) {
        Fragment footerFragment = this.advancedUIManager.getFooterFragment(loginFlowState);
        return footerFragment == null ? super.getFooterFragment(loginFlowState) : footerFragment;
    }

    @Override // com.facebook.accountkit.ui.BaseUIManager, com.facebook.accountkit.ui.UIManagerStub
    @Nullable
    public Fragment getHeaderFragment(LoginFlowState loginFlowState) {
        Fragment headerFragment = this.advancedUIManager.getHeaderFragment(loginFlowState);
        return headerFragment == null ? super.getHeaderFragment(loginFlowState) : headerFragment;
    }

    @Override // com.facebook.accountkit.ui.BaseUIManager, com.facebook.accountkit.ui.UIManagerStub
    @Nullable
    public TextPosition getTextPosition(LoginFlowState loginFlowState) {
        return this.advancedUIManager.getTextPosition(loginFlowState);
    }

    @Override // com.facebook.accountkit.ui.BaseUIManager, com.facebook.accountkit.ui.UIManagerStub
    public void onError(AccountKitError accountKitError) {
        this.advancedUIManager.onError(accountKitError);
    }

    @Override // com.facebook.accountkit.ui.BaseUIManager, com.facebook.accountkit.ui.UIManager
    public void setUIManagerListener(UIManager.UIManagerListener uIManagerListener) {
        throw new RuntimeException("Use setAdvancedUIManagerListener");
    }

    @Override // com.facebook.accountkit.ui.BaseUIManager, android.os.Parcelable
    public void writeToParcel(Parcel parcel, int i) {
        super.writeToParcel(parcel, i);
        parcel.writeParcelable(this.advancedUIManager, i);
    }
}

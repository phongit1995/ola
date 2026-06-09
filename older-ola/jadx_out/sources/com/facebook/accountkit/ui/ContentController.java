package com.facebook.accountkit.ui;

import android.app.Activity;
import android.content.Intent;
import android.support.annotation.Nullable;
import android.view.View;
import com.facebook.accountkit.ui.TitleFragmentFactory;

/* JADX INFO: loaded from: classes.dex */
interface ContentController {
    ContentFragment getBottomFragment();

    ContentFragment getCenterFragment();

    @Nullable
    View getFocusView();

    TitleFragmentFactory.TitleFragment getFooterFragment();

    TitleFragmentFactory.TitleFragment getHeaderFragment();

    LoginFlowState getLoginFlowState();

    ContentFragment getTextFragment();

    @Nullable
    ContentFragment getTopFragment();

    boolean isTransient();

    void onActivityResult(int i, int i2, Intent intent);

    void onPause(Activity activity);

    void onResume(Activity activity);

    void setBottomFragment(@Nullable ContentFragment contentFragment);

    void setCenterFragment(@Nullable ContentFragment contentFragment);

    void setFooterFragment(@Nullable TitleFragmentFactory.TitleFragment titleFragment);

    void setHeaderFragment(@Nullable TitleFragmentFactory.TitleFragment titleFragment);

    void setTextFragment(@Nullable ContentFragment contentFragment);

    void setTopFragment(@Nullable ContentFragment contentFragment);
}

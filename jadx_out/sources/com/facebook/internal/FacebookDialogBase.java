package com.facebook.internal;

import android.app.Activity;
import android.util.Log;
import com.facebook.CallbackManager;
import com.facebook.FacebookCallback;
import com.facebook.FacebookDialog;
import com.facebook.FacebookException;
import com.facebook.FacebookSdk;
import java.util.Iterator;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
public abstract class FacebookDialogBase<CONTENT, RESULT> implements FacebookDialog<CONTENT, RESULT> {
    protected static final Object BASE_AUTOMATIC_MODE = new Object();
    private static final String TAG = "FacebookDialog";
    private final Activity activity;
    private final FragmentWrapper fragmentWrapper;
    private List<FacebookDialogBase<CONTENT, RESULT>.ModeHandler> modeHandlers;
    private int requestCode;

    /* JADX INFO: Access modifiers changed from: protected */
    public abstract class ModeHandler {
        protected ModeHandler() {
        }

        public abstract boolean canShow(CONTENT content, boolean z);

        public abstract AppCall createAppCall(CONTENT content);

        public Object getMode() {
            return FacebookDialogBase.BASE_AUTOMATIC_MODE;
        }
    }

    protected FacebookDialogBase(Activity activity, int i) {
        Validate.notNull(activity, "activity");
        this.activity = activity;
        this.fragmentWrapper = null;
        this.requestCode = i;
    }

    protected FacebookDialogBase(FragmentWrapper fragmentWrapper, int i) {
        Validate.notNull(fragmentWrapper, "fragmentWrapper");
        this.fragmentWrapper = fragmentWrapper;
        this.activity = null;
        this.requestCode = i;
        if (fragmentWrapper.getActivity() == null) {
            throw new IllegalArgumentException("Cannot use a fragment that is not attached to an activity");
        }
    }

    private List<FacebookDialogBase<CONTENT, RESULT>.ModeHandler> cachedModeHandlers() {
        if (this.modeHandlers == null) {
            this.modeHandlers = getOrderedModeHandlers();
        }
        return this.modeHandlers;
    }

    private AppCall createAppCallForMode(CONTENT content, Object obj) {
        boolean z = obj == BASE_AUTOMATIC_MODE;
        AppCall appCallCreateBaseAppCall = null;
        Iterator<FacebookDialogBase<CONTENT, RESULT>.ModeHandler> it2 = cachedModeHandlers().iterator();
        while (true) {
            if (!it2.hasNext()) {
                break;
            }
            FacebookDialogBase<CONTENT, RESULT>.ModeHandler next = it2.next();
            if (z || Utility.areObjectsEqual(next.getMode(), obj)) {
                if (next.canShow(content, true)) {
                    try {
                        appCallCreateBaseAppCall = next.createAppCall(content);
                        break;
                    } catch (FacebookException e) {
                        appCallCreateBaseAppCall = createBaseAppCall();
                        DialogPresenter.setupAppCallForValidationError(appCallCreateBaseAppCall, e);
                    }
                }
            }
        }
        if (appCallCreateBaseAppCall != null) {
            return appCallCreateBaseAppCall;
        }
        AppCall appCallCreateBaseAppCall2 = createBaseAppCall();
        DialogPresenter.setupAppCallForCannotShowError(appCallCreateBaseAppCall2);
        return appCallCreateBaseAppCall2;
    }

    @Override // com.facebook.FacebookDialog
    public boolean canShow(CONTENT content) {
        return canShowImpl(content, BASE_AUTOMATIC_MODE);
    }

    protected boolean canShowImpl(CONTENT content, Object obj) {
        boolean z = obj == BASE_AUTOMATIC_MODE;
        for (FacebookDialogBase<CONTENT, RESULT>.ModeHandler modeHandler : cachedModeHandlers()) {
            if (z || Utility.areObjectsEqual(modeHandler.getMode(), obj)) {
                if (modeHandler.canShow(content, false)) {
                    return true;
                }
            }
        }
        return false;
    }

    protected abstract AppCall createBaseAppCall();

    protected Activity getActivityContext() {
        if (this.activity != null) {
            return this.activity;
        }
        if (this.fragmentWrapper != null) {
            return this.fragmentWrapper.getActivity();
        }
        return null;
    }

    protected abstract List<FacebookDialogBase<CONTENT, RESULT>.ModeHandler> getOrderedModeHandlers();

    public int getRequestCode() {
        return this.requestCode;
    }

    @Override // com.facebook.FacebookDialog
    public final void registerCallback(CallbackManager callbackManager, FacebookCallback<RESULT> facebookCallback) {
        if (!(callbackManager instanceof CallbackManagerImpl)) {
            throw new FacebookException("Unexpected CallbackManager, please use the provided Factory.");
        }
        registerCallbackImpl((CallbackManagerImpl) callbackManager, facebookCallback);
    }

    @Override // com.facebook.FacebookDialog
    public final void registerCallback(CallbackManager callbackManager, FacebookCallback<RESULT> facebookCallback, int i) {
        setRequestCode(i);
        registerCallback(callbackManager, facebookCallback);
    }

    protected abstract void registerCallbackImpl(CallbackManagerImpl callbackManagerImpl, FacebookCallback<RESULT> facebookCallback);

    protected void setRequestCode(int i) {
        if (!FacebookSdk.isFacebookRequestCode(i)) {
            this.requestCode = i;
            return;
        }
        throw new IllegalArgumentException("Request code " + i + " cannot be within the range reserved by the Facebook SDK.");
    }

    @Override // com.facebook.FacebookDialog
    public void show(CONTENT content) {
        showImpl(content, BASE_AUTOMATIC_MODE);
    }

    protected void showImpl(CONTENT content, Object obj) {
        AppCall appCallCreateAppCallForMode = createAppCallForMode(content, obj);
        if (appCallCreateAppCallForMode == null) {
            Log.e(TAG, "No code path should ever result in a null appCall");
            if (FacebookSdk.isDebugEnabled()) {
                throw new IllegalStateException("No code path should ever result in a null appCall");
            }
        } else if (this.fragmentWrapper != null) {
            DialogPresenter.present(appCallCreateAppCallForMode, this.fragmentWrapper);
        } else {
            DialogPresenter.present(appCallCreateAppCallForMode, this.activity);
        }
    }

    /* JADX WARN: Removed duplicated region for block: B:16:0x0037  */
    /* JADX WARN: Removed duplicated region for block: B:18:? A[RETURN, SYNTHETIC] */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    protected void startActivityForResult(android.content.Intent r3, int r4) {
        /*
            r2 = this;
            android.app.Activity r0 = r2.activity
            if (r0 == 0) goto La
            android.app.Activity r0 = r2.activity
            r0.startActivityForResult(r3, r4)
            goto L31
        La:
            com.facebook.internal.FragmentWrapper r0 = r2.fragmentWrapper
            if (r0 == 0) goto L33
            com.facebook.internal.FragmentWrapper r0 = r2.fragmentWrapper
            android.app.Fragment r0 = r0.getNativeFragment()
            if (r0 == 0) goto L20
            com.facebook.internal.FragmentWrapper r0 = r2.fragmentWrapper
            android.app.Fragment r0 = r0.getNativeFragment()
            r0.startActivityForResult(r3, r4)
            goto L31
        L20:
            com.facebook.internal.FragmentWrapper r0 = r2.fragmentWrapper
            android.support.v4.app.Fragment r0 = r0.getSupportFragment()
            if (r0 == 0) goto L33
            com.facebook.internal.FragmentWrapper r0 = r2.fragmentWrapper
            android.support.v4.app.Fragment r0 = r0.getSupportFragment()
            r0.startActivityForResult(r3, r4)
        L31:
            r3 = 0
            goto L35
        L33:
            java.lang.String r3 = "Failed to find Activity or Fragment to startActivityForResult "
        L35:
            if (r3 == 0) goto L45
            com.facebook.LoggingBehavior r4 = com.facebook.LoggingBehavior.DEVELOPER_ERRORS
            r0 = 6
            java.lang.Class r1 = r2.getClass()
            java.lang.String r1 = r1.getName()
            com.facebook.internal.Logger.log(r4, r0, r1, r3)
        L45:
            return
        */
        throw new UnsupportedOperationException("Method not decompiled: com.facebook.internal.FacebookDialogBase.startActivityForResult(android.content.Intent, int):void");
    }
}

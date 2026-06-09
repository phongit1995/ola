package com.facebook;

import android.annotation.SuppressLint;
import android.app.Activity;
import android.content.Context;
import android.content.ContextWrapper;
import android.content.res.TypedArray;
import android.graphics.Canvas;
import android.graphics.Typeface;
import android.support.v4.app.Fragment;
import android.support.v4.content.ContextCompat;
import android.util.AttributeSet;
import android.view.View;
import android.widget.Button;
import com.facebook.appevents.AppEventsLogger;
import com.facebook.internal.FragmentWrapper;

/* JADX INFO: loaded from: classes.dex */
public abstract class FacebookButtonBase extends Button {
    private String analyticsButtonCreatedEventName;
    private String analyticsButtonTappedEventName;
    private View.OnClickListener externalOnClickListener;
    private View.OnClickListener internalOnClickListener;
    private boolean overrideCompoundPadding;
    private int overrideCompoundPaddingLeft;
    private int overrideCompoundPaddingRight;
    private FragmentWrapper parentFragment;

    protected FacebookButtonBase(Context context, AttributeSet attributeSet, int i, int i2, String str, String str2) {
        super(context, attributeSet, 0);
        i2 = i2 == 0 ? getDefaultStyleResource() : i2;
        configureButton(context, attributeSet, i, i2 == 0 ? com.facebook.common.R.style.com_facebook_button : i2);
        this.analyticsButtonCreatedEventName = str;
        this.analyticsButtonTappedEventName = str2;
        setClickable(true);
        setFocusable(true);
    }

    private void logButtonCreated(Context context) {
        AppEventsLogger.newLogger(context).logSdkEvent(this.analyticsButtonCreatedEventName, null, null);
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void logButtonTapped(Context context) {
        AppEventsLogger.newLogger(context).logSdkEvent(this.analyticsButtonTappedEventName, null, null);
    }

    private void parseBackgroundAttributes(Context context, AttributeSet attributeSet, int i, int i2) {
        int color;
        if (isInEditMode()) {
            return;
        }
        TypedArray typedArrayObtainStyledAttributes = context.getTheme().obtainStyledAttributes(attributeSet, new int[]{android.R.attr.background}, i, i2);
        try {
            if (typedArrayObtainStyledAttributes.hasValue(0)) {
                int resourceId = typedArrayObtainStyledAttributes.getResourceId(0, 0);
                if (resourceId != 0) {
                    setBackgroundResource(resourceId);
                }
                color = typedArrayObtainStyledAttributes.getColor(0, 0);
            } else {
                color = ContextCompat.getColor(context, com.facebook.common.R.color.com_facebook_blue);
            }
            setBackgroundColor(color);
        } finally {
            typedArrayObtainStyledAttributes.recycle();
        }
    }

    @SuppressLint({"ResourceType"})
    private void parseCompoundDrawableAttributes(Context context, AttributeSet attributeSet, int i, int i2) {
        TypedArray typedArrayObtainStyledAttributes = context.getTheme().obtainStyledAttributes(attributeSet, new int[]{android.R.attr.drawableLeft, android.R.attr.drawableTop, android.R.attr.drawableRight, android.R.attr.drawableBottom, android.R.attr.drawablePadding}, i, i2);
        try {
            setCompoundDrawablesWithIntrinsicBounds(typedArrayObtainStyledAttributes.getResourceId(0, 0), typedArrayObtainStyledAttributes.getResourceId(1, 0), typedArrayObtainStyledAttributes.getResourceId(2, 0), typedArrayObtainStyledAttributes.getResourceId(3, 0));
            setCompoundDrawablePadding(typedArrayObtainStyledAttributes.getDimensionPixelSize(4, 0));
        } finally {
            typedArrayObtainStyledAttributes.recycle();
        }
    }

    private void parseContentAttributes(Context context, AttributeSet attributeSet, int i, int i2) {
        TypedArray typedArrayObtainStyledAttributes = context.getTheme().obtainStyledAttributes(attributeSet, new int[]{android.R.attr.paddingLeft, android.R.attr.paddingTop, android.R.attr.paddingRight, android.R.attr.paddingBottom}, i, i2);
        try {
            setPadding(typedArrayObtainStyledAttributes.getDimensionPixelSize(0, 0), typedArrayObtainStyledAttributes.getDimensionPixelSize(1, 0), typedArrayObtainStyledAttributes.getDimensionPixelSize(2, 0), typedArrayObtainStyledAttributes.getDimensionPixelSize(3, 0));
        } finally {
            typedArrayObtainStyledAttributes.recycle();
        }
    }

    private void parseTextAttributes(Context context, AttributeSet attributeSet, int i, int i2) {
        TypedArray typedArrayObtainStyledAttributes = context.getTheme().obtainStyledAttributes(attributeSet, new int[]{android.R.attr.textColor}, i, i2);
        try {
            setTextColor(typedArrayObtainStyledAttributes.getColorStateList(0));
            typedArrayObtainStyledAttributes.recycle();
            typedArrayObtainStyledAttributes = context.getTheme().obtainStyledAttributes(attributeSet, new int[]{android.R.attr.gravity}, i, i2);
            try {
                setGravity(typedArrayObtainStyledAttributes.getInt(0, 17));
                typedArrayObtainStyledAttributes.recycle();
                typedArrayObtainStyledAttributes = context.getTheme().obtainStyledAttributes(attributeSet, new int[]{android.R.attr.textSize, android.R.attr.textStyle, android.R.attr.text}, i, i2);
                try {
                    setTextSize(0, typedArrayObtainStyledAttributes.getDimensionPixelSize(0, 0));
                    setTypeface(Typeface.defaultFromStyle(typedArrayObtainStyledAttributes.getInt(1, 1)));
                    setText(typedArrayObtainStyledAttributes.getString(2));
                } finally {
                }
            } finally {
            }
        } finally {
        }
    }

    private void setupOnClickListener() {
        super.setOnClickListener(new View.OnClickListener() { // from class: com.facebook.FacebookButtonBase.1
            @Override // android.view.View.OnClickListener
            public void onClick(View view) {
                View.OnClickListener onClickListener;
                FacebookButtonBase.this.logButtonTapped(FacebookButtonBase.this.getContext());
                if (FacebookButtonBase.this.internalOnClickListener != null) {
                    onClickListener = FacebookButtonBase.this.internalOnClickListener;
                } else if (FacebookButtonBase.this.externalOnClickListener == null) {
                    return;
                } else {
                    onClickListener = FacebookButtonBase.this.externalOnClickListener;
                }
                onClickListener.onClick(view);
            }
        });
    }

    protected void callExternalOnClickListener(View view) {
        if (this.externalOnClickListener != null) {
            this.externalOnClickListener.onClick(view);
        }
    }

    protected void configureButton(Context context, AttributeSet attributeSet, int i, int i2) {
        parseBackgroundAttributes(context, attributeSet, i, i2);
        parseCompoundDrawableAttributes(context, attributeSet, i, i2);
        parseContentAttributes(context, attributeSet, i, i2);
        parseTextAttributes(context, attributeSet, i, i2);
        setupOnClickListener();
    }

    protected Activity getActivity() {
        boolean z;
        Context context = getContext();
        while (true) {
            z = context instanceof Activity;
            if (z || !(context instanceof ContextWrapper)) {
                break;
            }
            context = ((ContextWrapper) context).getBaseContext();
        }
        if (z) {
            return (Activity) context;
        }
        throw new FacebookException("Unable to get Activity.");
    }

    @Override // android.widget.TextView
    public int getCompoundPaddingLeft() {
        return this.overrideCompoundPadding ? this.overrideCompoundPaddingLeft : super.getCompoundPaddingLeft();
    }

    @Override // android.widget.TextView
    public int getCompoundPaddingRight() {
        return this.overrideCompoundPadding ? this.overrideCompoundPaddingRight : super.getCompoundPaddingRight();
    }

    protected abstract int getDefaultRequestCode();

    protected int getDefaultStyleResource() {
        return 0;
    }

    public Fragment getFragment() {
        if (this.parentFragment != null) {
            return this.parentFragment.getSupportFragment();
        }
        return null;
    }

    public android.app.Fragment getNativeFragment() {
        if (this.parentFragment != null) {
            return this.parentFragment.getNativeFragment();
        }
        return null;
    }

    public int getRequestCode() {
        return getDefaultRequestCode();
    }

    protected int measureTextWidth(String str) {
        return (int) Math.ceil(getPaint().measureText(str));
    }

    @Override // android.widget.TextView, android.view.View
    protected void onAttachedToWindow() {
        super.onAttachedToWindow();
        if (isInEditMode()) {
            return;
        }
        logButtonCreated(getContext());
    }

    @Override // android.widget.TextView, android.view.View
    protected void onDraw(Canvas canvas) {
        if ((getGravity() & 1) != 0) {
            int compoundPaddingLeft = getCompoundPaddingLeft();
            int compoundPaddingRight = getCompoundPaddingRight();
            int iMin = Math.min((((getWidth() - (getCompoundDrawablePadding() + compoundPaddingLeft)) - compoundPaddingRight) - measureTextWidth(getText().toString())) / 2, (compoundPaddingLeft - getPaddingLeft()) / 2);
            this.overrideCompoundPaddingLeft = compoundPaddingLeft - iMin;
            this.overrideCompoundPaddingRight = compoundPaddingRight + iMin;
            this.overrideCompoundPadding = true;
        }
        super.onDraw(canvas);
        this.overrideCompoundPadding = false;
    }

    public void setFragment(android.app.Fragment fragment) {
        this.parentFragment = new FragmentWrapper(fragment);
    }

    public void setFragment(Fragment fragment) {
        this.parentFragment = new FragmentWrapper(fragment);
    }

    protected void setInternalOnClickListener(View.OnClickListener onClickListener) {
        this.internalOnClickListener = onClickListener;
    }

    @Override // android.view.View
    public void setOnClickListener(View.OnClickListener onClickListener) {
        this.externalOnClickListener = onClickListener;
    }
}

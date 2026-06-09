package com.facebook.share.widget;

import android.app.Activity;
import android.app.Fragment;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.ContextWrapper;
import android.content.Intent;
import android.content.IntentFilter;
import android.content.res.TypedArray;
import android.os.Bundle;
import android.support.v4.content.LocalBroadcastManager;
import android.util.AttributeSet;
import android.view.View;
import android.widget.FrameLayout;
import android.widget.LinearLayout;
import android.widget.TextView;
import com.facebook.FacebookException;
import com.facebook.common.R;
import com.facebook.internal.AnalyticsEvents;
import com.facebook.internal.FragmentWrapper;
import com.facebook.internal.NativeProtocol;
import com.facebook.internal.Utility;
import com.facebook.share.internal.LikeActionController;
import com.facebook.share.internal.LikeBoxCountView;
import com.facebook.share.internal.LikeButton;

/* JADX INFO: loaded from: classes.dex */
@Deprecated
public class LikeView extends FrameLayout {
    private static final int NO_FOREGROUND_COLOR = -1;
    private AuxiliaryViewPosition auxiliaryViewPosition;
    private BroadcastReceiver broadcastReceiver;
    private LinearLayout containerView;
    private LikeActionControllerCreationCallback creationCallback;
    private int edgePadding;
    private boolean explicitlyDisabled;
    private int foregroundColor;
    private HorizontalAlignment horizontalAlignment;
    private int internalPadding;
    private LikeActionController likeActionController;
    private LikeBoxCountView likeBoxCountView;
    private LikeButton likeButton;
    private Style likeViewStyle;
    private String objectId;
    private ObjectType objectType;
    private OnErrorListener onErrorListener;
    private FragmentWrapper parentFragment;
    private TextView socialSentenceView;

    @Deprecated
    public enum AuxiliaryViewPosition {
        BOTTOM("bottom", 0),
        INLINE("inline", 1),
        TOP("top", 2);

        static AuxiliaryViewPosition DEFAULT = BOTTOM;
        private int intValue;
        private String stringValue;

        AuxiliaryViewPosition(String str, int i) {
            this.stringValue = str;
            this.intValue = i;
        }

        static AuxiliaryViewPosition fromInt(int i) {
            for (AuxiliaryViewPosition auxiliaryViewPosition : values()) {
                if (auxiliaryViewPosition.getValue() == i) {
                    return auxiliaryViewPosition;
                }
            }
            return null;
        }

        /* JADX INFO: Access modifiers changed from: private */
        public int getValue() {
            return this.intValue;
        }

        @Override // java.lang.Enum
        public String toString() {
            return this.stringValue;
        }
    }

    @Deprecated
    public enum HorizontalAlignment {
        CENTER("center", 0),
        LEFT("left", 1),
        RIGHT("right", 2);

        static HorizontalAlignment DEFAULT = CENTER;
        private int intValue;
        private String stringValue;

        HorizontalAlignment(String str, int i) {
            this.stringValue = str;
            this.intValue = i;
        }

        static HorizontalAlignment fromInt(int i) {
            for (HorizontalAlignment horizontalAlignment : values()) {
                if (horizontalAlignment.getValue() == i) {
                    return horizontalAlignment;
                }
            }
            return null;
        }

        /* JADX INFO: Access modifiers changed from: private */
        public int getValue() {
            return this.intValue;
        }

        @Override // java.lang.Enum
        public String toString() {
            return this.stringValue;
        }
    }

    private class LikeActionControllerCreationCallback implements LikeActionController.CreationCallback {
        private boolean isCancelled;

        private LikeActionControllerCreationCallback() {
        }

        public void cancel() {
            this.isCancelled = true;
        }

        @Override // com.facebook.share.internal.LikeActionController.CreationCallback
        public void onComplete(LikeActionController likeActionController, FacebookException facebookException) {
            if (this.isCancelled) {
                return;
            }
            if (likeActionController != null) {
                if (!likeActionController.shouldEnableView()) {
                    facebookException = new FacebookException("Cannot use LikeView. The device may not be supported.");
                }
                LikeView.this.associateWithLikeActionController(likeActionController);
                LikeView.this.updateLikeStateAndLayout();
            }
            if (facebookException != null && LikeView.this.onErrorListener != null) {
                LikeView.this.onErrorListener.onError(facebookException);
            }
            LikeView.this.creationCallback = null;
        }
    }

    private class LikeControllerBroadcastReceiver extends BroadcastReceiver {
        private LikeControllerBroadcastReceiver() {
        }

        @Override // android.content.BroadcastReceiver
        public void onReceive(Context context, Intent intent) {
            String action = intent.getAction();
            Bundle extras = intent.getExtras();
            boolean z = true;
            if (extras != null) {
                String string = extras.getString(LikeActionController.ACTION_OBJECT_ID_KEY);
                if (!Utility.isNullOrEmpty(string) && !Utility.areObjectsEqual(LikeView.this.objectId, string)) {
                    z = false;
                }
            }
            if (z) {
                if (!LikeActionController.ACTION_LIKE_ACTION_CONTROLLER_UPDATED.equals(action)) {
                    if (LikeActionController.ACTION_LIKE_ACTION_CONTROLLER_DID_ERROR.equals(action)) {
                        if (LikeView.this.onErrorListener != null) {
                            LikeView.this.onErrorListener.onError(NativeProtocol.getExceptionFromErrorData(extras));
                            return;
                        }
                        return;
                    } else if (!LikeActionController.ACTION_LIKE_ACTION_CONTROLLER_DID_RESET.equals(action)) {
                        return;
                    } else {
                        LikeView.this.setObjectIdAndTypeForced(LikeView.this.objectId, LikeView.this.objectType);
                    }
                }
                LikeView.this.updateLikeStateAndLayout();
            }
        }
    }

    @Deprecated
    public enum ObjectType {
        UNKNOWN("unknown", 0),
        OPEN_GRAPH("open_graph", 1),
        PAGE("page", 2);

        private int intValue;
        private String stringValue;
        public static ObjectType DEFAULT = UNKNOWN;

        ObjectType(String str, int i) {
            this.stringValue = str;
            this.intValue = i;
        }

        public static ObjectType fromInt(int i) {
            for (ObjectType objectType : values()) {
                if (objectType.getValue() == i) {
                    return objectType;
                }
            }
            return null;
        }

        public int getValue() {
            return this.intValue;
        }

        @Override // java.lang.Enum
        public String toString() {
            return this.stringValue;
        }
    }

    public interface OnErrorListener {
        void onError(FacebookException facebookException);
    }

    @Deprecated
    public enum Style {
        STANDARD("standard", 0),
        BUTTON("button", 1),
        BOX_COUNT("box_count", 2);

        private int intValue;
        private String stringValue;
        static Style DEFAULT = STANDARD;

        Style(String str, int i) {
            this.stringValue = str;
            this.intValue = i;
        }

        static Style fromInt(int i) {
            for (Style style : values()) {
                if (style.getValue() == i) {
                    return style;
                }
            }
            return null;
        }

        /* JADX INFO: Access modifiers changed from: private */
        public int getValue() {
            return this.intValue;
        }

        @Override // java.lang.Enum
        public String toString() {
            return this.stringValue;
        }
    }

    @Deprecated
    public LikeView(Context context) {
        super(context);
        this.likeViewStyle = Style.DEFAULT;
        this.horizontalAlignment = HorizontalAlignment.DEFAULT;
        this.auxiliaryViewPosition = AuxiliaryViewPosition.DEFAULT;
        this.foregroundColor = -1;
        this.explicitlyDisabled = true;
        initialize(context);
    }

    @Deprecated
    public LikeView(Context context, AttributeSet attributeSet) {
        super(context, attributeSet);
        this.likeViewStyle = Style.DEFAULT;
        this.horizontalAlignment = HorizontalAlignment.DEFAULT;
        this.auxiliaryViewPosition = AuxiliaryViewPosition.DEFAULT;
        this.foregroundColor = -1;
        this.explicitlyDisabled = true;
        parseAttributes(attributeSet);
        initialize(context);
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void associateWithLikeActionController(LikeActionController likeActionController) {
        this.likeActionController = likeActionController;
        this.broadcastReceiver = new LikeControllerBroadcastReceiver();
        LocalBroadcastManager localBroadcastManager = LocalBroadcastManager.getInstance(getContext());
        IntentFilter intentFilter = new IntentFilter();
        intentFilter.addAction(LikeActionController.ACTION_LIKE_ACTION_CONTROLLER_UPDATED);
        intentFilter.addAction(LikeActionController.ACTION_LIKE_ACTION_CONTROLLER_DID_ERROR);
        intentFilter.addAction(LikeActionController.ACTION_LIKE_ACTION_CONTROLLER_DID_RESET);
        localBroadcastManager.registerReceiver(this.broadcastReceiver, intentFilter);
    }

    private Activity getActivity() {
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

    private Bundle getAnalyticsParameters() {
        Bundle bundle = new Bundle();
        bundle.putString(AnalyticsEvents.PARAMETER_LIKE_VIEW_STYLE, this.likeViewStyle.toString());
        bundle.putString(AnalyticsEvents.PARAMETER_LIKE_VIEW_AUXILIARY_POSITION, this.auxiliaryViewPosition.toString());
        bundle.putString(AnalyticsEvents.PARAMETER_LIKE_VIEW_HORIZONTAL_ALIGNMENT, this.horizontalAlignment.toString());
        bundle.putString("object_id", Utility.coerceValueIfNullOrEmpty(this.objectId, ""));
        bundle.putString("object_type", this.objectType.toString());
        return bundle;
    }

    private void initialize(Context context) {
        this.edgePadding = getResources().getDimensionPixelSize(R.dimen.com_facebook_likeview_edge_padding);
        this.internalPadding = getResources().getDimensionPixelSize(R.dimen.com_facebook_likeview_internal_padding);
        if (this.foregroundColor == -1) {
            this.foregroundColor = getResources().getColor(R.color.com_facebook_likeview_text_color);
        }
        setBackgroundColor(0);
        this.containerView = new LinearLayout(context);
        this.containerView.setLayoutParams(new FrameLayout.LayoutParams(-2, -2));
        initializeLikeButton(context);
        initializeSocialSentenceView(context);
        initializeLikeCountView(context);
        this.containerView.addView(this.likeButton);
        this.containerView.addView(this.socialSentenceView);
        this.containerView.addView(this.likeBoxCountView);
        addView(this.containerView);
        setObjectIdAndTypeForced(this.objectId, this.objectType);
        updateLikeStateAndLayout();
    }

    private void initializeLikeButton(Context context) {
        this.likeButton = new LikeButton(context, this.likeActionController != null && this.likeActionController.isObjectLiked());
        this.likeButton.setOnClickListener(new View.OnClickListener() { // from class: com.facebook.share.widget.LikeView.1
            @Override // android.view.View.OnClickListener
            public void onClick(View view) {
                LikeView.this.toggleLike();
            }
        });
        this.likeButton.setLayoutParams(new LinearLayout.LayoutParams(-2, -2));
    }

    private void initializeLikeCountView(Context context) {
        this.likeBoxCountView = new LikeBoxCountView(context);
        this.likeBoxCountView.setLayoutParams(new LinearLayout.LayoutParams(-1, -1));
    }

    private void initializeSocialSentenceView(Context context) {
        this.socialSentenceView = new TextView(context);
        this.socialSentenceView.setTextSize(0, getResources().getDimension(R.dimen.com_facebook_likeview_text_size));
        this.socialSentenceView.setMaxLines(2);
        this.socialSentenceView.setTextColor(this.foregroundColor);
        this.socialSentenceView.setGravity(17);
        this.socialSentenceView.setLayoutParams(new LinearLayout.LayoutParams(-2, -1));
    }

    private void parseAttributes(AttributeSet attributeSet) {
        TypedArray typedArrayObtainStyledAttributes;
        if (attributeSet == null || getContext() == null || (typedArrayObtainStyledAttributes = getContext().obtainStyledAttributes(attributeSet, R.styleable.com_facebook_like_view)) == null) {
            return;
        }
        this.objectId = Utility.coerceValueIfNullOrEmpty(typedArrayObtainStyledAttributes.getString(R.styleable.com_facebook_like_view_com_facebook_object_id), null);
        this.objectType = ObjectType.fromInt(typedArrayObtainStyledAttributes.getInt(R.styleable.com_facebook_like_view_com_facebook_object_type, ObjectType.DEFAULT.getValue()));
        this.likeViewStyle = Style.fromInt(typedArrayObtainStyledAttributes.getInt(R.styleable.com_facebook_like_view_com_facebook_style, Style.DEFAULT.getValue()));
        if (this.likeViewStyle == null) {
            throw new IllegalArgumentException("Unsupported value for LikeView 'style'");
        }
        this.auxiliaryViewPosition = AuxiliaryViewPosition.fromInt(typedArrayObtainStyledAttributes.getInt(R.styleable.com_facebook_like_view_com_facebook_auxiliary_view_position, AuxiliaryViewPosition.DEFAULT.getValue()));
        if (this.auxiliaryViewPosition == null) {
            throw new IllegalArgumentException("Unsupported value for LikeView 'auxiliary_view_position'");
        }
        this.horizontalAlignment = HorizontalAlignment.fromInt(typedArrayObtainStyledAttributes.getInt(R.styleable.com_facebook_like_view_com_facebook_horizontal_alignment, HorizontalAlignment.DEFAULT.getValue()));
        if (this.horizontalAlignment == null) {
            throw new IllegalArgumentException("Unsupported value for LikeView 'horizontal_alignment'");
        }
        this.foregroundColor = typedArrayObtainStyledAttributes.getColor(R.styleable.com_facebook_like_view_com_facebook_foreground_color, -1);
        typedArrayObtainStyledAttributes.recycle();
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void setObjectIdAndTypeForced(String str, ObjectType objectType) {
        tearDownObjectAssociations();
        this.objectId = str;
        this.objectType = objectType;
        if (Utility.isNullOrEmpty(str)) {
            return;
        }
        this.creationCallback = new LikeActionControllerCreationCallback();
        if (isInEditMode()) {
            return;
        }
        LikeActionController.getControllerForObjectId(str, objectType, this.creationCallback);
    }

    private void tearDownObjectAssociations() {
        if (this.broadcastReceiver != null) {
            LocalBroadcastManager.getInstance(getContext()).unregisterReceiver(this.broadcastReceiver);
            this.broadcastReceiver = null;
        }
        if (this.creationCallback != null) {
            this.creationCallback.cancel();
            this.creationCallback = null;
        }
        this.likeActionController = null;
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void toggleLike() {
        if (this.likeActionController != null) {
            this.likeActionController.toggleLike(this.parentFragment == null ? getActivity() : null, this.parentFragment, getAnalyticsParameters());
        }
    }

    private void updateBoxCountCaretPosition() {
        LikeBoxCountView likeBoxCountView;
        LikeBoxCountView.LikeBoxCountViewCaretPosition likeBoxCountViewCaretPosition;
        switch (this.auxiliaryViewPosition) {
            case TOP:
                likeBoxCountView = this.likeBoxCountView;
                likeBoxCountViewCaretPosition = LikeBoxCountView.LikeBoxCountViewCaretPosition.BOTTOM;
                break;
            case BOTTOM:
                likeBoxCountView = this.likeBoxCountView;
                likeBoxCountViewCaretPosition = LikeBoxCountView.LikeBoxCountViewCaretPosition.TOP;
                break;
            case INLINE:
                likeBoxCountView = this.likeBoxCountView;
                likeBoxCountViewCaretPosition = this.horizontalAlignment != HorizontalAlignment.RIGHT ? LikeBoxCountView.LikeBoxCountViewCaretPosition.LEFT : LikeBoxCountView.LikeBoxCountViewCaretPosition.RIGHT;
                break;
            default:
                return;
        }
        likeBoxCountView.setCaretPosition(likeBoxCountViewCaretPosition);
    }

    private void updateLayout() {
        View view;
        int i;
        int i2;
        int i3;
        int i4;
        FrameLayout.LayoutParams layoutParams = (FrameLayout.LayoutParams) this.containerView.getLayoutParams();
        LinearLayout.LayoutParams layoutParams2 = (LinearLayout.LayoutParams) this.likeButton.getLayoutParams();
        int i5 = this.horizontalAlignment == HorizontalAlignment.LEFT ? 3 : this.horizontalAlignment == HorizontalAlignment.CENTER ? 1 : 5;
        layoutParams.gravity = i5 | 48;
        layoutParams2.gravity = i5;
        this.socialSentenceView.setVisibility(8);
        this.likeBoxCountView.setVisibility(8);
        if (this.likeViewStyle != Style.STANDARD || this.likeActionController == null || Utility.isNullOrEmpty(this.likeActionController.getSocialSentence())) {
            if (this.likeViewStyle != Style.BOX_COUNT || this.likeActionController == null || Utility.isNullOrEmpty(this.likeActionController.getLikeCountString())) {
                return;
            }
            updateBoxCountCaretPosition();
            view = this.likeBoxCountView;
        } else {
            view = this.socialSentenceView;
        }
        view.setVisibility(0);
        ((LinearLayout.LayoutParams) view.getLayoutParams()).gravity = i5;
        this.containerView.setOrientation(this.auxiliaryViewPosition != AuxiliaryViewPosition.INLINE ? 1 : 0);
        if (this.auxiliaryViewPosition == AuxiliaryViewPosition.TOP || (this.auxiliaryViewPosition == AuxiliaryViewPosition.INLINE && this.horizontalAlignment == HorizontalAlignment.RIGHT)) {
            this.containerView.removeView(this.likeButton);
            this.containerView.addView(this.likeButton);
        } else {
            this.containerView.removeView(view);
            this.containerView.addView(view);
        }
        switch (this.auxiliaryViewPosition) {
            case TOP:
                i = this.edgePadding;
                i2 = this.edgePadding;
                i3 = this.edgePadding;
                i4 = this.internalPadding;
                view.setPadding(i, i2, i3, i4);
                break;
            case BOTTOM:
                i = this.edgePadding;
                i2 = this.internalPadding;
                i3 = this.edgePadding;
                i4 = this.edgePadding;
                view.setPadding(i, i2, i3, i4);
                break;
            case INLINE:
                if (this.horizontalAlignment != HorizontalAlignment.RIGHT) {
                    i = this.internalPadding;
                    i2 = this.edgePadding;
                    i3 = this.edgePadding;
                    i4 = this.edgePadding;
                    view.setPadding(i, i2, i3, i4);
                } else {
                    i = this.edgePadding;
                    i2 = this.edgePadding;
                    i3 = this.internalPadding;
                    i4 = this.edgePadding;
                    view.setPadding(i, i2, i3, i4);
                }
                break;
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void updateLikeStateAndLayout() {
        boolean zShouldEnableView = !this.explicitlyDisabled;
        if (this.likeActionController == null) {
            this.likeButton.setSelected(false);
            this.socialSentenceView.setText((CharSequence) null);
            this.likeBoxCountView.setText(null);
        } else {
            this.likeButton.setSelected(this.likeActionController.isObjectLiked());
            this.socialSentenceView.setText(this.likeActionController.getSocialSentence());
            this.likeBoxCountView.setText(this.likeActionController.getLikeCountString());
            zShouldEnableView &= this.likeActionController.shouldEnableView();
        }
        super.setEnabled(zShouldEnableView);
        this.likeButton.setEnabled(zShouldEnableView);
        updateLayout();
    }

    @Deprecated
    public OnErrorListener getOnErrorListener() {
        return this.onErrorListener;
    }

    @Override // android.view.ViewGroup, android.view.View
    protected void onDetachedFromWindow() {
        setObjectIdAndType(null, ObjectType.UNKNOWN);
        super.onDetachedFromWindow();
    }

    @Deprecated
    public void setAuxiliaryViewPosition(AuxiliaryViewPosition auxiliaryViewPosition) {
        if (auxiliaryViewPosition == null) {
            auxiliaryViewPosition = AuxiliaryViewPosition.DEFAULT;
        }
        if (this.auxiliaryViewPosition != auxiliaryViewPosition) {
            this.auxiliaryViewPosition = auxiliaryViewPosition;
            updateLayout();
        }
    }

    @Override // android.view.View
    @Deprecated
    public void setEnabled(boolean z) {
        this.explicitlyDisabled = true;
        updateLikeStateAndLayout();
    }

    @Deprecated
    public void setForegroundColor(int i) {
        if (this.foregroundColor != i) {
            this.socialSentenceView.setTextColor(i);
        }
    }

    @Deprecated
    public void setFragment(Fragment fragment) {
        this.parentFragment = new FragmentWrapper(fragment);
    }

    @Deprecated
    public void setFragment(android.support.v4.app.Fragment fragment) {
        this.parentFragment = new FragmentWrapper(fragment);
    }

    @Deprecated
    public void setHorizontalAlignment(HorizontalAlignment horizontalAlignment) {
        if (horizontalAlignment == null) {
            horizontalAlignment = HorizontalAlignment.DEFAULT;
        }
        if (this.horizontalAlignment != horizontalAlignment) {
            this.horizontalAlignment = horizontalAlignment;
            updateLayout();
        }
    }

    @Deprecated
    public void setLikeViewStyle(Style style) {
        if (style == null) {
            style = Style.DEFAULT;
        }
        if (this.likeViewStyle != style) {
            this.likeViewStyle = style;
            updateLayout();
        }
    }

    @Deprecated
    public void setObjectIdAndType(String str, ObjectType objectType) {
        String strCoerceValueIfNullOrEmpty = Utility.coerceValueIfNullOrEmpty(str, null);
        if (objectType == null) {
            objectType = ObjectType.DEFAULT;
        }
        if (Utility.areObjectsEqual(strCoerceValueIfNullOrEmpty, this.objectId) && objectType == this.objectType) {
            return;
        }
        setObjectIdAndTypeForced(strCoerceValueIfNullOrEmpty, objectType);
        updateLikeStateAndLayout();
    }

    @Deprecated
    public void setOnErrorListener(OnErrorListener onErrorListener) {
        this.onErrorListener = onErrorListener;
    }
}

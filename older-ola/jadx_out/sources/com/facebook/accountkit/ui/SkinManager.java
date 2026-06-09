package com.facebook.accountkit.ui;

import android.app.Fragment;
import android.graphics.Color;
import android.os.Parcel;
import android.os.Parcelable;
import android.support.annotation.ColorInt;
import android.support.annotation.DrawableRes;
import android.support.annotation.Nullable;
import android.support.v4.view.ViewCompat;

/* JADX INFO: loaded from: classes.dex */
public final class SkinManager extends BaseUIManager {
    public static final Parcelable.Creator<SkinManager> CREATOR = new Parcelable.Creator<SkinManager>() { // from class: com.facebook.accountkit.ui.SkinManager.1
        /* JADX WARN: Can't rename method to resolve collision */
        @Override // android.os.Parcelable.Creator
        public SkinManager createFromParcel(Parcel parcel) {
            return new SkinManager(parcel);
        }

        /* JADX WARN: Can't rename method to resolve collision */
        @Override // android.os.Parcelable.Creator
        public SkinManager[] newArray(int i) {
            return new SkinManager[i];
        }
    };
    private static final double DISABLED_COLOR_ALPHA = 0.25d;
    private static final double MAXIMUM_TINT_INTENSITY = 0.85d;
    private static final double MINIMUM_TINT_INTENSITY = 0.55d;

    @DrawableRes
    private final int backgroundImage;

    @ColorInt
    private final int primaryColor;
    private final Skin skin;
    private final Tint tint;
    private final double tintIntensity;

    /* JADX INFO: renamed from: com.facebook.accountkit.ui.SkinManager$2, reason: invalid class name */
    static /* synthetic */ class AnonymousClass2 {
        static final /* synthetic */ int[] $SwitchMap$com$facebook$accountkit$ui$SkinManager$Tint = new int[Tint.values().length];

        static {
            try {
                $SwitchMap$com$facebook$accountkit$ui$SkinManager$Tint[Tint.WHITE.ordinal()] = 1;
            } catch (NoSuchFieldError unused) {
            }
            try {
                $SwitchMap$com$facebook$accountkit$ui$SkinManager$Tint[Tint.BLACK.ordinal()] = 2;
            } catch (NoSuchFieldError unused2) {
            }
        }
    }

    public enum Skin {
        NONE,
        CLASSIC,
        CONTEMPORARY,
        TRANSLUCENT
    }

    public enum Tint {
        WHITE,
        BLACK
    }

    private SkinManager(Parcel parcel) {
        super(parcel);
        this.skin = Skin.values()[parcel.readInt()];
        this.primaryColor = parcel.readInt();
        this.backgroundImage = parcel.readInt();
        this.tint = Tint.values()[parcel.readInt()];
        this.tintIntensity = parcel.readDouble();
    }

    public SkinManager(Skin skin, @ColorInt int i) {
        this(skin, i, -1, Tint.WHITE, MINIMUM_TINT_INTENSITY);
    }

    public SkinManager(Skin skin, @ColorInt int i, @DrawableRes int i2, Tint tint, double d) {
        super(-1);
        this.skin = skin;
        this.primaryColor = i;
        this.backgroundImage = i2;
        if (hasBackgroundImage()) {
            this.tint = tint;
            this.tintIntensity = Math.min(MAXIMUM_TINT_INTENSITY, Math.max(MINIMUM_TINT_INTENSITY, d));
        } else {
            this.tint = Tint.WHITE;
            this.tintIntensity = MINIMUM_TINT_INTENSITY;
        }
    }

    @Override // com.facebook.accountkit.ui.BaseUIManager, android.os.Parcelable
    public int describeContents() {
        return 0;
    }

    @DrawableRes
    int getBackgroundImageResId() {
        return this.backgroundImage;
    }

    @Override // com.facebook.accountkit.ui.BaseUIManager, com.facebook.accountkit.ui.UIManagerStub
    @Nullable
    public Fragment getBodyFragment(LoginFlowState loginFlowState) {
        return super.getBodyFragment(loginFlowState);
    }

    @Override // com.facebook.accountkit.ui.BaseUIManager, com.facebook.accountkit.ui.UIManagerStub
    @Nullable
    public ButtonType getButtonType(LoginFlowState loginFlowState) {
        return super.getButtonType(loginFlowState);
    }

    @ColorInt
    int getDisabledColor(@ColorInt int i) {
        int i2 = AnonymousClass2.$SwitchMap$com$facebook$accountkit$ui$SkinManager$Tint[this.tint.ordinal()] != 1 ? ViewCompat.MEASURED_STATE_MASK : -1;
        return Color.rgb((int) ((((double) Color.red(i)) * DISABLED_COLOR_ALPHA) + (((double) Color.red(i2)) * 0.75d)), (int) ((((double) Color.green(i)) * DISABLED_COLOR_ALPHA) + (((double) Color.green(i2)) * 0.75d)), (int) ((((double) Color.blue(i)) * DISABLED_COLOR_ALPHA) + (((double) Color.blue(i2)) * 0.75d)));
    }

    @Override // com.facebook.accountkit.ui.BaseUIManager, com.facebook.accountkit.ui.UIManagerStub
    @Nullable
    public Fragment getFooterFragment(LoginFlowState loginFlowState) {
        return super.getFooterFragment(loginFlowState);
    }

    @Override // com.facebook.accountkit.ui.BaseUIManager, com.facebook.accountkit.ui.UIManagerStub
    @Nullable
    public Fragment getHeaderFragment(LoginFlowState loginFlowState) {
        return super.getHeaderFragment(loginFlowState);
    }

    @ColorInt
    public int getPrimaryColor() {
        return this.primaryColor;
    }

    public Skin getSkin() {
        return this.skin;
    }

    @ColorInt
    int getTextColor() {
        if (AnonymousClass2.$SwitchMap$com$facebook$accountkit$ui$SkinManager$Tint[getTint().ordinal()] != 2) {
            return ViewCompat.MEASURED_STATE_MASK;
        }
        return -1;
    }

    @Override // com.facebook.accountkit.ui.BaseUIManager, com.facebook.accountkit.ui.UIManagerStub
    @Nullable
    public TextPosition getTextPosition(LoginFlowState loginFlowState) {
        return super.getTextPosition(loginFlowState);
    }

    public Tint getTint() {
        return this.tint;
    }

    /* JADX WARN: Unreachable blocks removed: 1, instructions: 1 */
    @ColorInt
    int getTintColor() {
        int i;
        int i2;
        if (AnonymousClass2.$SwitchMap$com$facebook$accountkit$ui$SkinManager$Tint[this.tint.ordinal()] != 1) {
            i = (int) (this.tintIntensity * 255.0d);
            i2 = 0;
        } else {
            i = (int) (this.tintIntensity * 255.0d);
            i2 = 255;
        }
        return Color.argb(i, i2, i2, i2);
    }

    public double getTintIntensity() {
        return this.tintIntensity;
    }

    public boolean hasBackgroundImage() {
        return this.backgroundImage >= 0;
    }

    @Override // com.facebook.accountkit.ui.BaseUIManager, android.os.Parcelable
    public void writeToParcel(Parcel parcel, int i) {
        super.writeToParcel(parcel, i);
        parcel.writeInt(this.skin.ordinal());
        parcel.writeInt(this.primaryColor);
        parcel.writeInt(this.backgroundImage);
        parcel.writeInt(this.tint.ordinal());
        parcel.writeDouble(this.tintIntensity);
    }
}

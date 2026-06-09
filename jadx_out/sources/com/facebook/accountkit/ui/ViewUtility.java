package com.facebook.accountkit.ui;

import android.app.Activity;
import android.content.Context;
import android.content.res.ColorStateList;
import android.content.res.Resources;
import android.graphics.PorterDuff;
import android.graphics.drawable.ColorDrawable;
import android.graphics.drawable.Drawable;
import android.graphics.drawable.GradientDrawable;
import android.graphics.drawable.RippleDrawable;
import android.graphics.drawable.StateListDrawable;
import android.os.Build;
import android.support.annotation.AttrRes;
import android.support.annotation.ColorInt;
import android.support.v4.content.ContextCompat;
import android.support.v4.graphics.ColorUtils;
import android.support.v4.graphics.drawable.DrawableCompat;
import android.support.v4.view.ViewCompat;
import android.util.TypedValue;
import android.view.View;
import android.view.ViewGroup;
import android.view.inputmethod.InputMethodManager;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.ProgressBar;
import android.widget.TextView;
import com.facebook.accountkit.R;
import com.facebook.accountkit.ui.SkinManager;

/* JADX INFO: loaded from: classes.dex */
final class ViewUtility {
    private static final double TEXT_COLOR_CONTRAST_THRESHOLD = 1.5d;

    ViewUtility() {
    }

    private static void applyButtonThemeAttributes(Context context, UIManager uIManager, Button button) {
        int color;
        int color2;
        int i;
        int i2;
        int i3;
        int i4;
        if (useLegacy(uIManager)) {
            int buttonColor = getButtonColor(context, uIManager);
            int color3 = getColor(context, R.attr.com_accountkit_button_border_color, buttonColor);
            int color4 = getColor(context, R.attr.com_accountkit_button_pressed_background_color, -3355444);
            color = getColor(context, R.attr.com_accountkit_button_pressed_border_color, color4);
            int color5 = getColor(context, R.attr.com_accountkit_button_disabled_background_color, -3355444);
            color2 = getColor(context, R.attr.com_accountkit_button_disabled_border_color, color5);
            i = color5;
            i2 = color4;
            i3 = color3;
            i4 = buttonColor;
        } else {
            int primaryColor = getPrimaryColor(context, uIManager);
            int disabledColor = ((SkinManager) uIManager).getDisabledColor(primaryColor);
            int i5 = isSkin(uIManager, SkinManager.Skin.TRANSLUCENT) ? 0 : primaryColor;
            int i6 = isSkin(uIManager, SkinManager.Skin.TRANSLUCENT) ? 0 : disabledColor;
            if (isSkin(uIManager, SkinManager.Skin.TRANSLUCENT)) {
                disabledColor = primaryColor;
            }
            color = primaryColor;
            color2 = disabledColor;
            i = i6;
            i4 = color;
            i2 = i5;
            i3 = i4;
        }
        setBackground(button, getButtonBackgroundDrawable(context, i4, i3, i2, color, i, color2));
        ColorStateList buttonTextColorStateList = getButtonTextColorStateList(context, uIManager);
        button.setTextColor(buttonTextColorStateList);
        Drawable[] compoundDrawables = button.getCompoundDrawables();
        if (compoundDrawables.length >= 4) {
            for (Drawable drawable : compoundDrawables) {
                if (drawable != null) {
                    DrawableCompat.setTintList(DrawableCompat.wrap(drawable), buttonTextColorStateList);
                }
            }
        }
    }

    /* JADX WARN: Unreachable blocks removed: 1, instructions: 1 */
    private static void applyInputThemeAttributes(Context context, UIManager uIManager, View view) {
        Drawable inputBackgroundDrawable;
        if (useLegacy(uIManager)) {
            int color = getColor(context, R.attr.com_accountkit_input_background_color, -3355444);
            inputBackgroundDrawable = getInputBackgroundDrawable(context, color, getColor(context, R.attr.com_accountkit_input_border_color, color));
        } else if (isSkin(uIManager, SkinManager.Skin.TRANSLUCENT)) {
            inputBackgroundDrawable = getInputBackgroundDrawable(context, 0, getPrimaryColor(context, uIManager));
        } else {
            int disabledColor = ((SkinManager) uIManager).getDisabledColor(getPrimaryColor(context, uIManager));
            inputBackgroundDrawable = getInputBackgroundDrawable(context, disabledColor, disabledColor);
        }
        setBackground(view, inputBackgroundDrawable);
    }

    private static void applyInputThemeAttributes(Context context, UIManager uIManager, EditText editText) {
        if (!useLegacy(uIManager)) {
            editText.setTextColor(((SkinManager) uIManager).getTextColor());
        }
        if (!isSkin(uIManager, SkinManager.Skin.CONTEMPORARY)) {
            applyInputThemeAttributes(context, uIManager, (View) editText);
            return;
        }
        int primaryColor = getPrimaryColor(context, uIManager);
        Drawable drawableMutate = DrawableCompat.wrap(editText.getBackground()).mutate();
        DrawableCompat.setTint(drawableMutate, primaryColor);
        setBackground(editText, drawableMutate);
        editText.setTextColor(((SkinManager) uIManager).getTextColor());
    }

    private static void applyLegacyThemedBackground(Context context, View view) {
        setBackground(view, getLegacyThemedBackground(context, view));
    }

    private static void applyProgressBarThemeAttributes(Context context, UIManager uIManager, ProgressBar progressBar) {
        applyThemeColor(context, progressBar.getIndeterminateDrawable(), useLegacy(uIManager) ? getColor(context, R.attr.com_accountkit_icon_color, ViewCompat.MEASURED_STATE_MASK) : getPrimaryColor(context, uIManager));
    }

    private static void applySkinThemedBackground(Context context, SkinManager skinManager, View view) {
        Drawable drawable = skinManager.hasBackgroundImage() ? getDrawable(context.getResources(), skinManager.getBackgroundImageResId()) : new ColorDrawable(ContextCompat.getColor(context, R.color.com_accountkit_default_skin_background));
        if (skinManager.hasBackgroundImage()) {
            if (view instanceof AspectFrameLayout) {
                AspectFrameLayout aspectFrameLayout = (AspectFrameLayout) view;
                aspectFrameLayout.setAspectWidth(drawable.getIntrinsicWidth());
                aspectFrameLayout.setAspectHeight(drawable.getIntrinsicHeight());
            }
            drawable.setColorFilter(skinManager.getTintColor(), PorterDuff.Mode.SRC_ATOP);
        }
        setBackground(view, drawable);
    }

    private static void applySpinnerThemeAttributes(Context context, UIManager uIManager, CountryCodeSpinner countryCodeSpinner) {
        int textColor;
        ViewGroup viewGroup = (ViewGroup) countryCodeSpinner.getParent();
        ImageView imageView = (ImageView) viewGroup.getChildAt(1);
        View childAt = viewGroup.getChildAt(2);
        Drawable drawableMutate = DrawableCompat.wrap(imageView.getDrawable()).mutate();
        if (isSkin(uIManager, SkinManager.Skin.CONTEMPORARY)) {
            childAt.setVisibility(0);
            setBackground(childAt, new ColorDrawable(getPrimaryColor(context, uIManager)));
            DrawableCompat.setTint(drawableMutate, getPrimaryColor(context, uIManager));
            return;
        }
        if (isSkin(uIManager, SkinManager.Skin.TRANSLUCENT) || isSkin(uIManager, SkinManager.Skin.CLASSIC)) {
            childAt.setVisibility(8);
            textColor = ((SkinManager) uIManager).getTextColor();
        } else {
            childAt.setVisibility(8);
            textColor = getColor(context, R.attr.com_accountkit_input_accent_color, ViewCompat.MEASURED_STATE_MASK);
        }
        DrawableCompat.setTint(drawableMutate, textColor);
        applyInputThemeAttributes(context, uIManager, viewGroup);
    }

    private static void applyTextViewThemeAttributes(Context context, UIManager uIManager, TextView textView) {
        int color = useLegacy(uIManager) ? getColor(context, R.attr.com_accountkit_text_color, ContextCompat.getColor(context, android.R.color.primary_text_dark)) : ((SkinManager) uIManager).getTextColor();
        textView.setTextColor(color);
        textView.setLinkTextColor(color);
    }

    static void applyThemeAttributes(Context context, UIManager uIManager, View view) {
        if (context == null || view == null) {
            return;
        }
        if (view instanceof Button) {
            applyButtonThemeAttributes(context, uIManager, (Button) view);
            return;
        }
        if (view instanceof EditText) {
            applyInputThemeAttributes(context, uIManager, (EditText) view);
            return;
        }
        if (view instanceof ProgressBar) {
            applyProgressBarThemeAttributes(context, uIManager, (ProgressBar) view);
            return;
        }
        if (view instanceof CountryCodeSpinner) {
            applySpinnerThemeAttributes(context, uIManager, (CountryCodeSpinner) view);
            return;
        }
        if (view instanceof TextView) {
            applyTextViewThemeAttributes(context, uIManager, (TextView) view);
            return;
        }
        if (view instanceof ViewGroup) {
            ViewGroup viewGroup = (ViewGroup) view;
            int childCount = viewGroup.getChildCount();
            for (int i = 0; i < childCount; i++) {
                applyThemeAttributes(context, uIManager, viewGroup.getChildAt(i));
            }
        }
    }

    static void applyThemeBackground(Context context, UIManager uIManager, View view) {
        if (context == null || view == null) {
            return;
        }
        if (uIManager instanceof SkinManager) {
            applySkinThemedBackground(context, (SkinManager) uIManager, view);
        } else {
            applyLegacyThemedBackground(context, view);
        }
    }

    static void applyThemeColor(Context context, Drawable drawable, @ColorInt int i) {
        if (context == null || drawable == null) {
            return;
        }
        drawable.setColorFilter(i, PorterDuff.Mode.SRC_ATOP);
    }

    static void applyThemeColor(Context context, ImageView imageView, @ColorInt int i) {
        if (context == null || imageView == null) {
            return;
        }
        imageView.setColorFilter(i, PorterDuff.Mode.SRC_ATOP);
    }

    static boolean doesTextColorContrast(Context context, UIManager uIManager) {
        Resources.Theme theme;
        if (uIManager.getThemeId() != -1) {
            theme = context.getResources().newTheme();
            theme.setTo(context.getTheme());
            theme.applyStyle(uIManager.getThemeId(), true);
        } else {
            theme = context.getTheme();
        }
        return ColorUtils.calculateContrast((useLegacy(uIManager) ? getColor(theme, R.attr.com_accountkit_text_color, ContextCompat.getColor(context, android.R.color.primary_text_dark)) : ((SkinManager) uIManager).getTextColor()) | ViewCompat.MEASURED_STATE_MASK, (useLegacy(uIManager) ? getColor(theme, R.attr.com_accountkit_background_color, -1) : ((SkinManager) uIManager).getTintColor()) | ViewCompat.MEASURED_STATE_MASK) >= TEXT_COLOR_CONTRAST_THRESHOLD;
    }

    private static Drawable getButtonBackgroundDrawable(Context context, int i, int i2, int i3, int i4, int i5, int i6) {
        StateListDrawable stateListDrawable = new StateListDrawable();
        if (Build.VERSION.SDK_INT >= 21) {
            stateListDrawable.addState(new int[]{-16842910}, new RippleDrawable(new ColorStateList(new int[][]{new int[0]}, new int[]{i}), new ColorDrawable(i5), null));
            stateListDrawable.addState(new int[0], new RippleDrawable(new ColorStateList(new int[][]{new int[0]}, new int[]{i5}), new ColorDrawable(i), null));
            return stateListDrawable;
        }
        stateListDrawable.addState(new int[]{-16842910}, getInputBackgroundDrawable(context, i5, i6));
        stateListDrawable.addState(new int[]{android.R.attr.state_pressed}, getInputBackgroundDrawable(context, i3, i4));
        stateListDrawable.addState(new int[0], getInputBackgroundDrawable(context, i, i2));
        return stateListDrawable;
    }

    @ColorInt
    static int getButtonColor(Context context, UIManager uIManager) {
        return uIManager instanceof SkinManager ? ((SkinManager) uIManager).getPrimaryColor() : getColor(context, R.attr.com_accountkit_button_background_color, -3355444);
    }

    @ColorInt
    static int getButtonTextColor(Context context, UIManager uIManager) {
        return !useLegacy(uIManager) ? ((SkinManager) uIManager).getTextColor() : getColor(context, R.attr.com_accountkit_button_text_color, ViewCompat.MEASURED_STATE_MASK);
    }

    private static ColorStateList getButtonTextColorStateList(Context context, UIManager uIManager) {
        int[] iArr;
        int[][] iArr2 = {new int[]{-16842910}, new int[]{android.R.attr.state_pressed}, new int[0]};
        if (useLegacy(uIManager)) {
            iArr = new int[]{getColor(context, R.attr.com_accountkit_button_disabled_text_color, -3355444), getColor(context, R.attr.com_accountkit_button_pressed_text_color, -12303292), getColor(context, R.attr.com_accountkit_button_text_color, ViewCompat.MEASURED_STATE_MASK)};
        } else {
            int textColor = ((SkinManager) uIManager).getTextColor();
            iArr = new int[]{textColor, textColor, textColor};
        }
        return new ColorStateList(iArr2, iArr);
    }

    @ColorInt
    static int getColor(Context context, @AttrRes int i, int i2) {
        return getColor(context.getTheme(), i, i2);
    }

    @ColorInt
    static int getColor(Resources.Theme theme, @AttrRes int i, int i2) {
        TypedValue typedValue = new TypedValue();
        return theme.resolveAttribute(i, typedValue, true) ? typedValue.data : i2;
    }

    static int getDimensionPixelSize(Context context, int i) {
        return (int) TypedValue.applyDimension(1, i, context.getResources().getDisplayMetrics());
    }

    private static Drawable getDrawable(Resources resources, int i) {
        return Build.VERSION.SDK_INT < 22 ? resources.getDrawable(i) : resources.getDrawable(i, null);
    }

    private static Drawable getInputBackgroundDrawable(Context context, @ColorInt int i, @ColorInt int i2) {
        GradientDrawable gradientDrawable = new GradientDrawable();
        Resources resources = context.getResources();
        gradientDrawable.setColor(i);
        gradientDrawable.setCornerRadius(resources.getDimension(R.dimen.com_accountkit_input_corner_radius));
        gradientDrawable.setStroke(resources.getDimensionPixelSize(R.dimen.com_accountkit_input_border), i2);
        return gradientDrawable;
    }

    private static Drawable getLegacyThemedBackground(Context context, View view) {
        Resources.Theme theme = context.getTheme();
        TypedValue typedValue = new TypedValue();
        theme.resolveAttribute(R.attr.com_accountkit_background, typedValue, true);
        Drawable colorDrawable = typedValue.resourceId == 0 ? new ColorDrawable(getColor(context, R.attr.com_accountkit_background_color, -1)) : getDrawable(context.getResources(), typedValue.resourceId);
        if (typedValue.resourceId > 0) {
            if (view instanceof AspectFrameLayout) {
                AspectFrameLayout aspectFrameLayout = (AspectFrameLayout) view;
                aspectFrameLayout.setAspectWidth(colorDrawable.getIntrinsicWidth());
                aspectFrameLayout.setAspectHeight(colorDrawable.getIntrinsicHeight());
            }
            applyThemeColor(context, colorDrawable, getColor(context, R.attr.com_accountkit_background_color, -1));
        }
        return colorDrawable;
    }

    @ColorInt
    static int getPrimaryColor(Context context, UIManager uIManager) {
        return uIManager instanceof SkinManager ? ((SkinManager) uIManager).getPrimaryColor() : getColor(context, R.attr.com_accountkit_primary_color, -3355444);
    }

    static void hideKeyboard(Activity activity) {
        View viewFindViewById = activity.findViewById(android.R.id.content);
        if (viewFindViewById == null) {
            return;
        }
        View viewFindFocus = viewFindViewById.findFocus();
        if (viewFindFocus != null) {
            viewFindFocus.clearFocus();
        }
        ((InputMethodManager) activity.getSystemService("input_method")).hideSoftInputFromWindow(viewFindViewById.getWindowToken(), 1);
    }

    static boolean isSkin(UIManager uIManager, SkinManager.Skin skin) {
        return (uIManager instanceof SkinManager) && ((SkinManager) uIManager).getSkin() == skin;
    }

    static boolean isTablet(Context context) {
        return ((context.getResources().getConfiguration().screenLayout & 15) == 4) || ((context.getResources().getConfiguration().screenLayout & 15) == 3);
    }

    static void setBackground(View view, Drawable drawable) {
        if (Build.VERSION.SDK_INT < 16) {
            view.setBackgroundDrawable(drawable);
        } else {
            view.setBackground(drawable);
        }
    }

    static void showKeyboard(View view) {
        if (view == null || view.getContext() == null || !view.requestFocus()) {
            return;
        }
        ((InputMethodManager) view.getContext().getSystemService("input_method")).showSoftInput(view, 1);
    }

    static boolean useLegacy(UIManager uIManager) {
        return !(uIManager instanceof SkinManager);
    }
}

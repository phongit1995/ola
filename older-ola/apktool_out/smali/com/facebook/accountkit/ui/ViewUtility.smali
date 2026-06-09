.class final Lcom/facebook/accountkit/ui/ViewUtility;
.super Ljava/lang/Object;


# static fields
.field private static final TEXT_COLOR_CONTRAST_THRESHOLD:D = 1.5


# direct methods
.method constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private static applyButtonThemeAttributes(Landroid/content/Context;Lcom/facebook/accountkit/ui/UIManager;Landroid/widget/Button;)V
    .locals 8

    invoke-static {p1}, Lcom/facebook/accountkit/ui/ViewUtility;->useLegacy(Lcom/facebook/accountkit/ui/UIManager;)Z

    move-result v0

    const/4 v7, 0x0

    if-nez v0, :cond_3

    invoke-static {p0, p1}, Lcom/facebook/accountkit/ui/ViewUtility;->getPrimaryColor(Landroid/content/Context;Lcom/facebook/accountkit/ui/UIManager;)I

    move-result v0

    move-object v1, p1

    check-cast v1, Lcom/facebook/accountkit/ui/SkinManager;

    invoke-virtual {v1, v0}, Lcom/facebook/accountkit/ui/SkinManager;->getDisabledColor(I)I

    move-result v1

    sget-object v2, Lcom/facebook/accountkit/ui/SkinManager$Skin;->TRANSLUCENT:Lcom/facebook/accountkit/ui/SkinManager$Skin;

    invoke-static {p1, v2}, Lcom/facebook/accountkit/ui/ViewUtility;->isSkin(Lcom/facebook/accountkit/ui/UIManager;Lcom/facebook/accountkit/ui/SkinManager$Skin;)Z

    move-result v2

    if-eqz v2, :cond_0

    const/4 v2, 0x0

    goto :goto_0

    :cond_0
    move v2, v0

    :goto_0
    sget-object v3, Lcom/facebook/accountkit/ui/SkinManager$Skin;->TRANSLUCENT:Lcom/facebook/accountkit/ui/SkinManager$Skin;

    invoke-static {p1, v3}, Lcom/facebook/accountkit/ui/ViewUtility;->isSkin(Lcom/facebook/accountkit/ui/UIManager;Lcom/facebook/accountkit/ui/SkinManager$Skin;)Z

    move-result v3

    if-eqz v3, :cond_1

    const/4 v3, 0x0

    goto :goto_1

    :cond_1
    move v3, v1

    :goto_1
    sget-object v4, Lcom/facebook/accountkit/ui/SkinManager$Skin;->TRANSLUCENT:Lcom/facebook/accountkit/ui/SkinManager$Skin;

    invoke-static {p1, v4}, Lcom/facebook/accountkit/ui/ViewUtility;->isSkin(Lcom/facebook/accountkit/ui/UIManager;Lcom/facebook/accountkit/ui/SkinManager$Skin;)Z

    move-result v4

    if-eqz v4, :cond_2

    move v1, v0

    :cond_2
    move v4, v0

    move v6, v1

    move v5, v3

    move v1, v4

    move v3, v2

    move v2, v1

    goto :goto_2

    :cond_3
    invoke-static {p0, p1}, Lcom/facebook/accountkit/ui/ViewUtility;->getButtonColor(Landroid/content/Context;Lcom/facebook/accountkit/ui/UIManager;)I

    move-result v0

    sget v1, Lcom/facebook/accountkit/R$attr;->com_accountkit_button_border_color:I

    invoke-static {p0, v1, v0}, Lcom/facebook/accountkit/ui/ViewUtility;->getColor(Landroid/content/Context;II)I

    move-result v1

    sget v2, Lcom/facebook/accountkit/R$attr;->com_accountkit_button_pressed_background_color:I

    const v3, -0x333334

    invoke-static {p0, v2, v3}, Lcom/facebook/accountkit/ui/ViewUtility;->getColor(Landroid/content/Context;II)I

    move-result v2

    sget v4, Lcom/facebook/accountkit/R$attr;->com_accountkit_button_pressed_border_color:I

    invoke-static {p0, v4, v2}, Lcom/facebook/accountkit/ui/ViewUtility;->getColor(Landroid/content/Context;II)I

    move-result v4

    sget v5, Lcom/facebook/accountkit/R$attr;->com_accountkit_button_disabled_background_color:I

    invoke-static {p0, v5, v3}, Lcom/facebook/accountkit/ui/ViewUtility;->getColor(Landroid/content/Context;II)I

    move-result v3

    sget v5, Lcom/facebook/accountkit/R$attr;->com_accountkit_button_disabled_border_color:I

    invoke-static {p0, v5, v3}, Lcom/facebook/accountkit/ui/ViewUtility;->getColor(Landroid/content/Context;II)I

    move-result v5

    move v6, v5

    move v5, v3

    move v3, v2

    move v2, v1

    move v1, v0

    :goto_2
    move-object v0, p0

    invoke-static/range {v0 .. v6}, Lcom/facebook/accountkit/ui/ViewUtility;->getButtonBackgroundDrawable(Landroid/content/Context;IIIIII)Landroid/graphics/drawable/Drawable;

    move-result-object v0

    invoke-static {p2, v0}, Lcom/facebook/accountkit/ui/ViewUtility;->setBackground(Landroid/view/View;Landroid/graphics/drawable/Drawable;)V

    invoke-static {p0, p1}, Lcom/facebook/accountkit/ui/ViewUtility;->getButtonTextColorStateList(Landroid/content/Context;Lcom/facebook/accountkit/ui/UIManager;)Landroid/content/res/ColorStateList;

    move-result-object v0

    invoke-virtual {p2, v0}, Landroid/widget/Button;->setTextColor(Landroid/content/res/ColorStateList;)V

    invoke-virtual {p2}, Landroid/widget/Button;->getCompoundDrawables()[Landroid/graphics/drawable/Drawable;

    move-result-object v1

    array-length v2, v1

    const/4 v3, 0x4

    if-lt v2, v3, :cond_5

    array-length v2, v1

    :goto_3
    if-ge v7, v2, :cond_5

    aget-object v3, v1, v7

    if-eqz v3, :cond_4

    invoke-static {v3}, Landroid/support/v4/graphics/drawable/DrawableCompat;->wrap(Landroid/graphics/drawable/Drawable;)Landroid/graphics/drawable/Drawable;

    move-result-object v3

    invoke-static {v3, v0}, Landroid/support/v4/graphics/drawable/DrawableCompat;->setTintList(Landroid/graphics/drawable/Drawable;Landroid/content/res/ColorStateList;)V

    :cond_4
    add-int/lit8 v7, v7, 0x1

    goto :goto_3

    :cond_5
    return-void
.end method

.method private static applyInputThemeAttributes(Landroid/content/Context;Lcom/facebook/accountkit/ui/UIManager;Landroid/view/View;)V
    .locals 1

    invoke-static {p1}, Lcom/facebook/accountkit/ui/ViewUtility;->useLegacy(Lcom/facebook/accountkit/ui/UIManager;)Z

    move-result v0

    if-eqz v0, :cond_0

    sget p1, Lcom/facebook/accountkit/R$attr;->com_accountkit_input_background_color:I

    const v0, -0x333334

    invoke-static {p0, p1, v0}, Lcom/facebook/accountkit/ui/ViewUtility;->getColor(Landroid/content/Context;II)I

    move-result p1

    sget v0, Lcom/facebook/accountkit/R$attr;->com_accountkit_input_border_color:I

    invoke-static {p0, v0, p1}, Lcom/facebook/accountkit/ui/ViewUtility;->getColor(Landroid/content/Context;II)I

    move-result v0

    invoke-static {p0, p1, v0}, Lcom/facebook/accountkit/ui/ViewUtility;->getInputBackgroundDrawable(Landroid/content/Context;II)Landroid/graphics/drawable/Drawable;

    move-result-object p0

    :goto_0
    invoke-static {p2, p0}, Lcom/facebook/accountkit/ui/ViewUtility;->setBackground(Landroid/view/View;Landroid/graphics/drawable/Drawable;)V

    return-void

    :cond_0
    sget-object v0, Lcom/facebook/accountkit/ui/SkinManager$Skin;->TRANSLUCENT:Lcom/facebook/accountkit/ui/SkinManager$Skin;

    invoke-static {p1, v0}, Lcom/facebook/accountkit/ui/ViewUtility;->isSkin(Lcom/facebook/accountkit/ui/UIManager;Lcom/facebook/accountkit/ui/SkinManager$Skin;)Z

    move-result v0

    if-eqz v0, :cond_1

    invoke-static {p0, p1}, Lcom/facebook/accountkit/ui/ViewUtility;->getPrimaryColor(Landroid/content/Context;Lcom/facebook/accountkit/ui/UIManager;)I

    move-result p1

    const/4 v0, 0x0

    invoke-static {p0, v0, p1}, Lcom/facebook/accountkit/ui/ViewUtility;->getInputBackgroundDrawable(Landroid/content/Context;II)Landroid/graphics/drawable/Drawable;

    move-result-object p0

    goto :goto_0

    :cond_1
    move-object v0, p1

    check-cast v0, Lcom/facebook/accountkit/ui/SkinManager;

    invoke-static {p0, p1}, Lcom/facebook/accountkit/ui/ViewUtility;->getPrimaryColor(Landroid/content/Context;Lcom/facebook/accountkit/ui/UIManager;)I

    move-result p1

    invoke-virtual {v0, p1}, Lcom/facebook/accountkit/ui/SkinManager;->getDisabledColor(I)I

    move-result p1

    invoke-static {p0, p1, p1}, Lcom/facebook/accountkit/ui/ViewUtility;->getInputBackgroundDrawable(Landroid/content/Context;II)Landroid/graphics/drawable/Drawable;

    move-result-object p0

    goto :goto_0

    return-void
.end method

.method private static applyInputThemeAttributes(Landroid/content/Context;Lcom/facebook/accountkit/ui/UIManager;Landroid/widget/EditText;)V
    .locals 1

    invoke-static {p1}, Lcom/facebook/accountkit/ui/ViewUtility;->useLegacy(Lcom/facebook/accountkit/ui/UIManager;)Z

    move-result v0

    if-nez v0, :cond_0

    move-object v0, p1

    check-cast v0, Lcom/facebook/accountkit/ui/SkinManager;

    invoke-virtual {v0}, Lcom/facebook/accountkit/ui/SkinManager;->getTextColor()I

    move-result v0

    invoke-virtual {p2, v0}, Landroid/widget/EditText;->setTextColor(I)V

    :cond_0
    sget-object v0, Lcom/facebook/accountkit/ui/SkinManager$Skin;->CONTEMPORARY:Lcom/facebook/accountkit/ui/SkinManager$Skin;

    invoke-static {p1, v0}, Lcom/facebook/accountkit/ui/ViewUtility;->isSkin(Lcom/facebook/accountkit/ui/UIManager;Lcom/facebook/accountkit/ui/SkinManager$Skin;)Z

    move-result v0

    if-eqz v0, :cond_1

    invoke-static {p0, p1}, Lcom/facebook/accountkit/ui/ViewUtility;->getPrimaryColor(Landroid/content/Context;Lcom/facebook/accountkit/ui/UIManager;)I

    move-result p0

    invoke-virtual {p2}, Landroid/widget/EditText;->getBackground()Landroid/graphics/drawable/Drawable;

    move-result-object v0

    invoke-static {v0}, Landroid/support/v4/graphics/drawable/DrawableCompat;->wrap(Landroid/graphics/drawable/Drawable;)Landroid/graphics/drawable/Drawable;

    move-result-object v0

    invoke-virtual {v0}, Landroid/graphics/drawable/Drawable;->mutate()Landroid/graphics/drawable/Drawable;

    move-result-object v0

    invoke-static {v0, p0}, Landroid/support/v4/graphics/drawable/DrawableCompat;->setTint(Landroid/graphics/drawable/Drawable;I)V

    invoke-static {p2, v0}, Lcom/facebook/accountkit/ui/ViewUtility;->setBackground(Landroid/view/View;Landroid/graphics/drawable/Drawable;)V

    check-cast p1, Lcom/facebook/accountkit/ui/SkinManager;

    invoke-virtual {p1}, Lcom/facebook/accountkit/ui/SkinManager;->getTextColor()I

    move-result p0

    invoke-virtual {p2, p0}, Landroid/widget/EditText;->setTextColor(I)V

    return-void

    :cond_1
    invoke-static {p0, p1, p2}, Lcom/facebook/accountkit/ui/ViewUtility;->applyInputThemeAttributes(Landroid/content/Context;Lcom/facebook/accountkit/ui/UIManager;Landroid/view/View;)V

    return-void
.end method

.method private static applyLegacyThemedBackground(Landroid/content/Context;Landroid/view/View;)V
    .locals 0

    invoke-static {p0, p1}, Lcom/facebook/accountkit/ui/ViewUtility;->getLegacyThemedBackground(Landroid/content/Context;Landroid/view/View;)Landroid/graphics/drawable/Drawable;

    move-result-object p0

    invoke-static {p1, p0}, Lcom/facebook/accountkit/ui/ViewUtility;->setBackground(Landroid/view/View;Landroid/graphics/drawable/Drawable;)V

    return-void
.end method

.method private static applyProgressBarThemeAttributes(Landroid/content/Context;Lcom/facebook/accountkit/ui/UIManager;Landroid/widget/ProgressBar;)V
    .locals 1

    invoke-virtual {p2}, Landroid/widget/ProgressBar;->getIndeterminateDrawable()Landroid/graphics/drawable/Drawable;

    move-result-object p2

    invoke-static {p1}, Lcom/facebook/accountkit/ui/ViewUtility;->useLegacy(Lcom/facebook/accountkit/ui/UIManager;)Z

    move-result v0

    if-eqz v0, :cond_0

    sget p1, Lcom/facebook/accountkit/R$attr;->com_accountkit_icon_color:I

    const/high16 v0, -0x1000000

    invoke-static {p0, p1, v0}, Lcom/facebook/accountkit/ui/ViewUtility;->getColor(Landroid/content/Context;II)I

    move-result p1

    goto :goto_0

    :cond_0
    invoke-static {p0, p1}, Lcom/facebook/accountkit/ui/ViewUtility;->getPrimaryColor(Landroid/content/Context;Lcom/facebook/accountkit/ui/UIManager;)I

    move-result p1

    :goto_0
    invoke-static {p0, p2, p1}, Lcom/facebook/accountkit/ui/ViewUtility;->applyThemeColor(Landroid/content/Context;Landroid/graphics/drawable/Drawable;I)V

    return-void
.end method

.method private static applySkinThemedBackground(Landroid/content/Context;Lcom/facebook/accountkit/ui/SkinManager;Landroid/view/View;)V
    .locals 2

    invoke-virtual {p1}, Lcom/facebook/accountkit/ui/SkinManager;->hasBackgroundImage()Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-virtual {p0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object p0

    invoke-virtual {p1}, Lcom/facebook/accountkit/ui/SkinManager;->getBackgroundImageResId()I

    move-result v0

    invoke-static {p0, v0}, Lcom/facebook/accountkit/ui/ViewUtility;->getDrawable(Landroid/content/res/Resources;I)Landroid/graphics/drawable/Drawable;

    move-result-object p0

    goto :goto_0

    :cond_0
    new-instance v0, Landroid/graphics/drawable/ColorDrawable;

    sget v1, Lcom/facebook/accountkit/R$color;->com_accountkit_default_skin_background:I

    invoke-static {p0, v1}, Landroid/support/v4/content/ContextCompat;->getColor(Landroid/content/Context;I)I

    move-result p0

    invoke-direct {v0, p0}, Landroid/graphics/drawable/ColorDrawable;-><init>(I)V

    move-object p0, v0

    :goto_0
    invoke-virtual {p1}, Lcom/facebook/accountkit/ui/SkinManager;->hasBackgroundImage()Z

    move-result v0

    if-eqz v0, :cond_2

    instance-of v0, p2, Lcom/facebook/accountkit/ui/AspectFrameLayout;

    if-eqz v0, :cond_1

    move-object v0, p2

    check-cast v0, Lcom/facebook/accountkit/ui/AspectFrameLayout;

    invoke-virtual {p0}, Landroid/graphics/drawable/Drawable;->getIntrinsicWidth()I

    move-result v1

    invoke-virtual {v0, v1}, Lcom/facebook/accountkit/ui/AspectFrameLayout;->setAspectWidth(I)V

    invoke-virtual {p0}, Landroid/graphics/drawable/Drawable;->getIntrinsicHeight()I

    move-result v1

    invoke-virtual {v0, v1}, Lcom/facebook/accountkit/ui/AspectFrameLayout;->setAspectHeight(I)V

    :cond_1
    invoke-virtual {p1}, Lcom/facebook/accountkit/ui/SkinManager;->getTintColor()I

    move-result p1

    sget-object v0, Landroid/graphics/PorterDuff$Mode;->SRC_ATOP:Landroid/graphics/PorterDuff$Mode;

    invoke-virtual {p0, p1, v0}, Landroid/graphics/drawable/Drawable;->setColorFilter(ILandroid/graphics/PorterDuff$Mode;)V

    :cond_2
    invoke-static {p2, p0}, Lcom/facebook/accountkit/ui/ViewUtility;->setBackground(Landroid/view/View;Landroid/graphics/drawable/Drawable;)V

    return-void
.end method

.method private static applySpinnerThemeAttributes(Landroid/content/Context;Lcom/facebook/accountkit/ui/UIManager;Lcom/facebook/accountkit/ui/CountryCodeSpinner;)V
    .locals 4

    invoke-virtual {p2}, Lcom/facebook/accountkit/ui/CountryCodeSpinner;->getParent()Landroid/view/ViewParent;

    move-result-object p2

    check-cast p2, Landroid/view/ViewGroup;

    const/4 v0, 0x1

    invoke-virtual {p2, v0}, Landroid/view/ViewGroup;->getChildAt(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ImageView;

    const/4 v1, 0x2

    invoke-virtual {p2, v1}, Landroid/view/ViewGroup;->getChildAt(I)Landroid/view/View;

    move-result-object v1

    invoke-virtual {v0}, Landroid/widget/ImageView;->getDrawable()Landroid/graphics/drawable/Drawable;

    move-result-object v0

    invoke-static {v0}, Landroid/support/v4/graphics/drawable/DrawableCompat;->wrap(Landroid/graphics/drawable/Drawable;)Landroid/graphics/drawable/Drawable;

    move-result-object v0

    invoke-virtual {v0}, Landroid/graphics/drawable/Drawable;->mutate()Landroid/graphics/drawable/Drawable;

    move-result-object v0

    sget-object v2, Lcom/facebook/accountkit/ui/SkinManager$Skin;->CONTEMPORARY:Lcom/facebook/accountkit/ui/SkinManager$Skin;

    invoke-static {p1, v2}, Lcom/facebook/accountkit/ui/ViewUtility;->isSkin(Lcom/facebook/accountkit/ui/UIManager;Lcom/facebook/accountkit/ui/SkinManager$Skin;)Z

    move-result v2

    if-eqz v2, :cond_0

    const/4 p2, 0x0

    invoke-virtual {v1, p2}, Landroid/view/View;->setVisibility(I)V

    new-instance p2, Landroid/graphics/drawable/ColorDrawable;

    invoke-static {p0, p1}, Lcom/facebook/accountkit/ui/ViewUtility;->getPrimaryColor(Landroid/content/Context;Lcom/facebook/accountkit/ui/UIManager;)I

    move-result v2

    invoke-direct {p2, v2}, Landroid/graphics/drawable/ColorDrawable;-><init>(I)V

    invoke-static {v1, p2}, Lcom/facebook/accountkit/ui/ViewUtility;->setBackground(Landroid/view/View;Landroid/graphics/drawable/Drawable;)V

    invoke-static {p0, p1}, Lcom/facebook/accountkit/ui/ViewUtility;->getPrimaryColor(Landroid/content/Context;Lcom/facebook/accountkit/ui/UIManager;)I

    move-result p0

    invoke-static {v0, p0}, Landroid/support/v4/graphics/drawable/DrawableCompat;->setTint(Landroid/graphics/drawable/Drawable;I)V

    return-void

    :cond_0
    sget-object v2, Lcom/facebook/accountkit/ui/SkinManager$Skin;->TRANSLUCENT:Lcom/facebook/accountkit/ui/SkinManager$Skin;

    invoke-static {p1, v2}, Lcom/facebook/accountkit/ui/ViewUtility;->isSkin(Lcom/facebook/accountkit/ui/UIManager;Lcom/facebook/accountkit/ui/SkinManager$Skin;)Z

    move-result v2

    const/16 v3, 0x8

    if-nez v2, :cond_2

    sget-object v2, Lcom/facebook/accountkit/ui/SkinManager$Skin;->CLASSIC:Lcom/facebook/accountkit/ui/SkinManager$Skin;

    invoke-static {p1, v2}, Lcom/facebook/accountkit/ui/ViewUtility;->isSkin(Lcom/facebook/accountkit/ui/UIManager;Lcom/facebook/accountkit/ui/SkinManager$Skin;)Z

    move-result v2

    if-eqz v2, :cond_1

    goto :goto_0

    :cond_1
    invoke-virtual {v1, v3}, Landroid/view/View;->setVisibility(I)V

    sget v1, Lcom/facebook/accountkit/R$attr;->com_accountkit_input_accent_color:I

    const/high16 v2, -0x1000000

    invoke-static {p0, v1, v2}, Lcom/facebook/accountkit/ui/ViewUtility;->getColor(Landroid/content/Context;II)I

    move-result v1

    goto :goto_1

    :cond_2
    :goto_0
    invoke-virtual {v1, v3}, Landroid/view/View;->setVisibility(I)V

    move-object v1, p1

    check-cast v1, Lcom/facebook/accountkit/ui/SkinManager;

    invoke-virtual {v1}, Lcom/facebook/accountkit/ui/SkinManager;->getTextColor()I

    move-result v1

    :goto_1
    invoke-static {v0, v1}, Landroid/support/v4/graphics/drawable/DrawableCompat;->setTint(Landroid/graphics/drawable/Drawable;I)V

    invoke-static {p0, p1, p2}, Lcom/facebook/accountkit/ui/ViewUtility;->applyInputThemeAttributes(Landroid/content/Context;Lcom/facebook/accountkit/ui/UIManager;Landroid/view/View;)V

    return-void
.end method

.method private static applyTextViewThemeAttributes(Landroid/content/Context;Lcom/facebook/accountkit/ui/UIManager;Landroid/widget/TextView;)V
    .locals 1

    invoke-static {p1}, Lcom/facebook/accountkit/ui/ViewUtility;->useLegacy(Lcom/facebook/accountkit/ui/UIManager;)Z

    move-result v0

    if-eqz v0, :cond_0

    sget p1, Lcom/facebook/accountkit/R$attr;->com_accountkit_text_color:I

    const v0, 0x1060001

    invoke-static {p0, v0}, Landroid/support/v4/content/ContextCompat;->getColor(Landroid/content/Context;I)I

    move-result v0

    invoke-static {p0, p1, v0}, Lcom/facebook/accountkit/ui/ViewUtility;->getColor(Landroid/content/Context;II)I

    move-result p0

    goto :goto_0

    :cond_0
    check-cast p1, Lcom/facebook/accountkit/ui/SkinManager;

    invoke-virtual {p1}, Lcom/facebook/accountkit/ui/SkinManager;->getTextColor()I

    move-result p0

    :goto_0
    invoke-virtual {p2, p0}, Landroid/widget/TextView;->setTextColor(I)V

    invoke-virtual {p2, p0}, Landroid/widget/TextView;->setLinkTextColor(I)V

    return-void
.end method

.method static applyThemeAttributes(Landroid/content/Context;Lcom/facebook/accountkit/ui/UIManager;Landroid/view/View;)V
    .locals 3

    if-eqz p0, :cond_6

    if-nez p2, :cond_0

    return-void

    :cond_0
    instance-of v0, p2, Landroid/widget/Button;

    if-eqz v0, :cond_1

    check-cast p2, Landroid/widget/Button;

    invoke-static {p0, p1, p2}, Lcom/facebook/accountkit/ui/ViewUtility;->applyButtonThemeAttributes(Landroid/content/Context;Lcom/facebook/accountkit/ui/UIManager;Landroid/widget/Button;)V

    return-void

    :cond_1
    instance-of v0, p2, Landroid/widget/EditText;

    if-eqz v0, :cond_2

    check-cast p2, Landroid/widget/EditText;

    invoke-static {p0, p1, p2}, Lcom/facebook/accountkit/ui/ViewUtility;->applyInputThemeAttributes(Landroid/content/Context;Lcom/facebook/accountkit/ui/UIManager;Landroid/widget/EditText;)V

    return-void

    :cond_2
    instance-of v0, p2, Landroid/widget/ProgressBar;

    if-eqz v0, :cond_3

    check-cast p2, Landroid/widget/ProgressBar;

    invoke-static {p0, p1, p2}, Lcom/facebook/accountkit/ui/ViewUtility;->applyProgressBarThemeAttributes(Landroid/content/Context;Lcom/facebook/accountkit/ui/UIManager;Landroid/widget/ProgressBar;)V

    return-void

    :cond_3
    instance-of v0, p2, Lcom/facebook/accountkit/ui/CountryCodeSpinner;

    if-eqz v0, :cond_4

    check-cast p2, Lcom/facebook/accountkit/ui/CountryCodeSpinner;

    invoke-static {p0, p1, p2}, Lcom/facebook/accountkit/ui/ViewUtility;->applySpinnerThemeAttributes(Landroid/content/Context;Lcom/facebook/accountkit/ui/UIManager;Lcom/facebook/accountkit/ui/CountryCodeSpinner;)V

    return-void

    :cond_4
    instance-of v0, p2, Landroid/widget/TextView;

    if-eqz v0, :cond_5

    check-cast p2, Landroid/widget/TextView;

    invoke-static {p0, p1, p2}, Lcom/facebook/accountkit/ui/ViewUtility;->applyTextViewThemeAttributes(Landroid/content/Context;Lcom/facebook/accountkit/ui/UIManager;Landroid/widget/TextView;)V

    return-void

    :cond_5
    instance-of v0, p2, Landroid/view/ViewGroup;

    if-eqz v0, :cond_6

    check-cast p2, Landroid/view/ViewGroup;

    invoke-virtual {p2}, Landroid/view/ViewGroup;->getChildCount()I

    move-result v0

    const/4 v1, 0x0

    :goto_0
    if-ge v1, v0, :cond_6

    invoke-virtual {p2, v1}, Landroid/view/ViewGroup;->getChildAt(I)Landroid/view/View;

    move-result-object v2

    invoke-static {p0, p1, v2}, Lcom/facebook/accountkit/ui/ViewUtility;->applyThemeAttributes(Landroid/content/Context;Lcom/facebook/accountkit/ui/UIManager;Landroid/view/View;)V

    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    :cond_6
    return-void
.end method

.method static applyThemeBackground(Landroid/content/Context;Lcom/facebook/accountkit/ui/UIManager;Landroid/view/View;)V
    .locals 1

    if-eqz p0, :cond_2

    if-nez p2, :cond_0

    return-void

    :cond_0
    instance-of v0, p1, Lcom/facebook/accountkit/ui/SkinManager;

    if-eqz v0, :cond_1

    check-cast p1, Lcom/facebook/accountkit/ui/SkinManager;

    invoke-static {p0, p1, p2}, Lcom/facebook/accountkit/ui/ViewUtility;->applySkinThemedBackground(Landroid/content/Context;Lcom/facebook/accountkit/ui/SkinManager;Landroid/view/View;)V

    return-void

    :cond_1
    invoke-static {p0, p2}, Lcom/facebook/accountkit/ui/ViewUtility;->applyLegacyThemedBackground(Landroid/content/Context;Landroid/view/View;)V

    :cond_2
    return-void
.end method

.method static applyThemeColor(Landroid/content/Context;Landroid/graphics/drawable/Drawable;I)V
    .locals 0
    .param p2    # I
        .annotation build Landroid/support/annotation/ColorInt;
        .end annotation
    .end param

    if-eqz p0, :cond_1

    if-nez p1, :cond_0

    return-void

    :cond_0
    sget-object p0, Landroid/graphics/PorterDuff$Mode;->SRC_ATOP:Landroid/graphics/PorterDuff$Mode;

    invoke-virtual {p1, p2, p0}, Landroid/graphics/drawable/Drawable;->setColorFilter(ILandroid/graphics/PorterDuff$Mode;)V

    :cond_1
    return-void
.end method

.method static applyThemeColor(Landroid/content/Context;Landroid/widget/ImageView;I)V
    .locals 0
    .param p2    # I
        .annotation build Landroid/support/annotation/ColorInt;
        .end annotation
    .end param

    if-eqz p0, :cond_1

    if-nez p1, :cond_0

    return-void

    :cond_0
    sget-object p0, Landroid/graphics/PorterDuff$Mode;->SRC_ATOP:Landroid/graphics/PorterDuff$Mode;

    invoke-virtual {p1, p2, p0}, Landroid/widget/ImageView;->setColorFilter(ILandroid/graphics/PorterDuff$Mode;)V

    :cond_1
    return-void
.end method

.method static doesTextColorContrast(Landroid/content/Context;Lcom/facebook/accountkit/ui/UIManager;)Z
    .locals 5

    invoke-interface {p1}, Lcom/facebook/accountkit/ui/UIManager;->getThemeId()I

    move-result v0

    const/4 v1, 0x1

    const/4 v2, -0x1

    if-eq v0, v2, :cond_0

    invoke-virtual {p0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/res/Resources;->newTheme()Landroid/content/res/Resources$Theme;

    move-result-object v0

    invoke-virtual {p0}, Landroid/content/Context;->getTheme()Landroid/content/res/Resources$Theme;

    move-result-object v3

    invoke-virtual {v0, v3}, Landroid/content/res/Resources$Theme;->setTo(Landroid/content/res/Resources$Theme;)V

    invoke-interface {p1}, Lcom/facebook/accountkit/ui/UIManager;->getThemeId()I

    move-result v3

    invoke-virtual {v0, v3, v1}, Landroid/content/res/Resources$Theme;->applyStyle(IZ)V

    goto :goto_0

    :cond_0
    invoke-virtual {p0}, Landroid/content/Context;->getTheme()Landroid/content/res/Resources$Theme;

    move-result-object v0

    :goto_0
    invoke-static {p1}, Lcom/facebook/accountkit/ui/ViewUtility;->useLegacy(Lcom/facebook/accountkit/ui/UIManager;)Z

    move-result v3

    if-eqz v3, :cond_1

    sget v3, Lcom/facebook/accountkit/R$attr;->com_accountkit_text_color:I

    const v4, 0x1060001

    invoke-static {p0, v4}, Landroid/support/v4/content/ContextCompat;->getColor(Landroid/content/Context;I)I

    move-result p0

    invoke-static {v0, v3, p0}, Lcom/facebook/accountkit/ui/ViewUtility;->getColor(Landroid/content/res/Resources$Theme;II)I

    move-result p0

    goto :goto_1

    :cond_1
    move-object p0, p1

    check-cast p0, Lcom/facebook/accountkit/ui/SkinManager;

    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/SkinManager;->getTextColor()I

    move-result p0

    :goto_1
    invoke-static {p1}, Lcom/facebook/accountkit/ui/ViewUtility;->useLegacy(Lcom/facebook/accountkit/ui/UIManager;)Z

    move-result v3

    if-eqz v3, :cond_2

    sget p1, Lcom/facebook/accountkit/R$attr;->com_accountkit_background_color:I

    invoke-static {v0, p1, v2}, Lcom/facebook/accountkit/ui/ViewUtility;->getColor(Landroid/content/res/Resources$Theme;II)I

    move-result p1

    goto :goto_2

    :cond_2
    check-cast p1, Lcom/facebook/accountkit/ui/SkinManager;

    invoke-virtual {p1}, Lcom/facebook/accountkit/ui/SkinManager;->getTintColor()I

    move-result p1

    :goto_2
    const/high16 v0, -0x1000000

    or-int/2addr p0, v0

    or-int/2addr p1, v0

    invoke-static {p0, p1}, Landroid/support/v4/graphics/ColorUtils;->calculateContrast(II)D

    move-result-wide p0

    const-wide/high16 v2, 0x3ff8000000000000L    # 1.5

    cmpl-double v0, p0, v2

    if-ltz v0, :cond_3

    return v1

    :cond_3
    const/4 v1, 0x0

    return v1
.end method

.method private static getButtonBackgroundDrawable(Landroid/content/Context;IIIIII)Landroid/graphics/drawable/Drawable;
    .locals 6

    new-instance v0, Landroid/graphics/drawable/StateListDrawable;

    invoke-direct {v0}, Landroid/graphics/drawable/StateListDrawable;-><init>()V

    sget v1, Landroid/os/Build$VERSION;->SDK_INT:I

    const v2, -0x101009e

    const/4 v3, 0x1

    const/4 v4, 0x0

    const/16 v5, 0x15

    if-lt v1, v5, :cond_0

    new-array p0, v3, [I

    aput v2, p0, v4

    new-instance p2, Landroid/graphics/drawable/RippleDrawable;

    new-instance p3, Landroid/content/res/ColorStateList;

    new-array p4, v3, [[I

    new-array p6, v4, [I

    aput-object p6, p4, v4

    new-array p6, v3, [I

    aput p1, p6, v4

    invoke-direct {p3, p4, p6}, Landroid/content/res/ColorStateList;-><init>([[I[I)V

    new-instance p4, Landroid/graphics/drawable/ColorDrawable;

    invoke-direct {p4, p5}, Landroid/graphics/drawable/ColorDrawable;-><init>(I)V

    const/4 p6, 0x0

    invoke-direct {p2, p3, p4, p6}, Landroid/graphics/drawable/RippleDrawable;-><init>(Landroid/content/res/ColorStateList;Landroid/graphics/drawable/Drawable;Landroid/graphics/drawable/Drawable;)V

    invoke-virtual {v0, p0, p2}, Landroid/graphics/drawable/StateListDrawable;->addState([ILandroid/graphics/drawable/Drawable;)V

    new-array p0, v4, [I

    new-instance p2, Landroid/graphics/drawable/RippleDrawable;

    new-instance p3, Landroid/content/res/ColorStateList;

    new-array p4, v3, [[I

    new-array v1, v4, [I

    aput-object v1, p4, v4

    new-array v1, v3, [I

    aput p5, v1, v4

    invoke-direct {p3, p4, v1}, Landroid/content/res/ColorStateList;-><init>([[I[I)V

    new-instance p4, Landroid/graphics/drawable/ColorDrawable;

    invoke-direct {p4, p1}, Landroid/graphics/drawable/ColorDrawable;-><init>(I)V

    invoke-direct {p2, p3, p4, p6}, Landroid/graphics/drawable/RippleDrawable;-><init>(Landroid/content/res/ColorStateList;Landroid/graphics/drawable/Drawable;Landroid/graphics/drawable/Drawable;)V

    invoke-virtual {v0, p0, p2}, Landroid/graphics/drawable/StateListDrawable;->addState([ILandroid/graphics/drawable/Drawable;)V

    return-object v0

    :cond_0
    new-array v1, v3, [I

    aput v2, v1, v4

    invoke-static {p0, p5, p6}, Lcom/facebook/accountkit/ui/ViewUtility;->getInputBackgroundDrawable(Landroid/content/Context;II)Landroid/graphics/drawable/Drawable;

    move-result-object p5

    invoke-virtual {v0, v1, p5}, Landroid/graphics/drawable/StateListDrawable;->addState([ILandroid/graphics/drawable/Drawable;)V

    new-array p5, v3, [I

    const p6, 0x10100a7

    aput p6, p5, v4

    invoke-static {p0, p3, p4}, Lcom/facebook/accountkit/ui/ViewUtility;->getInputBackgroundDrawable(Landroid/content/Context;II)Landroid/graphics/drawable/Drawable;

    move-result-object p3

    invoke-virtual {v0, p5, p3}, Landroid/graphics/drawable/StateListDrawable;->addState([ILandroid/graphics/drawable/Drawable;)V

    new-array p3, v4, [I

    invoke-static {p0, p1, p2}, Lcom/facebook/accountkit/ui/ViewUtility;->getInputBackgroundDrawable(Landroid/content/Context;II)Landroid/graphics/drawable/Drawable;

    move-result-object p0

    invoke-virtual {v0, p3, p0}, Landroid/graphics/drawable/StateListDrawable;->addState([ILandroid/graphics/drawable/Drawable;)V

    return-object v0
.end method

.method static getButtonColor(Landroid/content/Context;Lcom/facebook/accountkit/ui/UIManager;)I
    .locals 1
    .annotation build Landroid/support/annotation/ColorInt;
    .end annotation

    instance-of v0, p1, Lcom/facebook/accountkit/ui/SkinManager;

    if-eqz v0, :cond_0

    check-cast p1, Lcom/facebook/accountkit/ui/SkinManager;

    invoke-virtual {p1}, Lcom/facebook/accountkit/ui/SkinManager;->getPrimaryColor()I

    move-result p0

    return p0

    :cond_0
    sget p1, Lcom/facebook/accountkit/R$attr;->com_accountkit_button_background_color:I

    const v0, -0x333334

    invoke-static {p0, p1, v0}, Lcom/facebook/accountkit/ui/ViewUtility;->getColor(Landroid/content/Context;II)I

    move-result p0

    return p0
.end method

.method static getButtonTextColor(Landroid/content/Context;Lcom/facebook/accountkit/ui/UIManager;)I
    .locals 1
    .annotation build Landroid/support/annotation/ColorInt;
    .end annotation

    invoke-static {p1}, Lcom/facebook/accountkit/ui/ViewUtility;->useLegacy(Lcom/facebook/accountkit/ui/UIManager;)Z

    move-result v0

    if-nez v0, :cond_0

    check-cast p1, Lcom/facebook/accountkit/ui/SkinManager;

    invoke-virtual {p1}, Lcom/facebook/accountkit/ui/SkinManager;->getTextColor()I

    move-result p0

    return p0

    :cond_0
    sget p1, Lcom/facebook/accountkit/R$attr;->com_accountkit_button_text_color:I

    const/high16 v0, -0x1000000

    invoke-static {p0, p1, v0}, Lcom/facebook/accountkit/ui/ViewUtility;->getColor(Landroid/content/Context;II)I

    move-result p0

    return p0
.end method

.method private static getButtonTextColorStateList(Landroid/content/Context;Lcom/facebook/accountkit/ui/UIManager;)Landroid/content/res/ColorStateList;
    .locals 6

    const/4 v0, 0x3

    new-array v1, v0, [[I

    const/4 v2, 0x1

    new-array v3, v2, [I

    const/4 v4, 0x0

    const v5, -0x101009e

    aput v5, v3, v4

    aput-object v3, v1, v4

    new-array v3, v2, [I

    const v5, 0x10100a7

    aput v5, v3, v4

    aput-object v3, v1, v2

    new-array v3, v4, [I

    const/4 v5, 0x2

    aput-object v3, v1, v5

    invoke-static {p1}, Lcom/facebook/accountkit/ui/ViewUtility;->useLegacy(Lcom/facebook/accountkit/ui/UIManager;)Z

    move-result v3

    if-nez v3, :cond_0

    check-cast p1, Lcom/facebook/accountkit/ui/SkinManager;

    invoke-virtual {p1}, Lcom/facebook/accountkit/ui/SkinManager;->getTextColor()I

    move-result p0

    new-array p1, v0, [I

    aput p0, p1, v4

    aput p0, p1, v2

    aput p0, p1, v5

    goto :goto_0

    :cond_0
    new-array p1, v0, [I

    sget v0, Lcom/facebook/accountkit/R$attr;->com_accountkit_button_disabled_text_color:I

    const v3, -0x333334

    invoke-static {p0, v0, v3}, Lcom/facebook/accountkit/ui/ViewUtility;->getColor(Landroid/content/Context;II)I

    move-result v0

    aput v0, p1, v4

    sget v0, Lcom/facebook/accountkit/R$attr;->com_accountkit_button_pressed_text_color:I

    const v3, -0xbbbbbc

    invoke-static {p0, v0, v3}, Lcom/facebook/accountkit/ui/ViewUtility;->getColor(Landroid/content/Context;II)I

    move-result v0

    aput v0, p1, v2

    sget v0, Lcom/facebook/accountkit/R$attr;->com_accountkit_button_text_color:I

    const/high16 v2, -0x1000000

    invoke-static {p0, v0, v2}, Lcom/facebook/accountkit/ui/ViewUtility;->getColor(Landroid/content/Context;II)I

    move-result p0

    aput p0, p1, v5

    :goto_0
    new-instance p0, Landroid/content/res/ColorStateList;

    invoke-direct {p0, v1, p1}, Landroid/content/res/ColorStateList;-><init>([[I[I)V

    return-object p0
.end method

.method static getColor(Landroid/content/Context;II)I
    .locals 0
    .param p1    # I
        .annotation build Landroid/support/annotation/AttrRes;
        .end annotation
    .end param
    .annotation build Landroid/support/annotation/ColorInt;
    .end annotation

    invoke-virtual {p0}, Landroid/content/Context;->getTheme()Landroid/content/res/Resources$Theme;

    move-result-object p0

    invoke-static {p0, p1, p2}, Lcom/facebook/accountkit/ui/ViewUtility;->getColor(Landroid/content/res/Resources$Theme;II)I

    move-result p0

    return p0
.end method

.method static getColor(Landroid/content/res/Resources$Theme;II)I
    .locals 2
    .param p1    # I
        .annotation build Landroid/support/annotation/AttrRes;
        .end annotation
    .end param
    .annotation build Landroid/support/annotation/ColorInt;
    .end annotation

    new-instance v0, Landroid/util/TypedValue;

    invoke-direct {v0}, Landroid/util/TypedValue;-><init>()V

    const/4 v1, 0x1

    invoke-virtual {p0, p1, v0, v1}, Landroid/content/res/Resources$Theme;->resolveAttribute(ILandroid/util/TypedValue;Z)Z

    move-result p0

    if-eqz p0, :cond_0

    iget p2, v0, Landroid/util/TypedValue;->data:I

    :cond_0
    return p2
.end method

.method static getDimensionPixelSize(Landroid/content/Context;I)I
    .locals 1

    int-to-float p1, p1

    invoke-virtual {p0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object p0

    invoke-virtual {p0}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object p0

    const/4 v0, 0x1

    invoke-static {v0, p1, p0}, Landroid/util/TypedValue;->applyDimension(IFLandroid/util/DisplayMetrics;)F

    move-result p0

    float-to-int p0, p0

    return p0
.end method

.method private static getDrawable(Landroid/content/res/Resources;I)Landroid/graphics/drawable/Drawable;
    .locals 2

    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x16

    if-ge v0, v1, :cond_0

    invoke-virtual {p0, p1}, Landroid/content/res/Resources;->getDrawable(I)Landroid/graphics/drawable/Drawable;

    move-result-object p0

    return-object p0

    :cond_0
    const/4 v0, 0x0

    invoke-virtual {p0, p1, v0}, Landroid/content/res/Resources;->getDrawable(ILandroid/content/res/Resources$Theme;)Landroid/graphics/drawable/Drawable;

    move-result-object p0

    return-object p0
.end method

.method private static getInputBackgroundDrawable(Landroid/content/Context;II)Landroid/graphics/drawable/Drawable;
    .locals 1
    .param p1    # I
        .annotation build Landroid/support/annotation/ColorInt;
        .end annotation
    .end param
    .param p2    # I
        .annotation build Landroid/support/annotation/ColorInt;
        .end annotation
    .end param

    new-instance v0, Landroid/graphics/drawable/GradientDrawable;

    invoke-direct {v0}, Landroid/graphics/drawable/GradientDrawable;-><init>()V

    invoke-virtual {p0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object p0

    invoke-virtual {v0, p1}, Landroid/graphics/drawable/GradientDrawable;->setColor(I)V

    sget p1, Lcom/facebook/accountkit/R$dimen;->com_accountkit_input_corner_radius:I

    invoke-virtual {p0, p1}, Landroid/content/res/Resources;->getDimension(I)F

    move-result p1

    invoke-virtual {v0, p1}, Landroid/graphics/drawable/GradientDrawable;->setCornerRadius(F)V

    sget p1, Lcom/facebook/accountkit/R$dimen;->com_accountkit_input_border:I

    invoke-virtual {p0, p1}, Landroid/content/res/Resources;->getDimensionPixelSize(I)I

    move-result p0

    invoke-virtual {v0, p0, p2}, Landroid/graphics/drawable/GradientDrawable;->setStroke(II)V

    return-object v0
.end method

.method private static getLegacyThemedBackground(Landroid/content/Context;Landroid/view/View;)Landroid/graphics/drawable/Drawable;
    .locals 4

    invoke-virtual {p0}, Landroid/content/Context;->getTheme()Landroid/content/res/Resources$Theme;

    move-result-object v0

    new-instance v1, Landroid/util/TypedValue;

    invoke-direct {v1}, Landroid/util/TypedValue;-><init>()V

    sget v2, Lcom/facebook/accountkit/R$attr;->com_accountkit_background:I

    const/4 v3, 0x1

    invoke-virtual {v0, v2, v1, v3}, Landroid/content/res/Resources$Theme;->resolveAttribute(ILandroid/util/TypedValue;Z)Z

    iget v0, v1, Landroid/util/TypedValue;->resourceId:I

    const/4 v2, -0x1

    if-nez v0, :cond_0

    new-instance v0, Landroid/graphics/drawable/ColorDrawable;

    sget v3, Lcom/facebook/accountkit/R$attr;->com_accountkit_background_color:I

    invoke-static {p0, v3, v2}, Lcom/facebook/accountkit/ui/ViewUtility;->getColor(Landroid/content/Context;II)I

    move-result v3

    invoke-direct {v0, v3}, Landroid/graphics/drawable/ColorDrawable;-><init>(I)V

    goto :goto_0

    :cond_0
    invoke-virtual {p0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    iget v3, v1, Landroid/util/TypedValue;->resourceId:I

    invoke-static {v0, v3}, Lcom/facebook/accountkit/ui/ViewUtility;->getDrawable(Landroid/content/res/Resources;I)Landroid/graphics/drawable/Drawable;

    move-result-object v0

    :goto_0
    iget v1, v1, Landroid/util/TypedValue;->resourceId:I

    if-lez v1, :cond_2

    instance-of v1, p1, Lcom/facebook/accountkit/ui/AspectFrameLayout;

    if-eqz v1, :cond_1

    check-cast p1, Lcom/facebook/accountkit/ui/AspectFrameLayout;

    invoke-virtual {v0}, Landroid/graphics/drawable/Drawable;->getIntrinsicWidth()I

    move-result v1

    invoke-virtual {p1, v1}, Lcom/facebook/accountkit/ui/AspectFrameLayout;->setAspectWidth(I)V

    invoke-virtual {v0}, Landroid/graphics/drawable/Drawable;->getIntrinsicHeight()I

    move-result v1

    invoke-virtual {p1, v1}, Lcom/facebook/accountkit/ui/AspectFrameLayout;->setAspectHeight(I)V

    :cond_1
    sget p1, Lcom/facebook/accountkit/R$attr;->com_accountkit_background_color:I

    invoke-static {p0, p1, v2}, Lcom/facebook/accountkit/ui/ViewUtility;->getColor(Landroid/content/Context;II)I

    move-result p1

    invoke-static {p0, v0, p1}, Lcom/facebook/accountkit/ui/ViewUtility;->applyThemeColor(Landroid/content/Context;Landroid/graphics/drawable/Drawable;I)V

    :cond_2
    return-object v0
.end method

.method static getPrimaryColor(Landroid/content/Context;Lcom/facebook/accountkit/ui/UIManager;)I
    .locals 1
    .annotation build Landroid/support/annotation/ColorInt;
    .end annotation

    instance-of v0, p1, Lcom/facebook/accountkit/ui/SkinManager;

    if-eqz v0, :cond_0

    check-cast p1, Lcom/facebook/accountkit/ui/SkinManager;

    invoke-virtual {p1}, Lcom/facebook/accountkit/ui/SkinManager;->getPrimaryColor()I

    move-result p0

    return p0

    :cond_0
    sget p1, Lcom/facebook/accountkit/R$attr;->com_accountkit_primary_color:I

    const v0, -0x333334

    invoke-static {p0, p1, v0}, Lcom/facebook/accountkit/ui/ViewUtility;->getColor(Landroid/content/Context;II)I

    move-result p0

    return p0
.end method

.method static hideKeyboard(Landroid/app/Activity;)V
    .locals 2

    const v0, 0x1020002

    invoke-virtual {p0, v0}, Landroid/app/Activity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    if-nez v0, :cond_0

    return-void

    :cond_0
    invoke-virtual {v0}, Landroid/view/View;->findFocus()Landroid/view/View;

    move-result-object v1

    if-eqz v1, :cond_1

    invoke-virtual {v1}, Landroid/view/View;->clearFocus()V

    :cond_1
    const-string v1, "input_method"

    invoke-virtual {p0, v1}, Landroid/app/Activity;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object p0

    check-cast p0, Landroid/view/inputmethod/InputMethodManager;

    invoke-virtual {v0}, Landroid/view/View;->getWindowToken()Landroid/os/IBinder;

    move-result-object v0

    const/4 v1, 0x1

    invoke-virtual {p0, v0, v1}, Landroid/view/inputmethod/InputMethodManager;->hideSoftInputFromWindow(Landroid/os/IBinder;I)Z

    return-void
.end method

.method static isSkin(Lcom/facebook/accountkit/ui/UIManager;Lcom/facebook/accountkit/ui/SkinManager$Skin;)Z
    .locals 1

    instance-of v0, p0, Lcom/facebook/accountkit/ui/SkinManager;

    if-eqz v0, :cond_0

    check-cast p0, Lcom/facebook/accountkit/ui/SkinManager;

    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/SkinManager;->getSkin()Lcom/facebook/accountkit/ui/SkinManager$Skin;

    move-result-object p0

    if-ne p0, p1, :cond_0

    const/4 p0, 0x1

    return p0

    :cond_0
    const/4 p0, 0x0

    return p0
.end method

.method static isTablet(Landroid/content/Context;)Z
    .locals 4

    invoke-virtual {p0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/res/Resources;->getConfiguration()Landroid/content/res/Configuration;

    move-result-object v0

    iget v0, v0, Landroid/content/res/Configuration;->screenLayout:I

    and-int/lit8 v0, v0, 0xf

    const/4 v1, 0x0

    const/4 v2, 0x1

    const/4 v3, 0x4

    if-ne v0, v3, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    invoke-virtual {p0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object p0

    invoke-virtual {p0}, Landroid/content/res/Resources;->getConfiguration()Landroid/content/res/Configuration;

    move-result-object p0

    iget p0, p0, Landroid/content/res/Configuration;->screenLayout:I

    and-int/lit8 p0, p0, 0xf

    const/4 v3, 0x3

    if-ne p0, v3, :cond_1

    const/4 p0, 0x1

    goto :goto_1

    :cond_1
    const/4 p0, 0x0

    :goto_1
    if-nez v0, :cond_2

    if-eqz p0, :cond_3

    :cond_2
    const/4 v1, 0x1

    :cond_3
    return v1
.end method

.method static setBackground(Landroid/view/View;Landroid/graphics/drawable/Drawable;)V
    .locals 2

    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x10

    if-ge v0, v1, :cond_0

    invoke-virtual {p0, p1}, Landroid/view/View;->setBackgroundDrawable(Landroid/graphics/drawable/Drawable;)V

    return-void

    :cond_0
    invoke-virtual {p0, p1}, Landroid/view/View;->setBackground(Landroid/graphics/drawable/Drawable;)V

    return-void
.end method

.method static showKeyboard(Landroid/view/View;)V
    .locals 2

    if-eqz p0, :cond_1

    invoke-virtual {p0}, Landroid/view/View;->getContext()Landroid/content/Context;

    move-result-object v0

    if-nez v0, :cond_0

    return-void

    :cond_0
    invoke-virtual {p0}, Landroid/view/View;->requestFocus()Z

    move-result v0

    if-eqz v0, :cond_1

    invoke-virtual {p0}, Landroid/view/View;->getContext()Landroid/content/Context;

    move-result-object v0

    const-string v1, "input_method"

    invoke-virtual {v0, v1}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/view/inputmethod/InputMethodManager;

    const/4 v1, 0x1

    invoke-virtual {v0, p0, v1}, Landroid/view/inputmethod/InputMethodManager;->showSoftInput(Landroid/view/View;I)Z

    :cond_1
    return-void
.end method

.method static useLegacy(Lcom/facebook/accountkit/ui/UIManager;)Z
    .locals 0

    instance-of p0, p0, Lcom/facebook/accountkit/ui/SkinManager;

    if-nez p0, :cond_0

    const/4 p0, 0x1

    return p0

    :cond_0
    const/4 p0, 0x0

    return p0
.end method

.class public Lcom/facebook/accountkit/ui/ClearBackgroundTextInputLayout;
.super Landroid/support/design/widget/TextInputLayout;


# direct methods
.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;)V
    .locals 0

    invoke-direct {p0, p1, p2}, Landroid/support/design/widget/TextInputLayout;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;)V

    return-void
.end method

.method private clearBackground()V
    .locals 1

    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/ClearBackgroundTextInputLayout;->getEditText()Landroid/widget/EditText;

    move-result-object v0

    if-eqz v0, :cond_0

    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/ClearBackgroundTextInputLayout;->getEditText()Landroid/widget/EditText;

    move-result-object v0

    invoke-virtual {v0}, Landroid/widget/EditText;->getBackground()Landroid/graphics/drawable/Drawable;

    move-result-object v0

    invoke-virtual {v0}, Landroid/graphics/drawable/Drawable;->clearColorFilter()V

    :cond_0
    return-void
.end method


# virtual methods
.method public drawableStateChanged()V
    .locals 0

    invoke-super {p0}, Landroid/support/design/widget/TextInputLayout;->drawableStateChanged()V

    invoke-direct {p0}, Lcom/facebook/accountkit/ui/ClearBackgroundTextInputLayout;->clearBackground()V

    return-void
.end method

.method public setError(Ljava/lang/CharSequence;)V
    .locals 0

    invoke-super {p0, p1}, Landroid/support/design/widget/TextInputLayout;->setError(Ljava/lang/CharSequence;)V

    invoke-direct {p0}, Lcom/facebook/accountkit/ui/ClearBackgroundTextInputLayout;->clearBackground()V

    return-void
.end method

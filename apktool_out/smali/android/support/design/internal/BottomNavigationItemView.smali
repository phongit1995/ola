.class public Landroid/support/design/internal/BottomNavigationItemView;
.super Landroid/widget/FrameLayout;

# interfaces
.implements Landroid/support/v7/view/menu/MenuView$ItemView;


# annotations
.annotation build Landroid/support/annotation/RestrictTo;
    value = {
        .enum Landroid/support/annotation/RestrictTo$Scope;->LIBRARY_GROUP:Landroid/support/annotation/RestrictTo$Scope;
    }
.end annotation


# static fields
.field private static final CHECKED_STATE_SET:[I

.field public static final INVALID_ITEM_POSITION:I = -0x1


# instance fields
.field private final mDefaultMargin:I

.field private mIcon:Landroid/widget/ImageView;

.field private mIconTint:Landroid/content/res/ColorStateList;

.field private mItemData:Landroid/support/v7/view/menu/MenuItemImpl;

.field private mItemPosition:I

.field private final mLargeLabel:Landroid/widget/TextView;

.field private final mScaleDownFactor:F

.field private final mScaleUpFactor:F

.field private final mShiftAmount:I

.field private mShiftingMode:Z

.field private final mSmallLabel:Landroid/widget/TextView;


# direct methods
.method static constructor <clinit>()V
    .locals 3

    const/4 v0, 0x1

    new-array v0, v0, [I

    const/4 v1, 0x0

    const v2, 0x10100a0

    aput v2, v0, v1

    sput-object v0, Landroid/support/design/internal/BottomNavigationItemView;->CHECKED_STATE_SET:[I

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;)V
    .locals 1
    .param p1    # Landroid/content/Context;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param

    const/4 v0, 0x0

    invoke-direct {p0, p1, v0}, Landroid/support/design/internal/BottomNavigationItemView;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;)V

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;)V
    .locals 1
    .param p1    # Landroid/content/Context;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param

    const/4 v0, 0x0

    invoke-direct {p0, p1, p2, v0}, Landroid/support/design/internal/BottomNavigationItemView;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V
    .locals 2

    invoke-direct {p0, p1, p2, p3}, Landroid/widget/FrameLayout;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V

    const/4 p2, -0x1

    iput p2, p0, Landroid/support/design/internal/BottomNavigationItemView;->mItemPosition:I

    invoke-virtual {p0}, Landroid/support/design/internal/BottomNavigationItemView;->getResources()Landroid/content/res/Resources;

    move-result-object p2

    sget p3, Landroid/support/design/R$dimen;->design_bottom_navigation_text_size:I

    invoke-virtual {p2, p3}, Landroid/content/res/Resources;->getDimensionPixelSize(I)I

    move-result p3

    sget v0, Landroid/support/design/R$dimen;->design_bottom_navigation_active_text_size:I

    invoke-virtual {p2, v0}, Landroid/content/res/Resources;->getDimensionPixelSize(I)I

    move-result v0

    sget v1, Landroid/support/design/R$dimen;->design_bottom_navigation_margin:I

    invoke-virtual {p2, v1}, Landroid/content/res/Resources;->getDimensionPixelSize(I)I

    move-result p2

    iput p2, p0, Landroid/support/design/internal/BottomNavigationItemView;->mDefaultMargin:I

    sub-int p2, p3, v0

    iput p2, p0, Landroid/support/design/internal/BottomNavigationItemView;->mShiftAmount:I

    int-to-float p2, v0

    const/high16 v0, 0x3f800000    # 1.0f

    mul-float v1, p2, v0

    int-to-float p3, p3

    div-float/2addr v1, p3

    iput v1, p0, Landroid/support/design/internal/BottomNavigationItemView;->mScaleUpFactor:F

    mul-float p3, p3, v0

    div-float/2addr p3, p2

    iput p3, p0, Landroid/support/design/internal/BottomNavigationItemView;->mScaleDownFactor:F

    invoke-static {p1}, Landroid/view/LayoutInflater;->from(Landroid/content/Context;)Landroid/view/LayoutInflater;

    move-result-object p1

    sget p2, Landroid/support/design/R$layout;->design_bottom_navigation_item:I

    const/4 p3, 0x1

    invoke-virtual {p1, p2, p0, p3}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;Z)Landroid/view/View;

    sget p1, Landroid/support/design/R$drawable;->design_bottom_navigation_item_background:I

    invoke-virtual {p0, p1}, Landroid/support/design/internal/BottomNavigationItemView;->setBackgroundResource(I)V

    sget p1, Landroid/support/design/R$id;->icon:I

    invoke-virtual {p0, p1}, Landroid/support/design/internal/BottomNavigationItemView;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/ImageView;

    iput-object p1, p0, Landroid/support/design/internal/BottomNavigationItemView;->mIcon:Landroid/widget/ImageView;

    sget p1, Landroid/support/design/R$id;->smallLabel:I

    invoke-virtual {p0, p1}, Landroid/support/design/internal/BottomNavigationItemView;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    iput-object p1, p0, Landroid/support/design/internal/BottomNavigationItemView;->mSmallLabel:Landroid/widget/TextView;

    sget p1, Landroid/support/design/R$id;->largeLabel:I

    invoke-virtual {p0, p1}, Landroid/support/design/internal/BottomNavigationItemView;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    iput-object p1, p0, Landroid/support/design/internal/BottomNavigationItemView;->mLargeLabel:Landroid/widget/TextView;

    return-void
.end method


# virtual methods
.method public getItemData()Landroid/support/v7/view/menu/MenuItemImpl;
    .locals 1

    iget-object v0, p0, Landroid/support/design/internal/BottomNavigationItemView;->mItemData:Landroid/support/v7/view/menu/MenuItemImpl;

    return-object v0
.end method

.method public getItemPosition()I
    .locals 1

    iget v0, p0, Landroid/support/design/internal/BottomNavigationItemView;->mItemPosition:I

    return v0
.end method

.method public initialize(Landroid/support/v7/view/menu/MenuItemImpl;I)V
    .locals 0

    iput-object p1, p0, Landroid/support/design/internal/BottomNavigationItemView;->mItemData:Landroid/support/v7/view/menu/MenuItemImpl;

    invoke-virtual {p1}, Landroid/support/v7/view/menu/MenuItemImpl;->isCheckable()Z

    move-result p2

    invoke-virtual {p0, p2}, Landroid/support/design/internal/BottomNavigationItemView;->setCheckable(Z)V

    invoke-virtual {p1}, Landroid/support/v7/view/menu/MenuItemImpl;->isChecked()Z

    move-result p2

    invoke-virtual {p0, p2}, Landroid/support/design/internal/BottomNavigationItemView;->setChecked(Z)V

    invoke-virtual {p1}, Landroid/support/v7/view/menu/MenuItemImpl;->isEnabled()Z

    move-result p2

    invoke-virtual {p0, p2}, Landroid/support/design/internal/BottomNavigationItemView;->setEnabled(Z)V

    invoke-virtual {p1}, Landroid/support/v7/view/menu/MenuItemImpl;->getIcon()Landroid/graphics/drawable/Drawable;

    move-result-object p2

    invoke-virtual {p0, p2}, Landroid/support/design/internal/BottomNavigationItemView;->setIcon(Landroid/graphics/drawable/Drawable;)V

    invoke-virtual {p1}, Landroid/support/v7/view/menu/MenuItemImpl;->getTitle()Ljava/lang/CharSequence;

    move-result-object p2

    invoke-virtual {p0, p2}, Landroid/support/design/internal/BottomNavigationItemView;->setTitle(Ljava/lang/CharSequence;)V

    invoke-virtual {p1}, Landroid/support/v7/view/menu/MenuItemImpl;->getItemId()I

    move-result p1

    invoke-virtual {p0, p1}, Landroid/support/design/internal/BottomNavigationItemView;->setId(I)V

    return-void
.end method

.method public onCreateDrawableState(I)[I
    .locals 1

    add-int/lit8 p1, p1, 0x1

    invoke-super {p0, p1}, Landroid/widget/FrameLayout;->onCreateDrawableState(I)[I

    move-result-object p1

    iget-object v0, p0, Landroid/support/design/internal/BottomNavigationItemView;->mItemData:Landroid/support/v7/view/menu/MenuItemImpl;

    if-eqz v0, :cond_0

    iget-object v0, p0, Landroid/support/design/internal/BottomNavigationItemView;->mItemData:Landroid/support/v7/view/menu/MenuItemImpl;

    invoke-virtual {v0}, Landroid/support/v7/view/menu/MenuItemImpl;->isCheckable()Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Landroid/support/design/internal/BottomNavigationItemView;->mItemData:Landroid/support/v7/view/menu/MenuItemImpl;

    invoke-virtual {v0}, Landroid/support/v7/view/menu/MenuItemImpl;->isChecked()Z

    move-result v0

    if-eqz v0, :cond_0

    sget-object v0, Landroid/support/design/internal/BottomNavigationItemView;->CHECKED_STATE_SET:[I

    invoke-static {p1, v0}, Landroid/support/design/internal/BottomNavigationItemView;->mergeDrawableStates([I[I)[I

    :cond_0
    return-object p1
.end method

.method public prefersCondensedTitle()Z
    .locals 1

    const/4 v0, 0x0

    return v0
.end method

.method public setCheckable(Z)V
    .locals 0

    invoke-virtual {p0}, Landroid/support/design/internal/BottomNavigationItemView;->refreshDrawableState()V

    return-void
.end method

.method public setChecked(Z)V
    .locals 5

    iget-object v0, p0, Landroid/support/design/internal/BottomNavigationItemView;->mLargeLabel:Landroid/widget/TextView;

    iget-object v1, p0, Landroid/support/design/internal/BottomNavigationItemView;->mLargeLabel:Landroid/widget/TextView;

    invoke-virtual {v1}, Landroid/widget/TextView;->getWidth()I

    move-result v1

    div-int/lit8 v1, v1, 0x2

    int-to-float v1, v1

    invoke-static {v0, v1}, Landroid/support/v4/view/ViewCompat;->setPivotX(Landroid/view/View;F)V

    iget-object v0, p0, Landroid/support/design/internal/BottomNavigationItemView;->mLargeLabel:Landroid/widget/TextView;

    iget-object v1, p0, Landroid/support/design/internal/BottomNavigationItemView;->mLargeLabel:Landroid/widget/TextView;

    invoke-virtual {v1}, Landroid/widget/TextView;->getBaseline()I

    move-result v1

    int-to-float v1, v1

    invoke-static {v0, v1}, Landroid/support/v4/view/ViewCompat;->setPivotY(Landroid/view/View;F)V

    iget-object v0, p0, Landroid/support/design/internal/BottomNavigationItemView;->mSmallLabel:Landroid/widget/TextView;

    iget-object v1, p0, Landroid/support/design/internal/BottomNavigationItemView;->mSmallLabel:Landroid/widget/TextView;

    invoke-virtual {v1}, Landroid/widget/TextView;->getWidth()I

    move-result v1

    div-int/lit8 v1, v1, 0x2

    int-to-float v1, v1

    invoke-static {v0, v1}, Landroid/support/v4/view/ViewCompat;->setPivotX(Landroid/view/View;F)V

    iget-object v0, p0, Landroid/support/design/internal/BottomNavigationItemView;->mSmallLabel:Landroid/widget/TextView;

    iget-object v1, p0, Landroid/support/design/internal/BottomNavigationItemView;->mSmallLabel:Landroid/widget/TextView;

    invoke-virtual {v1}, Landroid/widget/TextView;->getBaseline()I

    move-result v1

    int-to-float v1, v1

    invoke-static {v0, v1}, Landroid/support/v4/view/ViewCompat;->setPivotY(Landroid/view/View;F)V

    iget-boolean v0, p0, Landroid/support/design/internal/BottomNavigationItemView;->mShiftingMode:Z

    const/4 v1, 0x0

    const/16 v2, 0x31

    const/4 v3, 0x4

    const/high16 v4, 0x3f800000    # 1.0f

    if-eqz v0, :cond_1

    if-eqz p1, :cond_0

    iget-object p1, p0, Landroid/support/design/internal/BottomNavigationItemView;->mIcon:Landroid/widget/ImageView;

    invoke-virtual {p1}, Landroid/widget/ImageView;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object p1

    check-cast p1, Landroid/widget/FrameLayout$LayoutParams;

    iput v2, p1, Landroid/widget/FrameLayout$LayoutParams;->gravity:I

    iget v0, p0, Landroid/support/design/internal/BottomNavigationItemView;->mDefaultMargin:I

    iput v0, p1, Landroid/widget/FrameLayout$LayoutParams;->topMargin:I

    iget-object v0, p0, Landroid/support/design/internal/BottomNavigationItemView;->mIcon:Landroid/widget/ImageView;

    invoke-virtual {v0, p1}, Landroid/widget/ImageView;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    iget-object p1, p0, Landroid/support/design/internal/BottomNavigationItemView;->mLargeLabel:Landroid/widget/TextView;

    invoke-virtual {p1, v1}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object p1, p0, Landroid/support/design/internal/BottomNavigationItemView;->mLargeLabel:Landroid/widget/TextView;

    invoke-static {p1, v4}, Landroid/support/v4/view/ViewCompat;->setScaleX(Landroid/view/View;F)V

    iget-object p1, p0, Landroid/support/design/internal/BottomNavigationItemView;->mLargeLabel:Landroid/widget/TextView;

    invoke-static {p1, v4}, Landroid/support/v4/view/ViewCompat;->setScaleY(Landroid/view/View;F)V

    goto :goto_0

    :cond_0
    iget-object p1, p0, Landroid/support/design/internal/BottomNavigationItemView;->mIcon:Landroid/widget/ImageView;

    invoke-virtual {p1}, Landroid/widget/ImageView;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object p1

    check-cast p1, Landroid/widget/FrameLayout$LayoutParams;

    const/16 v0, 0x11

    iput v0, p1, Landroid/widget/FrameLayout$LayoutParams;->gravity:I

    iget v0, p0, Landroid/support/design/internal/BottomNavigationItemView;->mDefaultMargin:I

    iput v0, p1, Landroid/widget/FrameLayout$LayoutParams;->topMargin:I

    iget-object v0, p0, Landroid/support/design/internal/BottomNavigationItemView;->mIcon:Landroid/widget/ImageView;

    invoke-virtual {v0, p1}, Landroid/widget/ImageView;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    iget-object p1, p0, Landroid/support/design/internal/BottomNavigationItemView;->mLargeLabel:Landroid/widget/TextView;

    invoke-virtual {p1, v3}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object p1, p0, Landroid/support/design/internal/BottomNavigationItemView;->mLargeLabel:Landroid/widget/TextView;

    const/high16 v0, 0x3f000000    # 0.5f

    invoke-static {p1, v0}, Landroid/support/v4/view/ViewCompat;->setScaleX(Landroid/view/View;F)V

    iget-object p1, p0, Landroid/support/design/internal/BottomNavigationItemView;->mLargeLabel:Landroid/widget/TextView;

    invoke-static {p1, v0}, Landroid/support/v4/view/ViewCompat;->setScaleY(Landroid/view/View;F)V

    :goto_0
    iget-object p1, p0, Landroid/support/design/internal/BottomNavigationItemView;->mSmallLabel:Landroid/widget/TextView;

    invoke-virtual {p1, v3}, Landroid/widget/TextView;->setVisibility(I)V

    goto :goto_1

    :cond_1
    if-eqz p1, :cond_2

    iget-object p1, p0, Landroid/support/design/internal/BottomNavigationItemView;->mIcon:Landroid/widget/ImageView;

    invoke-virtual {p1}, Landroid/widget/ImageView;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object p1

    check-cast p1, Landroid/widget/FrameLayout$LayoutParams;

    iput v2, p1, Landroid/widget/FrameLayout$LayoutParams;->gravity:I

    iget v0, p0, Landroid/support/design/internal/BottomNavigationItemView;->mDefaultMargin:I

    iget v2, p0, Landroid/support/design/internal/BottomNavigationItemView;->mShiftAmount:I

    add-int/2addr v0, v2

    iput v0, p1, Landroid/widget/FrameLayout$LayoutParams;->topMargin:I

    iget-object v0, p0, Landroid/support/design/internal/BottomNavigationItemView;->mIcon:Landroid/widget/ImageView;

    invoke-virtual {v0, p1}, Landroid/widget/ImageView;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    iget-object p1, p0, Landroid/support/design/internal/BottomNavigationItemView;->mLargeLabel:Landroid/widget/TextView;

    invoke-virtual {p1, v1}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object p1, p0, Landroid/support/design/internal/BottomNavigationItemView;->mSmallLabel:Landroid/widget/TextView;

    invoke-virtual {p1, v3}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object p1, p0, Landroid/support/design/internal/BottomNavigationItemView;->mLargeLabel:Landroid/widget/TextView;

    invoke-static {p1, v4}, Landroid/support/v4/view/ViewCompat;->setScaleX(Landroid/view/View;F)V

    iget-object p1, p0, Landroid/support/design/internal/BottomNavigationItemView;->mLargeLabel:Landroid/widget/TextView;

    invoke-static {p1, v4}, Landroid/support/v4/view/ViewCompat;->setScaleY(Landroid/view/View;F)V

    iget-object p1, p0, Landroid/support/design/internal/BottomNavigationItemView;->mSmallLabel:Landroid/widget/TextView;

    iget v0, p0, Landroid/support/design/internal/BottomNavigationItemView;->mScaleUpFactor:F

    invoke-static {p1, v0}, Landroid/support/v4/view/ViewCompat;->setScaleX(Landroid/view/View;F)V

    iget-object p1, p0, Landroid/support/design/internal/BottomNavigationItemView;->mSmallLabel:Landroid/widget/TextView;

    iget v0, p0, Landroid/support/design/internal/BottomNavigationItemView;->mScaleUpFactor:F

    invoke-static {p1, v0}, Landroid/support/v4/view/ViewCompat;->setScaleY(Landroid/view/View;F)V

    goto :goto_1

    :cond_2
    iget-object p1, p0, Landroid/support/design/internal/BottomNavigationItemView;->mIcon:Landroid/widget/ImageView;

    invoke-virtual {p1}, Landroid/widget/ImageView;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object p1

    check-cast p1, Landroid/widget/FrameLayout$LayoutParams;

    iput v2, p1, Landroid/widget/FrameLayout$LayoutParams;->gravity:I

    iget v0, p0, Landroid/support/design/internal/BottomNavigationItemView;->mDefaultMargin:I

    iput v0, p1, Landroid/widget/FrameLayout$LayoutParams;->topMargin:I

    iget-object v0, p0, Landroid/support/design/internal/BottomNavigationItemView;->mIcon:Landroid/widget/ImageView;

    invoke-virtual {v0, p1}, Landroid/widget/ImageView;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    iget-object p1, p0, Landroid/support/design/internal/BottomNavigationItemView;->mLargeLabel:Landroid/widget/TextView;

    invoke-virtual {p1, v3}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object p1, p0, Landroid/support/design/internal/BottomNavigationItemView;->mSmallLabel:Landroid/widget/TextView;

    invoke-virtual {p1, v1}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object p1, p0, Landroid/support/design/internal/BottomNavigationItemView;->mLargeLabel:Landroid/widget/TextView;

    iget v0, p0, Landroid/support/design/internal/BottomNavigationItemView;->mScaleDownFactor:F

    invoke-static {p1, v0}, Landroid/support/v4/view/ViewCompat;->setScaleX(Landroid/view/View;F)V

    iget-object p1, p0, Landroid/support/design/internal/BottomNavigationItemView;->mLargeLabel:Landroid/widget/TextView;

    iget v0, p0, Landroid/support/design/internal/BottomNavigationItemView;->mScaleDownFactor:F

    invoke-static {p1, v0}, Landroid/support/v4/view/ViewCompat;->setScaleY(Landroid/view/View;F)V

    iget-object p1, p0, Landroid/support/design/internal/BottomNavigationItemView;->mSmallLabel:Landroid/widget/TextView;

    invoke-static {p1, v4}, Landroid/support/v4/view/ViewCompat;->setScaleX(Landroid/view/View;F)V

    iget-object p1, p0, Landroid/support/design/internal/BottomNavigationItemView;->mSmallLabel:Landroid/widget/TextView;

    invoke-static {p1, v4}, Landroid/support/v4/view/ViewCompat;->setScaleY(Landroid/view/View;F)V

    :goto_1
    invoke-virtual {p0}, Landroid/support/design/internal/BottomNavigationItemView;->refreshDrawableState()V

    return-void
.end method

.method public setEnabled(Z)V
    .locals 1

    invoke-super {p0, p1}, Landroid/widget/FrameLayout;->setEnabled(Z)V

    iget-object v0, p0, Landroid/support/design/internal/BottomNavigationItemView;->mSmallLabel:Landroid/widget/TextView;

    invoke-virtual {v0, p1}, Landroid/widget/TextView;->setEnabled(Z)V

    iget-object v0, p0, Landroid/support/design/internal/BottomNavigationItemView;->mLargeLabel:Landroid/widget/TextView;

    invoke-virtual {v0, p1}, Landroid/widget/TextView;->setEnabled(Z)V

    iget-object v0, p0, Landroid/support/design/internal/BottomNavigationItemView;->mIcon:Landroid/widget/ImageView;

    invoke-virtual {v0, p1}, Landroid/widget/ImageView;->setEnabled(Z)V

    if-eqz p1, :cond_0

    invoke-virtual {p0}, Landroid/support/design/internal/BottomNavigationItemView;->getContext()Landroid/content/Context;

    move-result-object p1

    const/16 v0, 0x3ea

    invoke-static {p1, v0}, Landroid/support/v4/view/PointerIconCompat;->getSystemIcon(Landroid/content/Context;I)Landroid/support/v4/view/PointerIconCompat;

    move-result-object p1

    :goto_0
    invoke-static {p0, p1}, Landroid/support/v4/view/ViewCompat;->setPointerIcon(Landroid/view/View;Landroid/support/v4/view/PointerIconCompat;)V

    return-void

    :cond_0
    const/4 p1, 0x0

    goto :goto_0

    return-void
.end method

.method public setIcon(Landroid/graphics/drawable/Drawable;)V
    .locals 1

    if-eqz p1, :cond_1

    invoke-virtual {p1}, Landroid/graphics/drawable/Drawable;->getConstantState()Landroid/graphics/drawable/Drawable$ConstantState;

    move-result-object v0

    if-nez v0, :cond_0

    goto :goto_0

    :cond_0
    invoke-virtual {v0}, Landroid/graphics/drawable/Drawable$ConstantState;->newDrawable()Landroid/graphics/drawable/Drawable;

    move-result-object p1

    :goto_0
    invoke-static {p1}, Landroid/support/v4/graphics/drawable/DrawableCompat;->wrap(Landroid/graphics/drawable/Drawable;)Landroid/graphics/drawable/Drawable;

    move-result-object p1

    invoke-virtual {p1}, Landroid/graphics/drawable/Drawable;->mutate()Landroid/graphics/drawable/Drawable;

    move-result-object p1

    iget-object v0, p0, Landroid/support/design/internal/BottomNavigationItemView;->mIconTint:Landroid/content/res/ColorStateList;

    invoke-static {p1, v0}, Landroid/support/v4/graphics/drawable/DrawableCompat;->setTintList(Landroid/graphics/drawable/Drawable;Landroid/content/res/ColorStateList;)V

    :cond_1
    iget-object v0, p0, Landroid/support/design/internal/BottomNavigationItemView;->mIcon:Landroid/widget/ImageView;

    invoke-virtual {v0, p1}, Landroid/widget/ImageView;->setImageDrawable(Landroid/graphics/drawable/Drawable;)V

    return-void
.end method

.method public setIconTintList(Landroid/content/res/ColorStateList;)V
    .locals 0

    iput-object p1, p0, Landroid/support/design/internal/BottomNavigationItemView;->mIconTint:Landroid/content/res/ColorStateList;

    iget-object p1, p0, Landroid/support/design/internal/BottomNavigationItemView;->mItemData:Landroid/support/v7/view/menu/MenuItemImpl;

    if-eqz p1, :cond_0

    iget-object p1, p0, Landroid/support/design/internal/BottomNavigationItemView;->mItemData:Landroid/support/v7/view/menu/MenuItemImpl;

    invoke-virtual {p1}, Landroid/support/v7/view/menu/MenuItemImpl;->getIcon()Landroid/graphics/drawable/Drawable;

    move-result-object p1

    invoke-virtual {p0, p1}, Landroid/support/design/internal/BottomNavigationItemView;->setIcon(Landroid/graphics/drawable/Drawable;)V

    :cond_0
    return-void
.end method

.method public setItemBackground(I)V
    .locals 1

    if-nez p1, :cond_0

    const/4 p1, 0x0

    goto :goto_0

    :cond_0
    invoke-virtual {p0}, Landroid/support/design/internal/BottomNavigationItemView;->getContext()Landroid/content/Context;

    move-result-object v0

    invoke-static {v0, p1}, Landroid/support/v4/content/ContextCompat;->getDrawable(Landroid/content/Context;I)Landroid/graphics/drawable/Drawable;

    move-result-object p1

    :goto_0
    invoke-static {p0, p1}, Landroid/support/v4/view/ViewCompat;->setBackground(Landroid/view/View;Landroid/graphics/drawable/Drawable;)V

    return-void
.end method

.method public setItemPosition(I)V
    .locals 0

    iput p1, p0, Landroid/support/design/internal/BottomNavigationItemView;->mItemPosition:I

    return-void
.end method

.method public setShiftingMode(Z)V
    .locals 0

    iput-boolean p1, p0, Landroid/support/design/internal/BottomNavigationItemView;->mShiftingMode:Z

    return-void
.end method

.method public setShortcut(ZC)V
    .locals 0

    return-void
.end method

.method public setTextColor(Landroid/content/res/ColorStateList;)V
    .locals 1

    iget-object v0, p0, Landroid/support/design/internal/BottomNavigationItemView;->mSmallLabel:Landroid/widget/TextView;

    invoke-virtual {v0, p1}, Landroid/widget/TextView;->setTextColor(Landroid/content/res/ColorStateList;)V

    iget-object v0, p0, Landroid/support/design/internal/BottomNavigationItemView;->mLargeLabel:Landroid/widget/TextView;

    invoke-virtual {v0, p1}, Landroid/widget/TextView;->setTextColor(Landroid/content/res/ColorStateList;)V

    return-void
.end method

.method public setTitle(Ljava/lang/CharSequence;)V
    .locals 1

    iget-object v0, p0, Landroid/support/design/internal/BottomNavigationItemView;->mSmallLabel:Landroid/widget/TextView;

    invoke-virtual {v0, p1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v0, p0, Landroid/support/design/internal/BottomNavigationItemView;->mLargeLabel:Landroid/widget/TextView;

    invoke-virtual {v0, p1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    invoke-virtual {p0, p1}, Landroid/support/design/internal/BottomNavigationItemView;->setContentDescription(Ljava/lang/CharSequence;)V

    return-void
.end method

.method public showsIcon()Z
    .locals 1

    const/4 v0, 0x1

    return v0
.end method

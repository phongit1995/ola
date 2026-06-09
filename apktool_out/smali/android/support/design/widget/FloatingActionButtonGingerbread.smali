.class Landroid/support/design/widget/FloatingActionButtonGingerbread;
.super Landroid/support/design/widget/FloatingActionButtonImpl;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Landroid/support/design/widget/FloatingActionButtonGingerbread$DisabledElevationAnimation;,
        Landroid/support/design/widget/FloatingActionButtonGingerbread$ElevateToTranslationZAnimation;,
        Landroid/support/design/widget/FloatingActionButtonGingerbread$ResetElevationAnimation;,
        Landroid/support/design/widget/FloatingActionButtonGingerbread$ShadowAnimatorImpl;
    }
.end annotation


# instance fields
.field mShadowDrawable:Landroid/support/design/widget/ShadowDrawableWrapper;

.field private final mStateListAnimator:Landroid/support/design/widget/StateListAnimator;


# direct methods
.method constructor <init>(Landroid/support/design/widget/VisibilityAwareImageButton;Landroid/support/design/widget/ShadowViewDelegate;Landroid/support/design/widget/ValueAnimatorCompat$Creator;)V
    .locals 0

    invoke-direct {p0, p1, p2, p3}, Landroid/support/design/widget/FloatingActionButtonImpl;-><init>(Landroid/support/design/widget/VisibilityAwareImageButton;Landroid/support/design/widget/ShadowViewDelegate;Landroid/support/design/widget/ValueAnimatorCompat$Creator;)V

    new-instance p1, Landroid/support/design/widget/StateListAnimator;

    invoke-direct {p1}, Landroid/support/design/widget/StateListAnimator;-><init>()V

    iput-object p1, p0, Landroid/support/design/widget/FloatingActionButtonGingerbread;->mStateListAnimator:Landroid/support/design/widget/StateListAnimator;

    iget-object p1, p0, Landroid/support/design/widget/FloatingActionButtonGingerbread;->mStateListAnimator:Landroid/support/design/widget/StateListAnimator;

    sget-object p2, Landroid/support/design/widget/FloatingActionButtonGingerbread;->PRESSED_ENABLED_STATE_SET:[I

    new-instance p3, Landroid/support/design/widget/FloatingActionButtonGingerbread$ElevateToTranslationZAnimation;

    invoke-direct {p3, p0}, Landroid/support/design/widget/FloatingActionButtonGingerbread$ElevateToTranslationZAnimation;-><init>(Landroid/support/design/widget/FloatingActionButtonGingerbread;)V

    invoke-direct {p0, p3}, Landroid/support/design/widget/FloatingActionButtonGingerbread;->createAnimator(Landroid/support/design/widget/FloatingActionButtonGingerbread$ShadowAnimatorImpl;)Landroid/support/design/widget/ValueAnimatorCompat;

    move-result-object p3

    invoke-virtual {p1, p2, p3}, Landroid/support/design/widget/StateListAnimator;->addState([ILandroid/support/design/widget/ValueAnimatorCompat;)V

    iget-object p1, p0, Landroid/support/design/widget/FloatingActionButtonGingerbread;->mStateListAnimator:Landroid/support/design/widget/StateListAnimator;

    sget-object p2, Landroid/support/design/widget/FloatingActionButtonGingerbread;->FOCUSED_ENABLED_STATE_SET:[I

    new-instance p3, Landroid/support/design/widget/FloatingActionButtonGingerbread$ElevateToTranslationZAnimation;

    invoke-direct {p3, p0}, Landroid/support/design/widget/FloatingActionButtonGingerbread$ElevateToTranslationZAnimation;-><init>(Landroid/support/design/widget/FloatingActionButtonGingerbread;)V

    invoke-direct {p0, p3}, Landroid/support/design/widget/FloatingActionButtonGingerbread;->createAnimator(Landroid/support/design/widget/FloatingActionButtonGingerbread$ShadowAnimatorImpl;)Landroid/support/design/widget/ValueAnimatorCompat;

    move-result-object p3

    invoke-virtual {p1, p2, p3}, Landroid/support/design/widget/StateListAnimator;->addState([ILandroid/support/design/widget/ValueAnimatorCompat;)V

    iget-object p1, p0, Landroid/support/design/widget/FloatingActionButtonGingerbread;->mStateListAnimator:Landroid/support/design/widget/StateListAnimator;

    sget-object p2, Landroid/support/design/widget/FloatingActionButtonGingerbread;->ENABLED_STATE_SET:[I

    new-instance p3, Landroid/support/design/widget/FloatingActionButtonGingerbread$ResetElevationAnimation;

    invoke-direct {p3, p0}, Landroid/support/design/widget/FloatingActionButtonGingerbread$ResetElevationAnimation;-><init>(Landroid/support/design/widget/FloatingActionButtonGingerbread;)V

    invoke-direct {p0, p3}, Landroid/support/design/widget/FloatingActionButtonGingerbread;->createAnimator(Landroid/support/design/widget/FloatingActionButtonGingerbread$ShadowAnimatorImpl;)Landroid/support/design/widget/ValueAnimatorCompat;

    move-result-object p3

    invoke-virtual {p1, p2, p3}, Landroid/support/design/widget/StateListAnimator;->addState([ILandroid/support/design/widget/ValueAnimatorCompat;)V

    iget-object p1, p0, Landroid/support/design/widget/FloatingActionButtonGingerbread;->mStateListAnimator:Landroid/support/design/widget/StateListAnimator;

    sget-object p2, Landroid/support/design/widget/FloatingActionButtonGingerbread;->EMPTY_STATE_SET:[I

    new-instance p3, Landroid/support/design/widget/FloatingActionButtonGingerbread$DisabledElevationAnimation;

    invoke-direct {p3, p0}, Landroid/support/design/widget/FloatingActionButtonGingerbread$DisabledElevationAnimation;-><init>(Landroid/support/design/widget/FloatingActionButtonGingerbread;)V

    invoke-direct {p0, p3}, Landroid/support/design/widget/FloatingActionButtonGingerbread;->createAnimator(Landroid/support/design/widget/FloatingActionButtonGingerbread$ShadowAnimatorImpl;)Landroid/support/design/widget/ValueAnimatorCompat;

    move-result-object p3

    invoke-virtual {p1, p2, p3}, Landroid/support/design/widget/StateListAnimator;->addState([ILandroid/support/design/widget/ValueAnimatorCompat;)V

    return-void
.end method

.method private createAnimator(Landroid/support/design/widget/FloatingActionButtonGingerbread$ShadowAnimatorImpl;)Landroid/support/design/widget/ValueAnimatorCompat;
    .locals 3
    .param p1    # Landroid/support/design/widget/FloatingActionButtonGingerbread$ShadowAnimatorImpl;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param

    iget-object v0, p0, Landroid/support/design/widget/FloatingActionButtonGingerbread;->mAnimatorCreator:Landroid/support/design/widget/ValueAnimatorCompat$Creator;

    invoke-interface {v0}, Landroid/support/design/widget/ValueAnimatorCompat$Creator;->createAnimator()Landroid/support/design/widget/ValueAnimatorCompat;

    move-result-object v0

    sget-object v1, Landroid/support/design/widget/FloatingActionButtonGingerbread;->ANIM_INTERPOLATOR:Landroid/view/animation/Interpolator;

    invoke-virtual {v0, v1}, Landroid/support/design/widget/ValueAnimatorCompat;->setInterpolator(Landroid/view/animation/Interpolator;)V

    const-wide/16 v1, 0x64

    invoke-virtual {v0, v1, v2}, Landroid/support/design/widget/ValueAnimatorCompat;->setDuration(J)V

    invoke-virtual {v0, p1}, Landroid/support/design/widget/ValueAnimatorCompat;->addListener(Landroid/support/design/widget/ValueAnimatorCompat$AnimatorListener;)V

    invoke-virtual {v0, p1}, Landroid/support/design/widget/ValueAnimatorCompat;->addUpdateListener(Landroid/support/design/widget/ValueAnimatorCompat$AnimatorUpdateListener;)V

    const/4 p1, 0x0

    const/high16 v1, 0x3f800000    # 1.0f

    invoke-virtual {v0, p1, v1}, Landroid/support/design/widget/ValueAnimatorCompat;->setFloatValues(FF)V

    return-object v0
.end method

.method private static createColorStateList(I)Landroid/content/res/ColorStateList;
    .locals 5

    const/4 v0, 0x3

    new-array v1, v0, [[I

    new-array v0, v0, [I

    sget-object v2, Landroid/support/design/widget/FloatingActionButtonGingerbread;->FOCUSED_ENABLED_STATE_SET:[I

    const/4 v3, 0x0

    aput-object v2, v1, v3

    aput p0, v0, v3

    sget-object v2, Landroid/support/design/widget/FloatingActionButtonGingerbread;->PRESSED_ENABLED_STATE_SET:[I

    const/4 v4, 0x1

    aput-object v2, v1, v4

    aput p0, v0, v4

    new-array p0, v3, [I

    const/4 v2, 0x2

    aput-object p0, v1, v2

    aput v3, v0, v2

    new-instance p0, Landroid/content/res/ColorStateList;

    invoke-direct {p0, v1, v0}, Landroid/content/res/ColorStateList;-><init>([[I[I)V

    return-object p0
.end method


# virtual methods
.method getElevation()F
    .locals 1

    iget v0, p0, Landroid/support/design/widget/FloatingActionButtonGingerbread;->mElevation:F

    return v0
.end method

.method getPadding(Landroid/graphics/Rect;)V
    .locals 1

    iget-object v0, p0, Landroid/support/design/widget/FloatingActionButtonGingerbread;->mShadowDrawable:Landroid/support/design/widget/ShadowDrawableWrapper;

    invoke-virtual {v0, p1}, Landroid/support/design/widget/ShadowDrawableWrapper;->getPadding(Landroid/graphics/Rect;)Z

    return-void
.end method

.method hide(Landroid/support/design/widget/FloatingActionButtonImpl$InternalVisibilityChangedListener;Z)V
    .locals 3
    .param p1    # Landroid/support/design/widget/FloatingActionButtonImpl$InternalVisibilityChangedListener;
        .annotation build Landroid/support/annotation/Nullable;
        .end annotation
    .end param

    invoke-virtual {p0}, Landroid/support/design/widget/FloatingActionButtonGingerbread;->isOrWillBeHidden()Z

    move-result v0

    if-eqz v0, :cond_0

    return-void

    :cond_0
    const/4 v0, 0x1

    iput v0, p0, Landroid/support/design/widget/FloatingActionButtonGingerbread;->mAnimState:I

    iget-object v0, p0, Landroid/support/design/widget/FloatingActionButtonGingerbread;->mView:Landroid/support/design/widget/VisibilityAwareImageButton;

    invoke-virtual {v0}, Landroid/support/design/widget/VisibilityAwareImageButton;->getContext()Landroid/content/Context;

    move-result-object v0

    sget v1, Landroid/support/design/R$anim;->design_fab_out:I

    invoke-static {v0, v1}, Landroid/view/animation/AnimationUtils;->loadAnimation(Landroid/content/Context;I)Landroid/view/animation/Animation;

    move-result-object v0

    sget-object v1, Landroid/support/design/widget/AnimationUtils;->FAST_OUT_LINEAR_IN_INTERPOLATOR:Landroid/view/animation/Interpolator;

    invoke-virtual {v0, v1}, Landroid/view/animation/Animation;->setInterpolator(Landroid/view/animation/Interpolator;)V

    const-wide/16 v1, 0xc8

    invoke-virtual {v0, v1, v2}, Landroid/view/animation/Animation;->setDuration(J)V

    new-instance v1, Landroid/support/design/widget/FloatingActionButtonGingerbread$1;

    invoke-direct {v1, p0, p2, p1}, Landroid/support/design/widget/FloatingActionButtonGingerbread$1;-><init>(Landroid/support/design/widget/FloatingActionButtonGingerbread;ZLandroid/support/design/widget/FloatingActionButtonImpl$InternalVisibilityChangedListener;)V

    invoke-virtual {v0, v1}, Landroid/view/animation/Animation;->setAnimationListener(Landroid/view/animation/Animation$AnimationListener;)V

    iget-object p1, p0, Landroid/support/design/widget/FloatingActionButtonGingerbread;->mView:Landroid/support/design/widget/VisibilityAwareImageButton;

    invoke-virtual {p1, v0}, Landroid/support/design/widget/VisibilityAwareImageButton;->startAnimation(Landroid/view/animation/Animation;)V

    return-void
.end method

.method jumpDrawableToCurrentState()V
    .locals 1

    iget-object v0, p0, Landroid/support/design/widget/FloatingActionButtonGingerbread;->mStateListAnimator:Landroid/support/design/widget/StateListAnimator;

    invoke-virtual {v0}, Landroid/support/design/widget/StateListAnimator;->jumpToCurrentState()V

    return-void
.end method

.method onCompatShadowChanged()V
    .locals 0

    return-void
.end method

.method onDrawableStateChanged([I)V
    .locals 1

    iget-object v0, p0, Landroid/support/design/widget/FloatingActionButtonGingerbread;->mStateListAnimator:Landroid/support/design/widget/StateListAnimator;

    invoke-virtual {v0, p1}, Landroid/support/design/widget/StateListAnimator;->setState([I)V

    return-void
.end method

.method onElevationsChanged(FF)V
    .locals 1

    iget-object p2, p0, Landroid/support/design/widget/FloatingActionButtonGingerbread;->mShadowDrawable:Landroid/support/design/widget/ShadowDrawableWrapper;

    if-eqz p2, :cond_0

    iget-object p2, p0, Landroid/support/design/widget/FloatingActionButtonGingerbread;->mShadowDrawable:Landroid/support/design/widget/ShadowDrawableWrapper;

    iget v0, p0, Landroid/support/design/widget/FloatingActionButtonGingerbread;->mPressedTranslationZ:F

    add-float/2addr v0, p1

    invoke-virtual {p2, p1, v0}, Landroid/support/design/widget/ShadowDrawableWrapper;->setShadowSize(FF)V

    invoke-virtual {p0}, Landroid/support/design/widget/FloatingActionButtonGingerbread;->updatePadding()V

    :cond_0
    return-void
.end method

.method setBackgroundDrawable(Landroid/content/res/ColorStateList;Landroid/graphics/PorterDuff$Mode;II)V
    .locals 7

    invoke-virtual {p0}, Landroid/support/design/widget/FloatingActionButtonGingerbread;->createShapeDrawable()Landroid/graphics/drawable/GradientDrawable;

    move-result-object v0

    invoke-static {v0}, Landroid/support/v4/graphics/drawable/DrawableCompat;->wrap(Landroid/graphics/drawable/Drawable;)Landroid/graphics/drawable/Drawable;

    move-result-object v0

    iput-object v0, p0, Landroid/support/design/widget/FloatingActionButtonGingerbread;->mShapeDrawable:Landroid/graphics/drawable/Drawable;

    iget-object v0, p0, Landroid/support/design/widget/FloatingActionButtonGingerbread;->mShapeDrawable:Landroid/graphics/drawable/Drawable;

    invoke-static {v0, p1}, Landroid/support/v4/graphics/drawable/DrawableCompat;->setTintList(Landroid/graphics/drawable/Drawable;Landroid/content/res/ColorStateList;)V

    if-eqz p2, :cond_0

    iget-object v0, p0, Landroid/support/design/widget/FloatingActionButtonGingerbread;->mShapeDrawable:Landroid/graphics/drawable/Drawable;

    invoke-static {v0, p2}, Landroid/support/v4/graphics/drawable/DrawableCompat;->setTintMode(Landroid/graphics/drawable/Drawable;Landroid/graphics/PorterDuff$Mode;)V

    :cond_0
    invoke-virtual {p0}, Landroid/support/design/widget/FloatingActionButtonGingerbread;->createShapeDrawable()Landroid/graphics/drawable/GradientDrawable;

    move-result-object p2

    invoke-static {p2}, Landroid/support/v4/graphics/drawable/DrawableCompat;->wrap(Landroid/graphics/drawable/Drawable;)Landroid/graphics/drawable/Drawable;

    move-result-object p2

    iput-object p2, p0, Landroid/support/design/widget/FloatingActionButtonGingerbread;->mRippleDrawable:Landroid/graphics/drawable/Drawable;

    iget-object p2, p0, Landroid/support/design/widget/FloatingActionButtonGingerbread;->mRippleDrawable:Landroid/graphics/drawable/Drawable;

    invoke-static {p3}, Landroid/support/design/widget/FloatingActionButtonGingerbread;->createColorStateList(I)Landroid/content/res/ColorStateList;

    move-result-object p3

    invoke-static {p2, p3}, Landroid/support/v4/graphics/drawable/DrawableCompat;->setTintList(Landroid/graphics/drawable/Drawable;Landroid/content/res/ColorStateList;)V

    const/4 p2, 0x2

    const/4 p3, 0x1

    const/4 v0, 0x0

    if-lez p4, :cond_1

    invoke-virtual {p0, p4, p1}, Landroid/support/design/widget/FloatingActionButtonGingerbread;->createBorderDrawable(ILandroid/content/res/ColorStateList;)Landroid/support/design/widget/CircularBorderDrawable;

    move-result-object p1

    iput-object p1, p0, Landroid/support/design/widget/FloatingActionButtonGingerbread;->mBorderDrawable:Landroid/support/design/widget/CircularBorderDrawable;

    const/4 p1, 0x3

    new-array p1, p1, [Landroid/graphics/drawable/Drawable;

    iget-object p4, p0, Landroid/support/design/widget/FloatingActionButtonGingerbread;->mBorderDrawable:Landroid/support/design/widget/CircularBorderDrawable;

    aput-object p4, p1, v0

    iget-object p4, p0, Landroid/support/design/widget/FloatingActionButtonGingerbread;->mShapeDrawable:Landroid/graphics/drawable/Drawable;

    aput-object p4, p1, p3

    iget-object p3, p0, Landroid/support/design/widget/FloatingActionButtonGingerbread;->mRippleDrawable:Landroid/graphics/drawable/Drawable;

    aput-object p3, p1, p2

    goto :goto_0

    :cond_1
    const/4 p1, 0x0

    iput-object p1, p0, Landroid/support/design/widget/FloatingActionButtonGingerbread;->mBorderDrawable:Landroid/support/design/widget/CircularBorderDrawable;

    new-array p1, p2, [Landroid/graphics/drawable/Drawable;

    iget-object p2, p0, Landroid/support/design/widget/FloatingActionButtonGingerbread;->mShapeDrawable:Landroid/graphics/drawable/Drawable;

    aput-object p2, p1, v0

    iget-object p2, p0, Landroid/support/design/widget/FloatingActionButtonGingerbread;->mRippleDrawable:Landroid/graphics/drawable/Drawable;

    aput-object p2, p1, p3

    :goto_0
    new-instance p2, Landroid/graphics/drawable/LayerDrawable;

    invoke-direct {p2, p1}, Landroid/graphics/drawable/LayerDrawable;-><init>([Landroid/graphics/drawable/Drawable;)V

    iput-object p2, p0, Landroid/support/design/widget/FloatingActionButtonGingerbread;->mContentBackground:Landroid/graphics/drawable/Drawable;

    new-instance p1, Landroid/support/design/widget/ShadowDrawableWrapper;

    iget-object p2, p0, Landroid/support/design/widget/FloatingActionButtonGingerbread;->mView:Landroid/support/design/widget/VisibilityAwareImageButton;

    invoke-virtual {p2}, Landroid/support/design/widget/VisibilityAwareImageButton;->getContext()Landroid/content/Context;

    move-result-object v2

    iget-object v3, p0, Landroid/support/design/widget/FloatingActionButtonGingerbread;->mContentBackground:Landroid/graphics/drawable/Drawable;

    iget-object p2, p0, Landroid/support/design/widget/FloatingActionButtonGingerbread;->mShadowViewDelegate:Landroid/support/design/widget/ShadowViewDelegate;

    invoke-interface {p2}, Landroid/support/design/widget/ShadowViewDelegate;->getRadius()F

    move-result v4

    iget v5, p0, Landroid/support/design/widget/FloatingActionButtonGingerbread;->mElevation:F

    iget p2, p0, Landroid/support/design/widget/FloatingActionButtonGingerbread;->mElevation:F

    iget p3, p0, Landroid/support/design/widget/FloatingActionButtonGingerbread;->mPressedTranslationZ:F

    add-float v6, p2, p3

    move-object v1, p1

    invoke-direct/range {v1 .. v6}, Landroid/support/design/widget/ShadowDrawableWrapper;-><init>(Landroid/content/Context;Landroid/graphics/drawable/Drawable;FFF)V

    iput-object p1, p0, Landroid/support/design/widget/FloatingActionButtonGingerbread;->mShadowDrawable:Landroid/support/design/widget/ShadowDrawableWrapper;

    iget-object p1, p0, Landroid/support/design/widget/FloatingActionButtonGingerbread;->mShadowDrawable:Landroid/support/design/widget/ShadowDrawableWrapper;

    invoke-virtual {p1, v0}, Landroid/support/design/widget/ShadowDrawableWrapper;->setAddPaddingForCorners(Z)V

    iget-object p1, p0, Landroid/support/design/widget/FloatingActionButtonGingerbread;->mShadowViewDelegate:Landroid/support/design/widget/ShadowViewDelegate;

    iget-object p2, p0, Landroid/support/design/widget/FloatingActionButtonGingerbread;->mShadowDrawable:Landroid/support/design/widget/ShadowDrawableWrapper;

    invoke-interface {p1, p2}, Landroid/support/design/widget/ShadowViewDelegate;->setBackgroundDrawable(Landroid/graphics/drawable/Drawable;)V

    return-void
.end method

.method setBackgroundTintList(Landroid/content/res/ColorStateList;)V
    .locals 1

    iget-object v0, p0, Landroid/support/design/widget/FloatingActionButtonGingerbread;->mShapeDrawable:Landroid/graphics/drawable/Drawable;

    if-eqz v0, :cond_0

    iget-object v0, p0, Landroid/support/design/widget/FloatingActionButtonGingerbread;->mShapeDrawable:Landroid/graphics/drawable/Drawable;

    invoke-static {v0, p1}, Landroid/support/v4/graphics/drawable/DrawableCompat;->setTintList(Landroid/graphics/drawable/Drawable;Landroid/content/res/ColorStateList;)V

    :cond_0
    iget-object v0, p0, Landroid/support/design/widget/FloatingActionButtonGingerbread;->mBorderDrawable:Landroid/support/design/widget/CircularBorderDrawable;

    if-eqz v0, :cond_1

    iget-object v0, p0, Landroid/support/design/widget/FloatingActionButtonGingerbread;->mBorderDrawable:Landroid/support/design/widget/CircularBorderDrawable;

    invoke-virtual {v0, p1}, Landroid/support/design/widget/CircularBorderDrawable;->setBorderTint(Landroid/content/res/ColorStateList;)V

    :cond_1
    return-void
.end method

.method setBackgroundTintMode(Landroid/graphics/PorterDuff$Mode;)V
    .locals 1

    iget-object v0, p0, Landroid/support/design/widget/FloatingActionButtonGingerbread;->mShapeDrawable:Landroid/graphics/drawable/Drawable;

    if-eqz v0, :cond_0

    iget-object v0, p0, Landroid/support/design/widget/FloatingActionButtonGingerbread;->mShapeDrawable:Landroid/graphics/drawable/Drawable;

    invoke-static {v0, p1}, Landroid/support/v4/graphics/drawable/DrawableCompat;->setTintMode(Landroid/graphics/drawable/Drawable;Landroid/graphics/PorterDuff$Mode;)V

    :cond_0
    return-void
.end method

.method setRippleColor(I)V
    .locals 1

    iget-object v0, p0, Landroid/support/design/widget/FloatingActionButtonGingerbread;->mRippleDrawable:Landroid/graphics/drawable/Drawable;

    if-eqz v0, :cond_0

    iget-object v0, p0, Landroid/support/design/widget/FloatingActionButtonGingerbread;->mRippleDrawable:Landroid/graphics/drawable/Drawable;

    invoke-static {p1}, Landroid/support/design/widget/FloatingActionButtonGingerbread;->createColorStateList(I)Landroid/content/res/ColorStateList;

    move-result-object p1

    invoke-static {v0, p1}, Landroid/support/v4/graphics/drawable/DrawableCompat;->setTintList(Landroid/graphics/drawable/Drawable;Landroid/content/res/ColorStateList;)V

    :cond_0
    return-void
.end method

.method show(Landroid/support/design/widget/FloatingActionButtonImpl$InternalVisibilityChangedListener;Z)V
    .locals 2
    .param p1    # Landroid/support/design/widget/FloatingActionButtonImpl$InternalVisibilityChangedListener;
        .annotation build Landroid/support/annotation/Nullable;
        .end annotation
    .end param

    invoke-virtual {p0}, Landroid/support/design/widget/FloatingActionButtonGingerbread;->isOrWillBeShown()Z

    move-result v0

    if-eqz v0, :cond_0

    return-void

    :cond_0
    const/4 v0, 0x2

    iput v0, p0, Landroid/support/design/widget/FloatingActionButtonGingerbread;->mAnimState:I

    iget-object v0, p0, Landroid/support/design/widget/FloatingActionButtonGingerbread;->mView:Landroid/support/design/widget/VisibilityAwareImageButton;

    const/4 v1, 0x0

    invoke-virtual {v0, v1, p2}, Landroid/support/design/widget/VisibilityAwareImageButton;->internalSetVisibility(IZ)V

    iget-object p2, p0, Landroid/support/design/widget/FloatingActionButtonGingerbread;->mView:Landroid/support/design/widget/VisibilityAwareImageButton;

    invoke-virtual {p2}, Landroid/support/design/widget/VisibilityAwareImageButton;->getContext()Landroid/content/Context;

    move-result-object p2

    sget v0, Landroid/support/design/R$anim;->design_fab_in:I

    invoke-static {p2, v0}, Landroid/view/animation/AnimationUtils;->loadAnimation(Landroid/content/Context;I)Landroid/view/animation/Animation;

    move-result-object p2

    const-wide/16 v0, 0xc8

    invoke-virtual {p2, v0, v1}, Landroid/view/animation/Animation;->setDuration(J)V

    sget-object v0, Landroid/support/design/widget/AnimationUtils;->LINEAR_OUT_SLOW_IN_INTERPOLATOR:Landroid/view/animation/Interpolator;

    invoke-virtual {p2, v0}, Landroid/view/animation/Animation;->setInterpolator(Landroid/view/animation/Interpolator;)V

    new-instance v0, Landroid/support/design/widget/FloatingActionButtonGingerbread$2;

    invoke-direct {v0, p0, p1}, Landroid/support/design/widget/FloatingActionButtonGingerbread$2;-><init>(Landroid/support/design/widget/FloatingActionButtonGingerbread;Landroid/support/design/widget/FloatingActionButtonImpl$InternalVisibilityChangedListener;)V

    invoke-virtual {p2, v0}, Landroid/view/animation/Animation;->setAnimationListener(Landroid/view/animation/Animation$AnimationListener;)V

    iget-object p1, p0, Landroid/support/design/widget/FloatingActionButtonGingerbread;->mView:Landroid/support/design/widget/VisibilityAwareImageButton;

    invoke-virtual {p1, p2}, Landroid/support/design/widget/VisibilityAwareImageButton;->startAnimation(Landroid/view/animation/Animation;)V

    return-void
.end method

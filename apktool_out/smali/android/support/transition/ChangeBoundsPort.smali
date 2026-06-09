.class Landroid/support/transition/ChangeBoundsPort;
.super Landroid/support/transition/TransitionPort;


# annotations
.annotation build Landroid/annotation/TargetApi;
    value = 0xe
.end annotation

.annotation build Landroid/support/annotation/RequiresApi;
    value = 0xe
.end annotation


# static fields
.field private static final LOG_TAG:Ljava/lang/String; = "ChangeBounds"

.field private static final PROPNAME_BOUNDS:Ljava/lang/String; = "android:changeBounds:bounds"

.field private static final PROPNAME_PARENT:Ljava/lang/String; = "android:changeBounds:parent"

.field private static final PROPNAME_WINDOW_X:Ljava/lang/String; = "android:changeBounds:windowX"

.field private static final PROPNAME_WINDOW_Y:Ljava/lang/String; = "android:changeBounds:windowY"

.field private static sRectEvaluator:Landroid/support/transition/RectEvaluator;

.field private static final sTransitionProperties:[Ljava/lang/String;


# instance fields
.field mReparent:Z

.field mResizeClip:Z

.field tempLocation:[I


# direct methods
.method static constructor <clinit>()V
    .locals 3

    const/4 v0, 0x4

    new-array v0, v0, [Ljava/lang/String;

    const-string v1, "android:changeBounds:bounds"

    const/4 v2, 0x0

    aput-object v1, v0, v2

    const-string v1, "android:changeBounds:parent"

    const/4 v2, 0x1

    aput-object v1, v0, v2

    const-string v1, "android:changeBounds:windowX"

    const/4 v2, 0x2

    aput-object v1, v0, v2

    const-string v1, "android:changeBounds:windowY"

    const/4 v2, 0x3

    aput-object v1, v0, v2

    sput-object v0, Landroid/support/transition/ChangeBoundsPort;->sTransitionProperties:[Ljava/lang/String;

    new-instance v0, Landroid/support/transition/RectEvaluator;

    invoke-direct {v0}, Landroid/support/transition/RectEvaluator;-><init>()V

    sput-object v0, Landroid/support/transition/ChangeBoundsPort;->sRectEvaluator:Landroid/support/transition/RectEvaluator;

    return-void
.end method

.method constructor <init>()V
    .locals 1

    invoke-direct {p0}, Landroid/support/transition/TransitionPort;-><init>()V

    const/4 v0, 0x2

    new-array v0, v0, [I

    iput-object v0, p0, Landroid/support/transition/ChangeBoundsPort;->tempLocation:[I

    const/4 v0, 0x0

    iput-boolean v0, p0, Landroid/support/transition/ChangeBoundsPort;->mResizeClip:Z

    iput-boolean v0, p0, Landroid/support/transition/ChangeBoundsPort;->mReparent:Z

    return-void
.end method

.method private captureValues(Landroid/support/transition/TransitionValues;)V
    .locals 7

    iget-object v0, p1, Landroid/support/transition/TransitionValues;->view:Landroid/view/View;

    iget-object v1, p1, Landroid/support/transition/TransitionValues;->values:Ljava/util/Map;

    const-string v2, "android:changeBounds:bounds"

    new-instance v3, Landroid/graphics/Rect;

    invoke-virtual {v0}, Landroid/view/View;->getLeft()I

    move-result v4

    invoke-virtual {v0}, Landroid/view/View;->getTop()I

    move-result v5

    invoke-virtual {v0}, Landroid/view/View;->getRight()I

    move-result v6

    invoke-virtual {v0}, Landroid/view/View;->getBottom()I

    move-result v0

    invoke-direct {v3, v4, v5, v6, v0}, Landroid/graphics/Rect;-><init>(IIII)V

    invoke-interface {v1, v2, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p1, Landroid/support/transition/TransitionValues;->values:Ljava/util/Map;

    const-string v1, "android:changeBounds:parent"

    iget-object v2, p1, Landroid/support/transition/TransitionValues;->view:Landroid/view/View;

    invoke-virtual {v2}, Landroid/view/View;->getParent()Landroid/view/ViewParent;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p1, Landroid/support/transition/TransitionValues;->view:Landroid/view/View;

    iget-object v1, p0, Landroid/support/transition/ChangeBoundsPort;->tempLocation:[I

    invoke-virtual {v0, v1}, Landroid/view/View;->getLocationInWindow([I)V

    iget-object v0, p1, Landroid/support/transition/TransitionValues;->values:Ljava/util/Map;

    const-string v1, "android:changeBounds:windowX"

    iget-object v2, p0, Landroid/support/transition/ChangeBoundsPort;->tempLocation:[I

    const/4 v3, 0x0

    aget v2, v2, v3

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object p1, p1, Landroid/support/transition/TransitionValues;->values:Ljava/util/Map;

    const-string v0, "android:changeBounds:windowY"

    iget-object v1, p0, Landroid/support/transition/ChangeBoundsPort;->tempLocation:[I

    const/4 v2, 0x1

    aget v1, v1, v2

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    invoke-interface {p1, v0, v1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    return-void
.end method


# virtual methods
.method public captureEndValues(Landroid/support/transition/TransitionValues;)V
    .locals 0

    invoke-direct {p0, p1}, Landroid/support/transition/ChangeBoundsPort;->captureValues(Landroid/support/transition/TransitionValues;)V

    return-void
.end method

.method public captureStartValues(Landroid/support/transition/TransitionValues;)V
    .locals 0

    invoke-direct {p0, p1}, Landroid/support/transition/ChangeBoundsPort;->captureValues(Landroid/support/transition/TransitionValues;)V

    return-void
.end method

.method public createAnimator(Landroid/view/ViewGroup;Landroid/support/transition/TransitionValues;Landroid/support/transition/TransitionValues;)Landroid/animation/Animator;
    .locals 20

    move-object/from16 v0, p0

    move-object/from16 v1, p1

    move-object/from16 v2, p2

    move-object/from16 v3, p3

    if-eqz v2, :cond_25

    if-nez v3, :cond_0

    goto/16 :goto_9

    :cond_0
    iget-object v5, v2, Landroid/support/transition/TransitionValues;->values:Ljava/util/Map;

    iget-object v6, v3, Landroid/support/transition/TransitionValues;->values:Ljava/util/Map;

    const-string v7, "android:changeBounds:parent"

    invoke-interface {v5, v7}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Landroid/view/ViewGroup;

    const-string v7, "android:changeBounds:parent"

    invoke-interface {v6, v7}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Landroid/view/ViewGroup;

    if-eqz v5, :cond_24

    if-nez v6, :cond_1

    goto/16 :goto_8

    :cond_1
    iget-object v7, v3, Landroid/support/transition/TransitionValues;->view:Landroid/view/View;

    const/4 v8, 0x0

    const/4 v9, 0x1

    if-eq v5, v6, :cond_3

    invoke-virtual {v5}, Landroid/view/ViewGroup;->getId()I

    move-result v5

    invoke-virtual {v6}, Landroid/view/ViewGroup;->getId()I

    move-result v6

    if-ne v5, v6, :cond_2

    goto :goto_0

    :cond_2
    const/4 v5, 0x0

    goto :goto_1

    :cond_3
    :goto_0
    const/4 v5, 0x1

    :goto_1
    iget-boolean v6, v0, Landroid/support/transition/ChangeBoundsPort;->mReparent:Z

    const/4 v10, 0x2

    if-eqz v6, :cond_7

    if-eqz v5, :cond_4

    goto/16 :goto_3

    :cond_4
    iget-object v5, v2, Landroid/support/transition/TransitionValues;->values:Ljava/util/Map;

    const-string v6, "android:changeBounds:windowX"

    invoke-interface {v5, v6}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Ljava/lang/Integer;

    invoke-virtual {v5}, Ljava/lang/Integer;->intValue()I

    move-result v5

    iget-object v2, v2, Landroid/support/transition/TransitionValues;->values:Ljava/util/Map;

    const-string v6, "android:changeBounds:windowY"

    invoke-interface {v2, v6}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/Integer;

    invoke-virtual {v2}, Ljava/lang/Integer;->intValue()I

    move-result v2

    iget-object v6, v3, Landroid/support/transition/TransitionValues;->values:Ljava/util/Map;

    const-string v11, "android:changeBounds:windowX"

    invoke-interface {v6, v11}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Ljava/lang/Integer;

    invoke-virtual {v6}, Ljava/lang/Integer;->intValue()I

    move-result v6

    iget-object v3, v3, Landroid/support/transition/TransitionValues;->values:Ljava/util/Map;

    const-string v11, "android:changeBounds:windowY"

    invoke-interface {v3, v11}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/lang/Integer;

    invoke-virtual {v3}, Ljava/lang/Integer;->intValue()I

    move-result v3

    if-ne v5, v6, :cond_6

    if-eq v2, v3, :cond_5

    goto :goto_2

    :cond_5
    const/4 v1, 0x0

    return-object v1

    :cond_6
    :goto_2
    iget-object v4, v0, Landroid/support/transition/ChangeBoundsPort;->tempLocation:[I

    invoke-virtual {v1, v4}, Landroid/view/ViewGroup;->getLocationInWindow([I)V

    invoke-virtual {v7}, Landroid/view/View;->getWidth()I

    move-result v4

    invoke-virtual {v7}, Landroid/view/View;->getHeight()I

    move-result v11

    sget-object v12, Landroid/graphics/Bitmap$Config;->ARGB_8888:Landroid/graphics/Bitmap$Config;

    invoke-static {v4, v11, v12}, Landroid/graphics/Bitmap;->createBitmap(IILandroid/graphics/Bitmap$Config;)Landroid/graphics/Bitmap;

    move-result-object v4

    new-instance v11, Landroid/graphics/Canvas;

    invoke-direct {v11, v4}, Landroid/graphics/Canvas;-><init>(Landroid/graphics/Bitmap;)V

    invoke-virtual {v7, v11}, Landroid/view/View;->draw(Landroid/graphics/Canvas;)V

    new-instance v11, Landroid/graphics/drawable/BitmapDrawable;

    invoke-direct {v11, v4}, Landroid/graphics/drawable/BitmapDrawable;-><init>(Landroid/graphics/Bitmap;)V

    const/4 v4, 0x4

    invoke-virtual {v7, v4}, Landroid/view/View;->setVisibility(I)V

    invoke-static/range {p1 .. p1}, Landroid/support/transition/ViewOverlay;->createFrom(Landroid/view/View;)Landroid/support/transition/ViewOverlay;

    move-result-object v4

    invoke-virtual {v4, v11}, Landroid/support/transition/ViewOverlay;->add(Landroid/graphics/drawable/Drawable;)V

    new-instance v4, Landroid/graphics/Rect;

    iget-object v12, v0, Landroid/support/transition/ChangeBoundsPort;->tempLocation:[I

    aget v12, v12, v8

    sub-int v12, v5, v12

    iget-object v13, v0, Landroid/support/transition/ChangeBoundsPort;->tempLocation:[I

    aget v13, v13, v9

    sub-int v13, v2, v13

    iget-object v14, v0, Landroid/support/transition/ChangeBoundsPort;->tempLocation:[I

    aget v14, v14, v8

    sub-int/2addr v5, v14

    invoke-virtual {v7}, Landroid/view/View;->getWidth()I

    move-result v14

    add-int/2addr v5, v14

    iget-object v14, v0, Landroid/support/transition/ChangeBoundsPort;->tempLocation:[I

    aget v14, v14, v9

    sub-int/2addr v2, v14

    invoke-virtual {v7}, Landroid/view/View;->getHeight()I

    move-result v14

    add-int/2addr v2, v14

    invoke-direct {v4, v12, v13, v5, v2}, Landroid/graphics/Rect;-><init>(IIII)V

    new-instance v2, Landroid/graphics/Rect;

    iget-object v5, v0, Landroid/support/transition/ChangeBoundsPort;->tempLocation:[I

    aget v5, v5, v8

    sub-int v5, v6, v5

    iget-object v12, v0, Landroid/support/transition/ChangeBoundsPort;->tempLocation:[I

    aget v12, v12, v9

    sub-int v12, v3, v12

    iget-object v13, v0, Landroid/support/transition/ChangeBoundsPort;->tempLocation:[I

    aget v13, v13, v8

    sub-int/2addr v6, v13

    invoke-virtual {v7}, Landroid/view/View;->getWidth()I

    move-result v13

    add-int/2addr v6, v13

    iget-object v13, v0, Landroid/support/transition/ChangeBoundsPort;->tempLocation:[I

    aget v13, v13, v9

    sub-int/2addr v3, v13

    invoke-virtual {v7}, Landroid/view/View;->getHeight()I

    move-result v13

    add-int/2addr v3, v13

    invoke-direct {v2, v5, v12, v6, v3}, Landroid/graphics/Rect;-><init>(IIII)V

    const-string v3, "bounds"

    sget-object v5, Landroid/support/transition/ChangeBoundsPort;->sRectEvaluator:Landroid/support/transition/RectEvaluator;

    new-array v6, v10, [Ljava/lang/Object;

    aput-object v4, v6, v8

    aput-object v2, v6, v9

    invoke-static {v11, v3, v5, v6}, Landroid/animation/ObjectAnimator;->ofObject(Ljava/lang/Object;Ljava/lang/String;Landroid/animation/TypeEvaluator;[Ljava/lang/Object;)Landroid/animation/ObjectAnimator;

    move-result-object v2

    new-instance v3, Landroid/support/transition/ChangeBoundsPort$4;

    invoke-direct {v3, v0, v1, v11, v7}, Landroid/support/transition/ChangeBoundsPort$4;-><init>(Landroid/support/transition/ChangeBoundsPort;Landroid/view/ViewGroup;Landroid/graphics/drawable/BitmapDrawable;Landroid/view/View;)V

    invoke-virtual {v2, v3}, Landroid/animation/ObjectAnimator;->addListener(Landroid/animation/Animator$AnimatorListener;)V

    return-object v2

    :cond_7
    :goto_3
    iget-object v1, v2, Landroid/support/transition/TransitionValues;->values:Ljava/util/Map;

    const-string v2, "android:changeBounds:bounds"

    invoke-interface {v1, v2}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/graphics/Rect;

    iget-object v2, v3, Landroid/support/transition/TransitionValues;->values:Ljava/util/Map;

    const-string v3, "android:changeBounds:bounds"

    invoke-interface {v2, v3}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Landroid/graphics/Rect;

    iget v3, v1, Landroid/graphics/Rect;->left:I

    iget v5, v2, Landroid/graphics/Rect;->left:I

    iget v6, v1, Landroid/graphics/Rect;->top:I

    iget v11, v2, Landroid/graphics/Rect;->top:I

    iget v12, v1, Landroid/graphics/Rect;->right:I

    iget v13, v2, Landroid/graphics/Rect;->right:I

    iget v1, v1, Landroid/graphics/Rect;->bottom:I

    iget v2, v2, Landroid/graphics/Rect;->bottom:I

    sub-int v14, v12, v3

    sub-int v15, v1, v6

    sub-int v4, v13, v5

    sub-int v9, v2, v11

    if-eqz v14, :cond_c

    if-eqz v15, :cond_c

    if-eqz v4, :cond_c

    if-eqz v9, :cond_c

    if-eq v3, v5, :cond_8

    const/16 v17, 0x1

    goto :goto_4

    :cond_8
    const/16 v17, 0x0

    :goto_4
    if-eq v6, v11, :cond_9

    add-int/lit8 v17, v17, 0x1

    :cond_9
    if-eq v12, v13, :cond_a

    add-int/lit8 v17, v17, 0x1

    :cond_a
    if-eq v1, v2, :cond_b

    add-int/lit8 v17, v17, 0x1

    :cond_b
    move/from16 v8, v17

    :cond_c
    if-lez v8, :cond_5

    iget-boolean v10, v0, Landroid/support/transition/ChangeBoundsPort;->mResizeClip:Z

    if-nez v10, :cond_16

    new-array v4, v8, [Landroid/animation/PropertyValuesHolder;

    if-eq v3, v5, :cond_d

    invoke-virtual {v7, v3}, Landroid/view/View;->setLeft(I)V

    :cond_d
    if-eq v6, v11, :cond_e

    invoke-virtual {v7, v6}, Landroid/view/View;->setTop(I)V

    :cond_e
    if-eq v12, v13, :cond_f

    invoke-virtual {v7, v12}, Landroid/view/View;->setRight(I)V

    :cond_f
    if-eq v1, v2, :cond_10

    invoke-virtual {v7, v1}, Landroid/view/View;->setBottom(I)V

    :cond_10
    if-eq v3, v5, :cond_11

    const-string v8, "left"

    const/4 v9, 0x2

    new-array v10, v9, [I

    const/16 v18, 0x0

    aput v3, v10, v18

    const/16 v16, 0x1

    aput v5, v10, v16

    invoke-static {v8, v10}, Landroid/animation/PropertyValuesHolder;->ofInt(Ljava/lang/String;[I)Landroid/animation/PropertyValuesHolder;

    move-result-object v3

    aput-object v3, v4, v18

    const/4 v3, 0x1

    goto :goto_5

    :cond_11
    const/4 v9, 0x2

    const/16 v16, 0x1

    const/16 v18, 0x0

    const/4 v3, 0x0

    :goto_5
    if-eq v6, v11, :cond_12

    add-int/lit8 v5, v3, 0x1

    const-string v8, "top"

    new-array v10, v9, [I

    aput v6, v10, v18

    aput v11, v10, v16

    invoke-static {v8, v10}, Landroid/animation/PropertyValuesHolder;->ofInt(Ljava/lang/String;[I)Landroid/animation/PropertyValuesHolder;

    move-result-object v6

    aput-object v6, v4, v3

    move v3, v5

    :cond_12
    if-eq v12, v13, :cond_13

    add-int/lit8 v5, v3, 0x1

    const-string v6, "right"

    new-array v8, v9, [I

    aput v12, v8, v18

    aput v13, v8, v16

    invoke-static {v6, v8}, Landroid/animation/PropertyValuesHolder;->ofInt(Ljava/lang/String;[I)Landroid/animation/PropertyValuesHolder;

    move-result-object v6

    aput-object v6, v4, v3

    move v3, v5

    :cond_13
    if-eq v1, v2, :cond_14

    const-string v5, "bottom"

    new-array v6, v9, [I

    aput v1, v6, v18

    aput v2, v6, v16

    invoke-static {v5, v6}, Landroid/animation/PropertyValuesHolder;->ofInt(Ljava/lang/String;[I)Landroid/animation/PropertyValuesHolder;

    move-result-object v1

    aput-object v1, v4, v3

    :cond_14
    invoke-static {v7, v4}, Landroid/animation/ObjectAnimator;->ofPropertyValuesHolder(Ljava/lang/Object;[Landroid/animation/PropertyValuesHolder;)Landroid/animation/ObjectAnimator;

    move-result-object v1

    invoke-virtual {v7}, Landroid/view/View;->getParent()Landroid/view/ViewParent;

    move-result-object v2

    instance-of v2, v2, Landroid/view/ViewGroup;

    if-eqz v2, :cond_15

    invoke-virtual {v7}, Landroid/view/View;->getParent()Landroid/view/ViewParent;

    move-result-object v2

    check-cast v2, Landroid/view/ViewGroup;

    new-instance v2, Landroid/support/transition/ChangeBoundsPort$1;

    invoke-direct {v2, v0}, Landroid/support/transition/ChangeBoundsPort$1;-><init>(Landroid/support/transition/ChangeBoundsPort;)V

    invoke-virtual {v0, v2}, Landroid/support/transition/ChangeBoundsPort;->addListener(Landroid/support/transition/TransitionPort$TransitionListener;)Landroid/support/transition/TransitionPort;

    :cond_15
    return-object v1

    :cond_16
    if-eq v14, v4, :cond_17

    invoke-static {v14, v4}, Ljava/lang/Math;->max(II)I

    move-result v1

    add-int/2addr v1, v5

    invoke-virtual {v7, v1}, Landroid/view/View;->setRight(I)V

    :cond_17
    if-eq v15, v9, :cond_18

    invoke-static {v15, v9}, Ljava/lang/Math;->max(II)I

    move-result v1

    add-int/2addr v1, v11

    invoke-virtual {v7, v1}, Landroid/view/View;->setBottom(I)V

    :cond_18
    if-eq v3, v5, :cond_19

    sub-int v1, v3, v5

    int-to-float v1, v1

    invoke-virtual {v7, v1}, Landroid/view/View;->setTranslationX(F)V

    :cond_19
    if-eq v6, v11, :cond_1a

    sub-int v1, v6, v11

    int-to-float v1, v1

    invoke-virtual {v7, v1}, Landroid/view/View;->setTranslationY(F)V

    :cond_1a
    sub-int/2addr v5, v3

    int-to-float v1, v5

    sub-int/2addr v11, v6

    int-to-float v2, v11

    sub-int v3, v4, v14

    sub-int v5, v9, v15

    const/4 v6, 0x0

    cmpl-float v8, v1, v6

    if-eqz v8, :cond_1b

    const/4 v8, 0x1

    goto :goto_6

    :cond_1b
    const/4 v8, 0x0

    :goto_6
    cmpl-float v10, v2, v6

    if-eqz v10, :cond_1c

    add-int/lit8 v8, v8, 0x1

    :cond_1c
    if-nez v3, :cond_1d

    if-eqz v5, :cond_1e

    :cond_1d
    add-int/lit8 v8, v8, 0x1

    :cond_1e
    new-array v8, v8, [Landroid/animation/PropertyValuesHolder;

    cmpl-float v1, v1, v6

    if-eqz v1, :cond_1f

    const-string v1, "translationX"

    const/4 v10, 0x2

    new-array v11, v10, [F

    invoke-virtual {v7}, Landroid/view/View;->getTranslationX()F

    move-result v12

    const/16 v18, 0x0

    aput v12, v11, v18

    const/4 v12, 0x1

    aput v6, v11, v12

    invoke-static {v1, v11}, Landroid/animation/PropertyValuesHolder;->ofFloat(Ljava/lang/String;[F)Landroid/animation/PropertyValuesHolder;

    move-result-object v1

    aput-object v1, v8, v18

    const/4 v1, 0x1

    goto :goto_7

    :cond_1f
    const/4 v10, 0x2

    const/4 v12, 0x1

    const/16 v18, 0x0

    const/4 v1, 0x0

    :goto_7
    cmpl-float v2, v2, v6

    if-eqz v2, :cond_20

    const-string v2, "translationY"

    new-array v10, v10, [F

    invoke-virtual {v7}, Landroid/view/View;->getTranslationY()F

    move-result v11

    aput v11, v10, v18

    aput v6, v10, v12

    invoke-static {v2, v10}, Landroid/animation/PropertyValuesHolder;->ofFloat(Ljava/lang/String;[F)Landroid/animation/PropertyValuesHolder;

    move-result-object v2

    aput-object v2, v8, v1

    :cond_20
    if-nez v3, :cond_21

    if-eqz v5, :cond_22

    :cond_21
    new-instance v1, Landroid/graphics/Rect;

    const/4 v2, 0x0

    invoke-direct {v1, v2, v2, v14, v15}, Landroid/graphics/Rect;-><init>(IIII)V

    new-instance v1, Landroid/graphics/Rect;

    invoke-direct {v1, v2, v2, v4, v9}, Landroid/graphics/Rect;-><init>(IIII)V

    :cond_22
    invoke-static {v7, v8}, Landroid/animation/ObjectAnimator;->ofPropertyValuesHolder(Ljava/lang/Object;[Landroid/animation/PropertyValuesHolder;)Landroid/animation/ObjectAnimator;

    move-result-object v1

    invoke-virtual {v7}, Landroid/view/View;->getParent()Landroid/view/ViewParent;

    move-result-object v2

    instance-of v2, v2, Landroid/view/ViewGroup;

    if-eqz v2, :cond_23

    invoke-virtual {v7}, Landroid/view/View;->getParent()Landroid/view/ViewParent;

    move-result-object v2

    check-cast v2, Landroid/view/ViewGroup;

    new-instance v2, Landroid/support/transition/ChangeBoundsPort$2;

    invoke-direct {v2, v0}, Landroid/support/transition/ChangeBoundsPort$2;-><init>(Landroid/support/transition/ChangeBoundsPort;)V

    invoke-virtual {v0, v2}, Landroid/support/transition/ChangeBoundsPort;->addListener(Landroid/support/transition/TransitionPort$TransitionListener;)Landroid/support/transition/TransitionPort;

    :cond_23
    new-instance v2, Landroid/support/transition/ChangeBoundsPort$3;

    invoke-direct {v2, v0}, Landroid/support/transition/ChangeBoundsPort$3;-><init>(Landroid/support/transition/ChangeBoundsPort;)V

    invoke-virtual {v1, v2}, Landroid/animation/ObjectAnimator;->addListener(Landroid/animation/Animator$AnimatorListener;)V

    return-object v1

    :cond_24
    :goto_8
    const/4 v1, 0x0

    return-object v1

    :cond_25
    :goto_9
    const/4 v1, 0x0

    return-object v1
.end method

.method public getTransitionProperties()[Ljava/lang/String;
    .locals 1

    sget-object v0, Landroid/support/transition/ChangeBoundsPort;->sTransitionProperties:[Ljava/lang/String;

    return-object v0
.end method

.method public setReparent(Z)V
    .locals 0

    iput-boolean p1, p0, Landroid/support/transition/ChangeBoundsPort;->mReparent:Z

    return-void
.end method

.method public setResizeClip(Z)V
    .locals 0

    iput-boolean p1, p0, Landroid/support/transition/ChangeBoundsPort;->mResizeClip:Z

    return-void
.end method

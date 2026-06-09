.class public Lchat/ola/vn/view/OlaGalleryView;
.super Landroid/widget/HorizontalScrollView;

# interfaces
.implements Landroid/view/GestureDetector$OnGestureListener;
.implements Landroid/view/View$OnClickListener;


# instance fields
.field protected a:Landroid/widget/LinearLayout;

.field private b:Landroid/widget/ListAdapter;

.field private c:Landroid/widget/AdapterView$OnItemClickListener;

.field private d:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Landroid/view/View;",
            ">;"
        }
    .end annotation
.end field

.field private e:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Landroid/view/View;",
            ">;"
        }
    .end annotation
.end field

.field private f:I


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 0

    invoke-direct {p0, p1}, Landroid/widget/HorizontalScrollView;-><init>(Landroid/content/Context;)V

    const/4 p1, 0x5

    iput p1, p0, Lchat/ola/vn/view/OlaGalleryView;->f:I

    invoke-direct {p0}, Lchat/ola/vn/view/OlaGalleryView;->c()V

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;)V
    .locals 0

    invoke-direct {p0, p1, p2}, Landroid/widget/HorizontalScrollView;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;)V

    const/4 p1, 0x5

    iput p1, p0, Lchat/ola/vn/view/OlaGalleryView;->f:I

    invoke-direct {p0}, Lchat/ola/vn/view/OlaGalleryView;->c()V

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V
    .locals 0

    invoke-direct {p0, p1, p2, p3}, Landroid/widget/HorizontalScrollView;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V

    const/4 p1, 0x5

    iput p1, p0, Lchat/ola/vn/view/OlaGalleryView;->f:I

    invoke-direct {p0}, Lchat/ola/vn/view/OlaGalleryView;->c()V

    return-void
.end method

.method static synthetic a(Lchat/ola/vn/view/OlaGalleryView;)V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/view/OlaGalleryView;->d()V

    return-void
.end method

.method private c()V
    .locals 4
    .annotation build Landroid/annotation/SuppressLint;
        value = {
            "NewApi"
        }
    .end annotation

    const/4 v0, 0x0

    :try_start_0
    invoke-virtual {p0, v0}, Lchat/ola/vn/view/OlaGalleryView;->setHorizontalScrollBarEnabled(Z)V

    const/4 v1, 0x1

    invoke-virtual {p0, v1}, Lchat/ola/vn/view/OlaGalleryView;->setFillViewport(Z)V

    new-instance v1, Landroid/widget/LinearLayout;

    invoke-virtual {p0}, Lchat/ola/vn/view/OlaGalleryView;->getContext()Landroid/content/Context;

    move-result-object v2

    invoke-direct {v1, v2}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    iput-object v1, p0, Lchat/ola/vn/view/OlaGalleryView;->a:Landroid/widget/LinearLayout;

    invoke-static {}, Lcom/mg/ola/common/d/g;->c()Z

    move-result v1

    if-eqz v1, :cond_0

    iget-object v1, p0, Lchat/ola/vn/view/OlaGalleryView;->a:Landroid/widget/LinearLayout;

    new-instance v2, Landroid/animation/LayoutTransition;

    invoke-direct {v2}, Landroid/animation/LayoutTransition;-><init>()V

    invoke-virtual {v1, v2}, Landroid/widget/LinearLayout;->setLayoutTransition(Landroid/animation/LayoutTransition;)V

    :cond_0
    iget-object v1, p0, Lchat/ola/vn/view/OlaGalleryView;->a:Landroid/widget/LinearLayout;

    invoke-virtual {v1, v0}, Landroid/widget/LinearLayout;->setOrientation(I)V

    iget-object v0, p0, Lchat/ola/vn/view/OlaGalleryView;->a:Landroid/widget/LinearLayout;

    const/16 v1, 0x13

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->setGravity(I)V

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lchat/ola/vn/view/OlaGalleryView;->d:Ljava/util/List;

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lchat/ola/vn/view/OlaGalleryView;->e:Ljava/util/List;

    iget-object v0, p0, Lchat/ola/vn/view/OlaGalleryView;->a:Landroid/widget/LinearLayout;

    new-instance v1, Landroid/view/ViewGroup$LayoutParams;

    const/4 v2, -0x2

    const/4 v3, -0x1

    invoke-direct {v1, v2, v3}, Landroid/view/ViewGroup$LayoutParams;-><init>(II)V

    invoke-virtual {p0, v0, v1}, Lchat/ola/vn/view/OlaGalleryView;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method private d()V
    .locals 10

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/view/OlaGalleryView;->b:Landroid/widget/ListAdapter;

    if-nez v0, :cond_0

    return-void

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/view/OlaGalleryView;->d:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    iget-object v1, p0, Lchat/ola/vn/view/OlaGalleryView;->e:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v1

    iget-object v2, p0, Lchat/ola/vn/view/OlaGalleryView;->b:Landroid/widget/ListAdapter;

    invoke-interface {v2}, Landroid/widget/ListAdapter;->getCount()I

    move-result v2
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    :try_start_1
    iget-object v3, p0, Lchat/ola/vn/view/OlaGalleryView;->a:Landroid/widget/LinearLayout;

    invoke-virtual {v3}, Landroid/widget/LinearLayout;->getChildCount()I

    move-result v3

    sub-int/2addr v3, v0

    sub-int/2addr v3, v1

    sub-int/2addr v3, v2

    if-lez v3, :cond_1

    iget-object v4, p0, Lchat/ola/vn/view/OlaGalleryView;->a:Landroid/widget/LinearLayout;

    add-int v5, v0, v2

    invoke-virtual {v4, v5, v3}, Landroid/widget/LinearLayout;->removeViews(II)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_0

    :catch_0
    move-exception v3

    :try_start_2
    invoke-virtual {v3}, Ljava/lang/Throwable;->printStackTrace()V

    :cond_1
    :goto_0
    const/4 v3, 0x0

    const/4 v4, 0x0

    :goto_1
    if-ge v4, v2, :cond_5

    add-int v5, v0, v4

    iget-object v6, p0, Lchat/ola/vn/view/OlaGalleryView;->a:Landroid/widget/LinearLayout;

    invoke-virtual {v6}, Landroid/widget/LinearLayout;->getChildCount()I

    move-result v6

    add-int v7, v0, v1

    add-int/2addr v7, v4

    if-gt v6, v7, :cond_2

    const/4 v6, 0x0

    goto :goto_2

    :cond_2
    iget-object v6, p0, Lchat/ola/vn/view/OlaGalleryView;->a:Landroid/widget/LinearLayout;

    invoke-virtual {v6, v5}, Landroid/widget/LinearLayout;->getChildAt(I)Landroid/view/View;

    move-result-object v6

    :goto_2
    iget-object v7, p0, Lchat/ola/vn/view/OlaGalleryView;->b:Landroid/widget/ListAdapter;

    iget-object v8, p0, Lchat/ola/vn/view/OlaGalleryView;->a:Landroid/widget/LinearLayout;

    invoke-interface {v7, v4, v6, v8}, Landroid/widget/ListAdapter;->getView(ILandroid/view/View;Landroid/view/ViewGroup;)Landroid/view/View;

    move-result-object v7

    invoke-virtual {v7, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    invoke-virtual {v7}, Landroid/view/View;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v8

    if-eqz v8, :cond_3

    new-instance v8, Landroid/widget/LinearLayout$LayoutParams;

    invoke-virtual {v7}, Landroid/view/View;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v9

    invoke-direct {v8, v9}, Landroid/widget/LinearLayout$LayoutParams;-><init>(Landroid/view/ViewGroup$LayoutParams;)V

    goto :goto_3

    :cond_3
    new-instance v8, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v9, -0x2

    invoke-direct {v8, v9, v9}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    :goto_3
    iget v9, p0, Lchat/ola/vn/view/OlaGalleryView;->f:I

    invoke-virtual {v8, v9, v3, v3, v3}, Landroid/widget/LinearLayout$LayoutParams;->setMargins(IIII)V

    if-nez v6, :cond_4

    iget-object v6, p0, Lchat/ola/vn/view/OlaGalleryView;->a:Landroid/widget/LinearLayout;

    invoke-virtual {v6, v7, v5, v8}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;ILandroid/view/ViewGroup$LayoutParams;)V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    :cond_4
    add-int/lit8 v4, v4, 0x1

    goto :goto_1

    :catch_1
    move-exception v0

    invoke-virtual {v0}, Ljava/lang/Throwable;->printStackTrace()V

    :cond_5
    return-void
.end method


# virtual methods
.method public a()V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/view/OlaGalleryView;->d()V

    return-void
.end method

.method public a(Landroid/view/View;)V
    .locals 1

    if-eqz p1, :cond_0

    iget-object v0, p0, Lchat/ola/vn/view/OlaGalleryView;->a:Landroid/widget/LinearLayout;

    invoke-virtual {v0, p1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    iget-object v0, p0, Lchat/ola/vn/view/OlaGalleryView;->e:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    :cond_0
    return-void
.end method

.method public b()V
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/view/OlaGalleryView;->a:Landroid/widget/LinearLayout;

    invoke-virtual {v0}, Landroid/widget/LinearLayout;->getChildCount()I

    move-result v0

    if-lez v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/view/OlaGalleryView;->a:Landroid/widget/LinearLayout;

    iget-object v1, p0, Lchat/ola/vn/view/OlaGalleryView;->a:Landroid/widget/LinearLayout;

    invoke-virtual {v1}, Landroid/widget/LinearLayout;->getChildCount()I

    move-result v1

    add-int/lit8 v1, v1, -0x1

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->getChildAt(I)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0}, Landroid/view/View;->getLeft()I

    move-result v1

    invoke-virtual {v0}, Landroid/view/View;->getTop()I

    move-result v0

    invoke-virtual {p0, v1, v0}, Lchat/ola/vn/view/OlaGalleryView;->smoothScrollTo(II)V

    :cond_0
    return-void
.end method

.method public getLeftItemCount()I
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/view/OlaGalleryView;->d:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    return v0
.end method

.method public getRightItemCount()I
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/view/OlaGalleryView;->e:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    return v0
.end method

.method public onClick(Landroid/view/View;)V
    .locals 8

    iget-object v0, p0, Lchat/ola/vn/view/OlaGalleryView;->c:Landroid/widget/AdapterView$OnItemClickListener;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/view/OlaGalleryView;->a:Landroid/widget/LinearLayout;

    invoke-virtual {v0, p1}, Landroid/widget/LinearLayout;->indexOfChild(Landroid/view/View;)I

    move-result v0

    iget-object v1, p0, Lchat/ola/vn/view/OlaGalleryView;->d:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v1

    sub-int v5, v0, v1

    iget-object v2, p0, Lchat/ola/vn/view/OlaGalleryView;->c:Landroid/widget/AdapterView$OnItemClickListener;

    const/4 v3, 0x0

    int-to-long v6, v5

    move-object v4, p1

    invoke-interface/range {v2 .. v7}, Landroid/widget/AdapterView$OnItemClickListener;->onItemClick(Landroid/widget/AdapterView;Landroid/view/View;IJ)V

    :cond_0
    return-void
.end method

.method public onDown(Landroid/view/MotionEvent;)Z
    .locals 0

    const/4 p1, 0x0

    return p1
.end method

.method protected onDraw(Landroid/graphics/Canvas;)V
    .locals 0

    invoke-super {p0, p1}, Landroid/widget/HorizontalScrollView;->onDraw(Landroid/graphics/Canvas;)V

    return-void
.end method

.method public onFling(Landroid/view/MotionEvent;Landroid/view/MotionEvent;FF)Z
    .locals 0

    const/4 p1, 0x0

    return p1
.end method

.method public onLongPress(Landroid/view/MotionEvent;)V
    .locals 0

    return-void
.end method

.method public onScroll(Landroid/view/MotionEvent;Landroid/view/MotionEvent;FF)Z
    .locals 0

    const/4 p1, 0x0

    return p1
.end method

.method protected onScrollChanged(IIII)V
    .locals 0

    invoke-super {p0, p1, p2, p3, p4}, Landroid/widget/HorizontalScrollView;->onScrollChanged(IIII)V

    return-void
.end method

.method public onShowPress(Landroid/view/MotionEvent;)V
    .locals 0

    return-void
.end method

.method public onSingleTapUp(Landroid/view/MotionEvent;)Z
    .locals 0

    const/4 p1, 0x0

    return p1
.end method

.method public setAdapter(Landroid/widget/ListAdapter;)V
    .locals 1

    iput-object p1, p0, Lchat/ola/vn/view/OlaGalleryView;->b:Landroid/widget/ListAdapter;

    iget-object p1, p0, Lchat/ola/vn/view/OlaGalleryView;->b:Landroid/widget/ListAdapter;

    new-instance v0, Lchat/ola/vn/view/OlaGalleryView$2;

    invoke-direct {v0, p0}, Lchat/ola/vn/view/OlaGalleryView$2;-><init>(Lchat/ola/vn/view/OlaGalleryView;)V

    invoke-interface {p1, v0}, Landroid/widget/ListAdapter;->registerDataSetObserver(Landroid/database/DataSetObserver;)V

    invoke-direct {p0}, Lchat/ola/vn/view/OlaGalleryView;->d()V

    return-void
.end method

.method public setChildSpace(I)V
    .locals 0

    iput p1, p0, Lchat/ola/vn/view/OlaGalleryView;->f:I

    return-void
.end method

.method public setChildSpaceRes(I)V
    .locals 1

    :try_start_0
    invoke-virtual {p0}, Lchat/ola/vn/view/OlaGalleryView;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {v0, p1}, Landroid/content/res/Resources;->getDimensionPixelSize(I)I

    move-result p1

    iput p1, p0, Lchat/ola/vn/view/OlaGalleryView;->f:I
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    return-void
.end method

.method public setDisplayChild(I)V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/view/OlaGalleryView;->a:Landroid/widget/LinearLayout;

    invoke-virtual {v0, p1}, Landroid/widget/LinearLayout;->getChildAt(I)Landroid/view/View;

    move-result-object p1

    if-nez p1, :cond_0

    return-void

    :cond_0
    new-instance v0, Lchat/ola/vn/view/OlaGalleryView$1;

    invoke-direct {v0, p0, p1}, Lchat/ola/vn/view/OlaGalleryView$1;-><init>(Lchat/ola/vn/view/OlaGalleryView;Landroid/view/View;)V

    invoke-virtual {p0, v0}, Lchat/ola/vn/view/OlaGalleryView;->post(Ljava/lang/Runnable;)Z

    return-void
.end method

.method public setEnableLayoutAnimation(Z)V
    .locals 1
    .annotation build Landroid/annotation/TargetApi;
        value = 0xb
    .end annotation

    if-eqz p1, :cond_0

    invoke-static {}, Lcom/mg/ola/common/d/g;->c()Z

    move-result p1

    if-eqz p1, :cond_1

    iget-object p1, p0, Lchat/ola/vn/view/OlaGalleryView;->a:Landroid/widget/LinearLayout;

    new-instance v0, Landroid/animation/LayoutTransition;

    invoke-direct {v0}, Landroid/animation/LayoutTransition;-><init>()V

    :goto_0
    invoke-virtual {p1, v0}, Landroid/widget/LinearLayout;->setLayoutTransition(Landroid/animation/LayoutTransition;)V

    return-void

    :cond_0
    invoke-static {}, Lcom/mg/ola/common/d/g;->c()Z

    move-result p1

    if-eqz p1, :cond_1

    iget-object p1, p0, Lchat/ola/vn/view/OlaGalleryView;->a:Landroid/widget/LinearLayout;

    const/4 v0, 0x0

    goto :goto_0

    :cond_1
    return-void
.end method

.method public setOnItemClickListener(Landroid/widget/AdapterView$OnItemClickListener;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/view/OlaGalleryView;->c:Landroid/widget/AdapterView$OnItemClickListener;

    return-void
.end method

.class public abstract Lcom/mg/ola/common/widget/IcsAbsSpinner;
.super Lcom/mg/ola/common/widget/a;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/mg/ola/common/widget/IcsAbsSpinner$a;,
        Lcom/mg/ola/common/widget/IcsAbsSpinner$SavedState;
    }
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lcom/mg/ola/common/widget/a<",
        "Landroid/widget/SpinnerAdapter;",
        ">;"
    }
.end annotation


# instance fields
.field private F:Landroid/database/DataSetObserver;

.field a:Landroid/widget/SpinnerAdapter;

.field b:I

.field c:I

.field d:Z

.field e:I

.field f:I

.field g:I

.field h:I

.field final i:Landroid/graphics/Rect;

.field final j:Lcom/mg/ola/common/widget/IcsAbsSpinner$a;


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/mg/ola/common/widget/a;-><init>(Landroid/content/Context;)V

    const/4 p1, 0x0

    iput p1, p0, Lcom/mg/ola/common/widget/IcsAbsSpinner;->e:I

    iput p1, p0, Lcom/mg/ola/common/widget/IcsAbsSpinner;->f:I

    iput p1, p0, Lcom/mg/ola/common/widget/IcsAbsSpinner;->g:I

    iput p1, p0, Lcom/mg/ola/common/widget/IcsAbsSpinner;->h:I

    new-instance p1, Landroid/graphics/Rect;

    invoke-direct {p1}, Landroid/graphics/Rect;-><init>()V

    iput-object p1, p0, Lcom/mg/ola/common/widget/IcsAbsSpinner;->i:Landroid/graphics/Rect;

    new-instance p1, Lcom/mg/ola/common/widget/IcsAbsSpinner$a;

    invoke-direct {p1, p0}, Lcom/mg/ola/common/widget/IcsAbsSpinner$a;-><init>(Lcom/mg/ola/common/widget/IcsAbsSpinner;)V

    iput-object p1, p0, Lcom/mg/ola/common/widget/IcsAbsSpinner;->j:Lcom/mg/ola/common/widget/IcsAbsSpinner$a;

    invoke-direct {p0}, Lcom/mg/ola/common/widget/IcsAbsSpinner;->i()V

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;)V
    .locals 1

    const/4 v0, 0x0

    invoke-direct {p0, p1, p2, v0}, Lcom/mg/ola/common/widget/IcsAbsSpinner;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V
    .locals 0

    invoke-direct {p0, p1, p2, p3}, Lcom/mg/ola/common/widget/a;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V

    const/4 p1, 0x0

    iput p1, p0, Lcom/mg/ola/common/widget/IcsAbsSpinner;->e:I

    iput p1, p0, Lcom/mg/ola/common/widget/IcsAbsSpinner;->f:I

    iput p1, p0, Lcom/mg/ola/common/widget/IcsAbsSpinner;->g:I

    iput p1, p0, Lcom/mg/ola/common/widget/IcsAbsSpinner;->h:I

    new-instance p1, Landroid/graphics/Rect;

    invoke-direct {p1}, Landroid/graphics/Rect;-><init>()V

    iput-object p1, p0, Lcom/mg/ola/common/widget/IcsAbsSpinner;->i:Landroid/graphics/Rect;

    new-instance p1, Lcom/mg/ola/common/widget/IcsAbsSpinner$a;

    invoke-direct {p1, p0}, Lcom/mg/ola/common/widget/IcsAbsSpinner$a;-><init>(Lcom/mg/ola/common/widget/IcsAbsSpinner;)V

    iput-object p1, p0, Lcom/mg/ola/common/widget/IcsAbsSpinner;->j:Lcom/mg/ola/common/widget/IcsAbsSpinner$a;

    invoke-direct {p0}, Lcom/mg/ola/common/widget/IcsAbsSpinner;->i()V

    return-void
.end method

.method private i()V
    .locals 1

    const/4 v0, 0x1

    invoke-virtual {p0, v0}, Lcom/mg/ola/common/widget/IcsAbsSpinner;->setFocusable(Z)V

    const/4 v0, 0x0

    invoke-virtual {p0, v0}, Lcom/mg/ola/common/widget/IcsAbsSpinner;->setWillNotDraw(Z)V

    return-void
.end method


# virtual methods
.method a(Landroid/view/View;)I
    .locals 0

    invoke-virtual {p1}, Landroid/view/View;->getMeasuredHeight()I

    move-result p1

    return p1
.end method

.method a()V
    .locals 3

    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/mg/ola/common/widget/IcsAbsSpinner;->v:Z

    iput-boolean v0, p0, Lcom/mg/ola/common/widget/IcsAbsSpinner;->p:Z

    invoke-virtual {p0}, Lcom/mg/ola/common/widget/IcsAbsSpinner;->removeAllViewsInLayout()V

    const/4 v0, -0x1

    iput v0, p0, Lcom/mg/ola/common/widget/IcsAbsSpinner;->C:I

    const-wide/high16 v1, -0x8000000000000000L

    iput-wide v1, p0, Lcom/mg/ola/common/widget/IcsAbsSpinner;->D:J

    invoke-virtual {p0, v0}, Lcom/mg/ola/common/widget/IcsAbsSpinner;->setSelectedPositionInt(I)V

    invoke-virtual {p0, v0}, Lcom/mg/ola/common/widget/IcsAbsSpinner;->setNextSelectedPositionInt(I)V

    invoke-virtual {p0}, Lcom/mg/ola/common/widget/IcsAbsSpinner;->invalidate()V

    return-void
.end method

.method b(Landroid/view/View;)I
    .locals 0

    invoke-virtual {p1}, Landroid/view/View;->getMeasuredWidth()I

    move-result p1

    return p1
.end method

.method protected generateDefaultLayoutParams()Landroid/view/ViewGroup$LayoutParams;
    .locals 3

    new-instance v0, Landroid/view/ViewGroup$LayoutParams;

    const/4 v1, -0x1

    const/4 v2, -0x2

    invoke-direct {v0, v1, v2}, Landroid/view/ViewGroup$LayoutParams;-><init>(II)V

    return-object v0
.end method

.method public bridge synthetic getAdapter()Landroid/widget/Adapter;
    .locals 1

    invoke-virtual {p0}, Lcom/mg/ola/common/widget/IcsAbsSpinner;->getAdapter()Landroid/widget/SpinnerAdapter;

    move-result-object v0

    return-object v0
.end method

.method public getAdapter()Landroid/widget/SpinnerAdapter;
    .locals 1

    iget-object v0, p0, Lcom/mg/ola/common/widget/IcsAbsSpinner;->a:Landroid/widget/SpinnerAdapter;

    return-object v0
.end method

.method public getCount()I
    .locals 1

    iget v0, p0, Lcom/mg/ola/common/widget/IcsAbsSpinner;->A:I

    return v0
.end method

.method public getSelectedView()Landroid/view/View;
    .locals 2

    iget v0, p0, Lcom/mg/ola/common/widget/IcsAbsSpinner;->A:I

    if-lez v0, :cond_0

    iget v0, p0, Lcom/mg/ola/common/widget/IcsAbsSpinner;->y:I

    if-ltz v0, :cond_0

    iget v0, p0, Lcom/mg/ola/common/widget/IcsAbsSpinner;->y:I

    iget v1, p0, Lcom/mg/ola/common/widget/IcsAbsSpinner;->k:I

    sub-int/2addr v0, v1

    invoke-virtual {p0, v0}, Lcom/mg/ola/common/widget/IcsAbsSpinner;->getChildAt(I)Landroid/view/View;

    move-result-object v0

    return-object v0

    :cond_0
    const/4 v0, 0x0

    return-object v0
.end method

.method protected onMeasure(II)V
    .locals 7
    .annotation build Landroid/annotation/TargetApi;
        value = 0xb
    .end annotation

    invoke-static {p1}, Landroid/view/View$MeasureSpec;->getMode(I)I

    move-result v0

    invoke-virtual {p0}, Lcom/mg/ola/common/widget/IcsAbsSpinner;->getPaddingLeft()I

    move-result v1

    invoke-virtual {p0}, Lcom/mg/ola/common/widget/IcsAbsSpinner;->getPaddingTop()I

    move-result v2

    invoke-virtual {p0}, Lcom/mg/ola/common/widget/IcsAbsSpinner;->getPaddingRight()I

    move-result v3

    invoke-virtual {p0}, Lcom/mg/ola/common/widget/IcsAbsSpinner;->getPaddingBottom()I

    move-result v4

    iget-object v5, p0, Lcom/mg/ola/common/widget/IcsAbsSpinner;->i:Landroid/graphics/Rect;

    iget v6, p0, Lcom/mg/ola/common/widget/IcsAbsSpinner;->e:I

    if-le v1, v6, :cond_0

    goto :goto_0

    :cond_0
    iget v1, p0, Lcom/mg/ola/common/widget/IcsAbsSpinner;->e:I

    :goto_0
    iput v1, v5, Landroid/graphics/Rect;->left:I

    iget-object v1, p0, Lcom/mg/ola/common/widget/IcsAbsSpinner;->i:Landroid/graphics/Rect;

    iget v5, p0, Lcom/mg/ola/common/widget/IcsAbsSpinner;->f:I

    if-le v2, v5, :cond_1

    goto :goto_1

    :cond_1
    iget v2, p0, Lcom/mg/ola/common/widget/IcsAbsSpinner;->f:I

    :goto_1
    iput v2, v1, Landroid/graphics/Rect;->top:I

    iget-object v1, p0, Lcom/mg/ola/common/widget/IcsAbsSpinner;->i:Landroid/graphics/Rect;

    iget v2, p0, Lcom/mg/ola/common/widget/IcsAbsSpinner;->g:I

    if-le v3, v2, :cond_2

    goto :goto_2

    :cond_2
    iget v3, p0, Lcom/mg/ola/common/widget/IcsAbsSpinner;->g:I

    :goto_2
    iput v3, v1, Landroid/graphics/Rect;->right:I

    iget-object v1, p0, Lcom/mg/ola/common/widget/IcsAbsSpinner;->i:Landroid/graphics/Rect;

    iget v2, p0, Lcom/mg/ola/common/widget/IcsAbsSpinner;->h:I

    if-le v4, v2, :cond_3

    goto :goto_3

    :cond_3
    iget v4, p0, Lcom/mg/ola/common/widget/IcsAbsSpinner;->h:I

    :goto_3
    iput v4, v1, Landroid/graphics/Rect;->bottom:I

    iget-boolean v1, p0, Lcom/mg/ola/common/widget/IcsAbsSpinner;->v:Z

    if-eqz v1, :cond_4

    invoke-virtual {p0}, Lcom/mg/ola/common/widget/IcsAbsSpinner;->e()V

    :cond_4
    invoke-virtual {p0}, Lcom/mg/ola/common/widget/IcsAbsSpinner;->getSelectedItemPosition()I

    move-result v1

    const/4 v2, 0x1

    const/4 v3, 0x0

    if-ltz v1, :cond_8

    iget-object v4, p0, Lcom/mg/ola/common/widget/IcsAbsSpinner;->a:Landroid/widget/SpinnerAdapter;

    if-eqz v4, :cond_8

    iget-object v4, p0, Lcom/mg/ola/common/widget/IcsAbsSpinner;->a:Landroid/widget/SpinnerAdapter;

    invoke-interface {v4}, Landroid/widget/SpinnerAdapter;->getCount()I

    move-result v4

    if-ge v1, v4, :cond_8

    iget-object v4, p0, Lcom/mg/ola/common/widget/IcsAbsSpinner;->j:Lcom/mg/ola/common/widget/IcsAbsSpinner$a;

    invoke-virtual {v4, v1}, Lcom/mg/ola/common/widget/IcsAbsSpinner$a;->a(I)Landroid/view/View;

    move-result-object v4

    if-nez v4, :cond_5

    iget-object v4, p0, Lcom/mg/ola/common/widget/IcsAbsSpinner;->a:Landroid/widget/SpinnerAdapter;

    const/4 v5, 0x0

    invoke-interface {v4, v1, v5, p0}, Landroid/widget/SpinnerAdapter;->getView(ILandroid/view/View;Landroid/view/ViewGroup;)Landroid/view/View;

    move-result-object v4

    :cond_5
    if-eqz v4, :cond_6

    iget-object v5, p0, Lcom/mg/ola/common/widget/IcsAbsSpinner;->j:Lcom/mg/ola/common/widget/IcsAbsSpinner$a;

    invoke-virtual {v5, v1, v4}, Lcom/mg/ola/common/widget/IcsAbsSpinner$a;->a(ILandroid/view/View;)V

    :cond_6
    if-eqz v4, :cond_8

    invoke-virtual {v4}, Landroid/view/View;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v1

    if-nez v1, :cond_7

    iput-boolean v2, p0, Lcom/mg/ola/common/widget/IcsAbsSpinner;->d:Z

    invoke-virtual {p0}, Lcom/mg/ola/common/widget/IcsAbsSpinner;->generateDefaultLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v1

    invoke-virtual {v4, v1}, Landroid/view/View;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    iput-boolean v3, p0, Lcom/mg/ola/common/widget/IcsAbsSpinner;->d:Z

    :cond_7
    invoke-virtual {p0, v4, p1, p2}, Lcom/mg/ola/common/widget/IcsAbsSpinner;->measureChild(Landroid/view/View;II)V

    invoke-virtual {p0, v4}, Lcom/mg/ola/common/widget/IcsAbsSpinner;->a(Landroid/view/View;)I

    move-result v1

    iget-object v2, p0, Lcom/mg/ola/common/widget/IcsAbsSpinner;->i:Landroid/graphics/Rect;

    iget v2, v2, Landroid/graphics/Rect;->top:I

    add-int/2addr v1, v2

    iget-object v2, p0, Lcom/mg/ola/common/widget/IcsAbsSpinner;->i:Landroid/graphics/Rect;

    iget v2, v2, Landroid/graphics/Rect;->bottom:I

    add-int/2addr v1, v2

    invoke-virtual {p0, v4}, Lcom/mg/ola/common/widget/IcsAbsSpinner;->b(Landroid/view/View;)I

    move-result v2

    iget-object v4, p0, Lcom/mg/ola/common/widget/IcsAbsSpinner;->i:Landroid/graphics/Rect;

    iget v4, v4, Landroid/graphics/Rect;->left:I

    add-int/2addr v2, v4

    iget-object v4, p0, Lcom/mg/ola/common/widget/IcsAbsSpinner;->i:Landroid/graphics/Rect;

    iget v4, v4, Landroid/graphics/Rect;->right:I

    add-int/2addr v2, v4

    move v4, v2

    const/4 v2, 0x0

    goto :goto_4

    :cond_8
    const/4 v1, 0x0

    const/4 v4, 0x0

    :goto_4
    if-eqz v2, :cond_9

    iget-object v1, p0, Lcom/mg/ola/common/widget/IcsAbsSpinner;->i:Landroid/graphics/Rect;

    iget v1, v1, Landroid/graphics/Rect;->top:I

    iget-object v2, p0, Lcom/mg/ola/common/widget/IcsAbsSpinner;->i:Landroid/graphics/Rect;

    iget v2, v2, Landroid/graphics/Rect;->bottom:I

    add-int/2addr v1, v2

    if-nez v0, :cond_9

    iget-object v0, p0, Lcom/mg/ola/common/widget/IcsAbsSpinner;->i:Landroid/graphics/Rect;

    iget v0, v0, Landroid/graphics/Rect;->left:I

    iget-object v2, p0, Lcom/mg/ola/common/widget/IcsAbsSpinner;->i:Landroid/graphics/Rect;

    iget v2, v2, Landroid/graphics/Rect;->right:I

    add-int v4, v0, v2

    :cond_9
    invoke-virtual {p0}, Lcom/mg/ola/common/widget/IcsAbsSpinner;->getSuggestedMinimumHeight()I

    move-result v0

    invoke-static {v1, v0}, Ljava/lang/Math;->max(II)I

    move-result v0

    invoke-virtual {p0}, Lcom/mg/ola/common/widget/IcsAbsSpinner;->getSuggestedMinimumWidth()I

    move-result v1

    invoke-static {v4, v1}, Ljava/lang/Math;->max(II)I

    move-result v1

    invoke-static {}, Lcom/mg/ola/common/d/g;->c()Z

    move-result v2

    if-eqz v2, :cond_a

    invoke-static {v0, p2, v3}, Lcom/mg/ola/common/widget/IcsAbsSpinner;->resolveSizeAndState(III)I

    move-result v0

    invoke-static {v1, p1, v3}, Lcom/mg/ola/common/widget/IcsAbsSpinner;->resolveSizeAndState(III)I

    move-result v1

    goto :goto_5

    :cond_a
    invoke-static {v0, p2}, Lcom/mg/ola/common/widget/IcsAbsSpinner;->resolveSize(II)I

    move-result v0

    invoke-static {v1, p1}, Lcom/mg/ola/common/widget/IcsAbsSpinner;->resolveSize(II)I

    move-result v1

    :goto_5
    invoke-virtual {p0, v1, v0}, Lcom/mg/ola/common/widget/IcsAbsSpinner;->setMeasuredDimension(II)V

    iput p2, p0, Lcom/mg/ola/common/widget/IcsAbsSpinner;->b:I

    iput p1, p0, Lcom/mg/ola/common/widget/IcsAbsSpinner;->c:I

    return-void
.end method

.method public onRestoreInstanceState(Landroid/os/Parcelable;)V
    .locals 5

    check-cast p1, Lcom/mg/ola/common/widget/IcsAbsSpinner$SavedState;

    invoke-virtual {p1}, Lcom/mg/ola/common/widget/IcsAbsSpinner$SavedState;->getSuperState()Landroid/os/Parcelable;

    move-result-object v0

    invoke-super {p0, v0}, Lcom/mg/ola/common/widget/a;->onRestoreInstanceState(Landroid/os/Parcelable;)V

    iget-wide v0, p1, Lcom/mg/ola/common/widget/IcsAbsSpinner$SavedState;->a:J

    const-wide/16 v2, 0x0

    cmp-long v4, v0, v2

    if-ltz v4, :cond_0

    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/mg/ola/common/widget/IcsAbsSpinner;->v:Z

    iput-boolean v0, p0, Lcom/mg/ola/common/widget/IcsAbsSpinner;->p:Z

    iget-wide v0, p1, Lcom/mg/ola/common/widget/IcsAbsSpinner$SavedState;->a:J

    iput-wide v0, p0, Lcom/mg/ola/common/widget/IcsAbsSpinner;->n:J

    iget p1, p1, Lcom/mg/ola/common/widget/IcsAbsSpinner$SavedState;->b:I

    iput p1, p0, Lcom/mg/ola/common/widget/IcsAbsSpinner;->m:I

    const/4 p1, 0x0

    iput p1, p0, Lcom/mg/ola/common/widget/IcsAbsSpinner;->q:I

    invoke-virtual {p0}, Lcom/mg/ola/common/widget/IcsAbsSpinner;->requestLayout()V

    :cond_0
    return-void
.end method

.method public onSaveInstanceState()Landroid/os/Parcelable;
    .locals 6

    invoke-super {p0}, Lcom/mg/ola/common/widget/a;->onSaveInstanceState()Landroid/os/Parcelable;

    move-result-object v0

    new-instance v1, Lcom/mg/ola/common/widget/IcsAbsSpinner$SavedState;

    invoke-direct {v1, v0}, Lcom/mg/ola/common/widget/IcsAbsSpinner$SavedState;-><init>(Landroid/os/Parcelable;)V

    invoke-virtual {p0}, Lcom/mg/ola/common/widget/IcsAbsSpinner;->getSelectedItemId()J

    move-result-wide v2

    iput-wide v2, v1, Lcom/mg/ola/common/widget/IcsAbsSpinner$SavedState;->a:J

    iget-wide v2, v1, Lcom/mg/ola/common/widget/IcsAbsSpinner$SavedState;->a:J

    const-wide/16 v4, 0x0

    cmp-long v0, v2, v4

    if-ltz v0, :cond_0

    invoke-virtual {p0}, Lcom/mg/ola/common/widget/IcsAbsSpinner;->getSelectedItemPosition()I

    move-result v0

    :goto_0
    iput v0, v1, Lcom/mg/ola/common/widget/IcsAbsSpinner$SavedState;->b:I

    return-object v1

    :cond_0
    const/4 v0, -0x1

    goto :goto_0

    return-object v1
.end method

.method public requestLayout()V
    .locals 1

    iget-boolean v0, p0, Lcom/mg/ola/common/widget/IcsAbsSpinner;->d:Z

    if-nez v0, :cond_0

    invoke-super {p0}, Lcom/mg/ola/common/widget/a;->requestLayout()V

    :cond_0
    return-void
.end method

.method public bridge synthetic setAdapter(Landroid/widget/Adapter;)V
    .locals 0

    check-cast p1, Landroid/widget/SpinnerAdapter;

    invoke-virtual {p0, p1}, Lcom/mg/ola/common/widget/IcsAbsSpinner;->setAdapter(Landroid/widget/SpinnerAdapter;)V

    return-void
.end method

.method public setAdapter(Landroid/widget/SpinnerAdapter;)V
    .locals 2

    iget-object v0, p0, Lcom/mg/ola/common/widget/IcsAbsSpinner;->a:Landroid/widget/SpinnerAdapter;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/mg/ola/common/widget/IcsAbsSpinner;->a:Landroid/widget/SpinnerAdapter;

    iget-object v1, p0, Lcom/mg/ola/common/widget/IcsAbsSpinner;->F:Landroid/database/DataSetObserver;

    invoke-interface {v0, v1}, Landroid/widget/SpinnerAdapter;->unregisterDataSetObserver(Landroid/database/DataSetObserver;)V

    invoke-virtual {p0}, Lcom/mg/ola/common/widget/IcsAbsSpinner;->a()V

    :cond_0
    iput-object p1, p0, Lcom/mg/ola/common/widget/IcsAbsSpinner;->a:Landroid/widget/SpinnerAdapter;

    const/4 p1, -0x1

    iput p1, p0, Lcom/mg/ola/common/widget/IcsAbsSpinner;->C:I

    const-wide/high16 v0, -0x8000000000000000L

    iput-wide v0, p0, Lcom/mg/ola/common/widget/IcsAbsSpinner;->D:J

    iget-object v0, p0, Lcom/mg/ola/common/widget/IcsAbsSpinner;->a:Landroid/widget/SpinnerAdapter;

    if-eqz v0, :cond_2

    iget v0, p0, Lcom/mg/ola/common/widget/IcsAbsSpinner;->A:I

    iput v0, p0, Lcom/mg/ola/common/widget/IcsAbsSpinner;->B:I

    iget-object v0, p0, Lcom/mg/ola/common/widget/IcsAbsSpinner;->a:Landroid/widget/SpinnerAdapter;

    invoke-interface {v0}, Landroid/widget/SpinnerAdapter;->getCount()I

    move-result v0

    iput v0, p0, Lcom/mg/ola/common/widget/IcsAbsSpinner;->A:I

    invoke-virtual {p0}, Lcom/mg/ola/common/widget/IcsAbsSpinner;->c()V

    new-instance v0, Lcom/mg/ola/common/widget/a$a;

    invoke-direct {v0, p0}, Lcom/mg/ola/common/widget/a$a;-><init>(Lcom/mg/ola/common/widget/a;)V

    iput-object v0, p0, Lcom/mg/ola/common/widget/IcsAbsSpinner;->F:Landroid/database/DataSetObserver;

    iget-object v0, p0, Lcom/mg/ola/common/widget/IcsAbsSpinner;->a:Landroid/widget/SpinnerAdapter;

    iget-object v1, p0, Lcom/mg/ola/common/widget/IcsAbsSpinner;->F:Landroid/database/DataSetObserver;

    invoke-interface {v0, v1}, Landroid/widget/SpinnerAdapter;->registerDataSetObserver(Landroid/database/DataSetObserver;)V

    iget v0, p0, Lcom/mg/ola/common/widget/IcsAbsSpinner;->A:I

    if-lez v0, :cond_1

    const/4 p1, 0x0

    :cond_1
    invoke-virtual {p0, p1}, Lcom/mg/ola/common/widget/IcsAbsSpinner;->setSelectedPositionInt(I)V

    invoke-virtual {p0, p1}, Lcom/mg/ola/common/widget/IcsAbsSpinner;->setNextSelectedPositionInt(I)V

    iget p1, p0, Lcom/mg/ola/common/widget/IcsAbsSpinner;->A:I

    if-nez p1, :cond_3

    goto :goto_0

    :cond_2
    invoke-virtual {p0}, Lcom/mg/ola/common/widget/IcsAbsSpinner;->c()V

    invoke-virtual {p0}, Lcom/mg/ola/common/widget/IcsAbsSpinner;->a()V

    :goto_0
    invoke-virtual {p0}, Lcom/mg/ola/common/widget/IcsAbsSpinner;->f()V

    :cond_3
    invoke-virtual {p0}, Lcom/mg/ola/common/widget/IcsAbsSpinner;->requestLayout()V

    return-void
.end method

.method public setSelection(I)V
    .locals 0

    invoke-virtual {p0, p1}, Lcom/mg/ola/common/widget/IcsAbsSpinner;->setNextSelectedPositionInt(I)V

    invoke-virtual {p0}, Lcom/mg/ola/common/widget/IcsAbsSpinner;->requestLayout()V

    invoke-virtual {p0}, Lcom/mg/ola/common/widget/IcsAbsSpinner;->invalidate()V

    return-void
.end method

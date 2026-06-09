.class public Lit/sephiroth/android/library/widget/AbsHListView$j;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lit/sephiroth/android/library/widget/AbsHListView;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1
    name = "j"
.end annotation


# instance fields
.field final synthetic a:Lit/sephiroth/android/library/widget/AbsHListView;

.field private b:I

.field private c:I

.field private d:I

.field private e:I

.field private f:I

.field private final g:I

.field private h:I


# direct methods
.method constructor <init>(Lit/sephiroth/android/library/widget/AbsHListView;)V
    .locals 0

    iput-object p1, p0, Lit/sephiroth/android/library/widget/AbsHListView$j;->a:Lit/sephiroth/android/library/widget/AbsHListView;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    invoke-virtual {p1}, Lit/sephiroth/android/library/widget/AbsHListView;->getContext()Landroid/content/Context;

    move-result-object p1

    invoke-static {p1}, Landroid/view/ViewConfiguration;->get(Landroid/content/Context;)Landroid/view/ViewConfiguration;

    move-result-object p1

    invoke-virtual {p1}, Landroid/view/ViewConfiguration;->getScaledFadingEdgeLength()I

    move-result p1

    iput p1, p0, Lit/sephiroth/android/library/widget/AbsHListView$j;->g:I

    return-void
.end method


# virtual methods
.method public a()V
    .locals 1

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView$j;->a:Lit/sephiroth/android/library/widget/AbsHListView;

    invoke-virtual {v0, p0}, Lit/sephiroth/android/library/widget/AbsHListView;->removeCallbacks(Ljava/lang/Runnable;)Z

    return-void
.end method

.method a(I)V
    .locals 5

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView$j;->a()V

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView$j;->a:Lit/sephiroth/android/library/widget/AbsHListView;

    iget-boolean v0, v0, Lit/sephiroth/android/library/widget/AbsHListView;->aj:Z

    if-eqz v0, :cond_0

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView$j;->a:Lit/sephiroth/android/library/widget/AbsHListView;

    new-instance v1, Lit/sephiroth/android/library/widget/AbsHListView$j$1;

    invoke-direct {v1, p0, p1}, Lit/sephiroth/android/library/widget/AbsHListView$j$1;-><init>(Lit/sephiroth/android/library/widget/AbsHListView$j;I)V

    iput-object v1, v0, Lit/sephiroth/android/library/widget/AbsHListView;->O:Ljava/lang/Runnable;

    return-void

    :cond_0
    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView$j;->a:Lit/sephiroth/android/library/widget/AbsHListView;

    invoke-virtual {v0}, Lit/sephiroth/android/library/widget/AbsHListView;->getChildCount()I

    move-result v0

    if-nez v0, :cond_1

    return-void

    :cond_1
    iget-object v1, p0, Lit/sephiroth/android/library/widget/AbsHListView$j;->a:Lit/sephiroth/android/library/widget/AbsHListView;

    iget v1, v1, Lit/sephiroth/android/library/widget/AbsHListView;->V:I

    add-int/2addr v0, v1

    const/4 v2, 0x1

    sub-int/2addr v0, v2

    const/4 v3, 0x0

    iget-object v4, p0, Lit/sephiroth/android/library/widget/AbsHListView$j;->a:Lit/sephiroth/android/library/widget/AbsHListView;

    invoke-virtual {v4}, Lit/sephiroth/android/library/widget/AbsHListView;->getCount()I

    move-result v4

    sub-int/2addr v4, v2

    invoke-static {v4, p1}, Ljava/lang/Math;->min(II)I

    move-result p1

    invoke-static {v3, p1}, Ljava/lang/Math;->max(II)I

    move-result p1

    const/4 v3, -0x1

    const/16 v4, 0xc8

    if-ge p1, v1, :cond_2

    sub-int/2addr v1, p1

    add-int/2addr v1, v2

    const/4 v0, 0x2

    iput v0, p0, Lit/sephiroth/android/library/widget/AbsHListView$j;->b:I

    goto :goto_0

    :cond_2
    if-le p1, v0, :cond_4

    sub-int v0, p1, v0

    add-int/lit8 v1, v0, 0x1

    iput v2, p0, Lit/sephiroth/android/library/widget/AbsHListView$j;->b:I

    :goto_0
    if-lez v1, :cond_3

    div-int/2addr v4, v1

    :cond_3
    iput v4, p0, Lit/sephiroth/android/library/widget/AbsHListView$j;->f:I

    iput p1, p0, Lit/sephiroth/android/library/widget/AbsHListView$j;->c:I

    iput v3, p0, Lit/sephiroth/android/library/widget/AbsHListView$j;->d:I

    iput v3, p0, Lit/sephiroth/android/library/widget/AbsHListView$j;->e:I

    iget-object p1, p0, Lit/sephiroth/android/library/widget/AbsHListView$j;->a:Lit/sephiroth/android/library/widget/AbsHListView;

    iget-object p1, p1, Lit/sephiroth/android/library/widget/AbsHListView;->a:Lit/sephiroth/android/library/a/a$a;

    invoke-virtual {p1, p0}, Lit/sephiroth/android/library/a/a$a;->a(Ljava/lang/Runnable;)V

    return-void

    :cond_4
    invoke-virtual {p0, p1, v3, v4}, Lit/sephiroth/android/library/widget/AbsHListView$j;->a(III)V

    return-void
.end method

.method a(III)V
    .locals 7

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView$j;->a:Lit/sephiroth/android/library/widget/AbsHListView;

    iget v0, v0, Lit/sephiroth/android/library/widget/AbsHListView;->V:I

    iget-object v1, p0, Lit/sephiroth/android/library/widget/AbsHListView$j;->a:Lit/sephiroth/android/library/widget/AbsHListView;

    invoke-virtual {v1}, Lit/sephiroth/android/library/widget/AbsHListView;->getChildCount()I

    move-result v1

    add-int/2addr v1, v0

    add-int/lit8 v1, v1, -0x1

    iget-object v2, p0, Lit/sephiroth/android/library/widget/AbsHListView$j;->a:Lit/sephiroth/android/library/widget/AbsHListView;

    iget-object v2, v2, Lit/sephiroth/android/library/widget/AbsHListView;->u:Landroid/graphics/Rect;

    iget v2, v2, Landroid/graphics/Rect;->left:I

    iget-object v3, p0, Lit/sephiroth/android/library/widget/AbsHListView$j;->a:Lit/sephiroth/android/library/widget/AbsHListView;

    invoke-virtual {v3}, Lit/sephiroth/android/library/widget/AbsHListView;->getWidth()I

    move-result v3

    iget-object v4, p0, Lit/sephiroth/android/library/widget/AbsHListView$j;->a:Lit/sephiroth/android/library/widget/AbsHListView;

    iget-object v4, v4, Lit/sephiroth/android/library/widget/AbsHListView;->u:Landroid/graphics/Rect;

    iget v4, v4, Landroid/graphics/Rect;->right:I

    sub-int/2addr v3, v4

    if-lt p1, v0, :cond_0

    if-le p1, v1, :cond_1

    :cond_0
    const-string v4, "AbsListView"

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "scrollToVisible called with targetPos "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v5, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v6, " not visible ["

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v5, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v6, ", "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v5, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v6, "]"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    :cond_1
    if-lt p2, v0, :cond_2

    if-le p2, v1, :cond_3

    :cond_2
    const/4 p2, -0x1

    :cond_3
    iget-object v1, p0, Lit/sephiroth/android/library/widget/AbsHListView$j;->a:Lit/sephiroth/android/library/widget/AbsHListView;

    sub-int/2addr p1, v0

    invoke-virtual {v1, p1}, Lit/sephiroth/android/library/widget/AbsHListView;->getChildAt(I)Landroid/view/View;

    move-result-object p1

    invoke-virtual {p1}, Landroid/view/View;->getLeft()I

    move-result v1

    invoke-virtual {p1}, Landroid/view/View;->getRight()I

    move-result p1

    const/4 v4, 0x0

    if-le p1, v3, :cond_4

    sub-int/2addr p1, v3

    goto :goto_0

    :cond_4
    const/4 p1, 0x0

    :goto_0
    if-ge v1, v2, :cond_5

    sub-int p1, v1, v2

    :cond_5
    if-nez p1, :cond_6

    return-void

    :cond_6
    if-ltz p2, :cond_8

    iget-object v1, p0, Lit/sephiroth/android/library/widget/AbsHListView$j;->a:Lit/sephiroth/android/library/widget/AbsHListView;

    sub-int/2addr p2, v0

    invoke-virtual {v1, p2}, Lit/sephiroth/android/library/widget/AbsHListView;->getChildAt(I)Landroid/view/View;

    move-result-object p2

    invoke-virtual {p2}, Landroid/view/View;->getLeft()I

    move-result v0

    invoke-virtual {p2}, Landroid/view/View;->getRight()I

    move-result p2

    invoke-static {p1}, Ljava/lang/Math;->abs(I)I

    move-result v1

    if-gez p1, :cond_7

    add-int v5, p2, v1

    if-le v5, v3, :cond_7

    sub-int/2addr p2, v3

    invoke-static {v4, p2}, Ljava/lang/Math;->max(II)I

    move-result p1

    goto :goto_1

    :cond_7
    if-lez p1, :cond_8

    sub-int p2, v0, v1

    if-ge p2, v2, :cond_8

    sub-int/2addr v0, v2

    invoke-static {v4, v0}, Ljava/lang/Math;->min(II)I

    move-result p1

    :cond_8
    :goto_1
    iget-object p2, p0, Lit/sephiroth/android/library/widget/AbsHListView$j;->a:Lit/sephiroth/android/library/widget/AbsHListView;

    invoke-virtual {p2, p1, p3}, Lit/sephiroth/android/library/widget/AbsHListView;->b(II)V

    return-void
.end method

.method public run()V
    .locals 8

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView$j;->a:Lit/sephiroth/android/library/widget/AbsHListView;

    invoke-virtual {v0}, Lit/sephiroth/android/library/widget/AbsHListView;->getWidth()I

    move-result v0

    iget-object v1, p0, Lit/sephiroth/android/library/widget/AbsHListView$j;->a:Lit/sephiroth/android/library/widget/AbsHListView;

    iget v1, v1, Lit/sephiroth/android/library/widget/AbsHListView;->V:I

    iget v2, p0, Lit/sephiroth/android/library/widget/AbsHListView$j;->b:I

    const/4 v3, 0x0

    const/4 v4, 0x1

    packed-switch v2, :pswitch_data_0

    return-void

    :pswitch_0
    iget v0, p0, Lit/sephiroth/android/library/widget/AbsHListView$j;->e:I

    if-ne v0, v1, :cond_0

    :goto_0
    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView$j;->a:Lit/sephiroth/android/library/widget/AbsHListView;

    iget-object v0, v0, Lit/sephiroth/android/library/widget/AbsHListView;->a:Lit/sephiroth/android/library/a/a$a;

    invoke-virtual {v0, p0}, Lit/sephiroth/android/library/a/a$a;->a(Ljava/lang/Runnable;)V

    return-void

    :cond_0
    iput v1, p0, Lit/sephiroth/android/library/widget/AbsHListView$j;->e:I

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView$j;->a:Lit/sephiroth/android/library/widget/AbsHListView;

    invoke-virtual {v0}, Lit/sephiroth/android/library/widget/AbsHListView;->getChildCount()I

    move-result v0

    iget v2, p0, Lit/sephiroth/android/library/widget/AbsHListView$j;->c:I

    add-int v5, v1, v0

    sub-int/2addr v5, v4

    if-ge v2, v1, :cond_1

    sub-int v3, v1, v2

    add-int/2addr v3, v4

    goto :goto_1

    :cond_1
    if-le v2, v5, :cond_2

    sub-int v3, v2, v5

    :cond_2
    :goto_1
    int-to-float v3, v3

    int-to-float v0, v0

    div-float/2addr v3, v0

    invoke-static {v3}, Ljava/lang/Math;->abs(F)F

    move-result v0

    const/high16 v3, 0x3f800000    # 1.0f

    invoke-static {v0, v3}, Ljava/lang/Math;->min(FF)F

    move-result v0

    if-ge v2, v1, :cond_3

    iget-object v1, p0, Lit/sephiroth/android/library/widget/AbsHListView$j;->a:Lit/sephiroth/android/library/widget/AbsHListView;

    invoke-virtual {v1}, Lit/sephiroth/android/library/widget/AbsHListView;->getWidth()I

    move-result v1

    neg-int v1, v1

    :goto_2
    int-to-float v1, v1

    mul-float v1, v1, v0

    float-to-int v1, v1

    iget v2, p0, Lit/sephiroth/android/library/widget/AbsHListView$j;->f:I

    int-to-float v2, v2

    mul-float v2, v2, v0

    float-to-int v0, v2

    iget-object v2, p0, Lit/sephiroth/android/library/widget/AbsHListView$j;->a:Lit/sephiroth/android/library/widget/AbsHListView;

    invoke-virtual {v2, v1, v0, v4}, Lit/sephiroth/android/library/widget/AbsHListView;->a(IIZ)V

    goto :goto_3

    :cond_3
    if-le v2, v5, :cond_4

    iget-object v1, p0, Lit/sephiroth/android/library/widget/AbsHListView$j;->a:Lit/sephiroth/android/library/widget/AbsHListView;

    invoke-virtual {v1}, Lit/sephiroth/android/library/widget/AbsHListView;->getWidth()I

    move-result v1

    goto :goto_2

    :cond_4
    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView$j;->a:Lit/sephiroth/android/library/widget/AbsHListView;

    sub-int/2addr v2, v1

    invoke-virtual {v0, v2}, Lit/sephiroth/android/library/widget/AbsHListView;->getChildAt(I)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0}, Landroid/view/View;->getLeft()I

    move-result v0

    iget v1, p0, Lit/sephiroth/android/library/widget/AbsHListView$j;->h:I

    sub-int/2addr v0, v1

    iget v1, p0, Lit/sephiroth/android/library/widget/AbsHListView$j;->f:I

    int-to-float v1, v1

    invoke-static {v0}, Ljava/lang/Math;->abs(I)I

    move-result v2

    int-to-float v2, v2

    iget-object v3, p0, Lit/sephiroth/android/library/widget/AbsHListView$j;->a:Lit/sephiroth/android/library/widget/AbsHListView;

    invoke-virtual {v3}, Lit/sephiroth/android/library/widget/AbsHListView;->getWidth()I

    move-result v3

    int-to-float v3, v3

    div-float/2addr v2, v3

    mul-float v1, v1, v2

    float-to-int v1, v1

    iget-object v2, p0, Lit/sephiroth/android/library/widget/AbsHListView$j;->a:Lit/sephiroth/android/library/widget/AbsHListView;

    invoke-virtual {v2, v0, v1, v4}, Lit/sephiroth/android/library/widget/AbsHListView;->a(IIZ)V

    return-void

    :pswitch_1
    iget-object v2, p0, Lit/sephiroth/android/library/widget/AbsHListView$j;->a:Lit/sephiroth/android/library/widget/AbsHListView;

    invoke-virtual {v2}, Lit/sephiroth/android/library/widget/AbsHListView;->getChildCount()I

    move-result v2

    add-int/lit8 v2, v2, -0x2

    if-gez v2, :cond_5

    return-void

    :cond_5
    add-int/2addr v1, v2

    iget v3, p0, Lit/sephiroth/android/library/widget/AbsHListView$j;->e:I

    if-ne v1, v3, :cond_6

    goto/16 :goto_0

    :cond_6
    iget-object v3, p0, Lit/sephiroth/android/library/widget/AbsHListView$j;->a:Lit/sephiroth/android/library/widget/AbsHListView;

    invoke-virtual {v3, v2}, Lit/sephiroth/android/library/widget/AbsHListView;->getChildAt(I)Landroid/view/View;

    move-result-object v2

    invoke-virtual {v2}, Landroid/view/View;->getWidth()I

    move-result v3

    invoke-virtual {v2}, Landroid/view/View;->getLeft()I

    move-result v2

    sub-int v5, v0, v2

    iget-object v6, p0, Lit/sephiroth/android/library/widget/AbsHListView$j;->a:Lit/sephiroth/android/library/widget/AbsHListView;

    iget-object v6, v6, Lit/sephiroth/android/library/widget/AbsHListView;->u:Landroid/graphics/Rect;

    iget v6, v6, Landroid/graphics/Rect;->left:I

    iget v7, p0, Lit/sephiroth/android/library/widget/AbsHListView$j;->g:I

    invoke-static {v6, v7}, Ljava/lang/Math;->max(II)I

    move-result v6

    iput v1, p0, Lit/sephiroth/android/library/widget/AbsHListView$j;->e:I

    iget v7, p0, Lit/sephiroth/android/library/widget/AbsHListView$j;->d:I

    if-le v1, v7, :cond_7

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView$j;->a:Lit/sephiroth/android/library/widget/AbsHListView;

    sub-int/2addr v5, v6

    neg-int v1, v5

    iget v2, p0, Lit/sephiroth/android/library/widget/AbsHListView$j;->f:I

    invoke-virtual {v0, v1, v2, v4}, Lit/sephiroth/android/library/widget/AbsHListView;->a(IIZ)V

    :goto_3
    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView$j;->a:Lit/sephiroth/android/library/widget/AbsHListView;

    iget-object v0, v0, Lit/sephiroth/android/library/widget/AbsHListView;->a:Lit/sephiroth/android/library/a/a$a;

    invoke-virtual {v0, p0}, Lit/sephiroth/android/library/a/a$a;->a(Ljava/lang/Runnable;)V

    return-void

    :cond_7
    sub-int/2addr v0, v6

    add-int/2addr v2, v3

    if-le v0, v2, :cond_12

    iget-object v1, p0, Lit/sephiroth/android/library/widget/AbsHListView$j;->a:Lit/sephiroth/android/library/widget/AbsHListView;

    sub-int/2addr v0, v2

    neg-int v0, v0

    goto :goto_4

    :pswitch_2
    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView$j;->a:Lit/sephiroth/android/library/widget/AbsHListView;

    invoke-virtual {v0}, Lit/sephiroth/android/library/widget/AbsHListView;->getChildCount()I

    move-result v0

    iget v2, p0, Lit/sephiroth/android/library/widget/AbsHListView$j;->d:I

    if-eq v1, v2, :cond_b

    if-le v0, v4, :cond_b

    add-int/2addr v0, v1

    iget-object v2, p0, Lit/sephiroth/android/library/widget/AbsHListView$j;->a:Lit/sephiroth/android/library/widget/AbsHListView;

    iget v2, v2, Lit/sephiroth/android/library/widget/AbsHListView;->ao:I

    if-lt v0, v2, :cond_8

    return-void

    :cond_8
    add-int/2addr v1, v4

    iget v0, p0, Lit/sephiroth/android/library/widget/AbsHListView$j;->e:I

    if-ne v1, v0, :cond_9

    goto/16 :goto_0

    :cond_9
    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView$j;->a:Lit/sephiroth/android/library/widget/AbsHListView;

    invoke-virtual {v0, v4}, Lit/sephiroth/android/library/widget/AbsHListView;->getChildAt(I)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0}, Landroid/view/View;->getWidth()I

    move-result v2

    invoke-virtual {v0}, Landroid/view/View;->getLeft()I

    move-result v0

    iget-object v5, p0, Lit/sephiroth/android/library/widget/AbsHListView$j;->a:Lit/sephiroth/android/library/widget/AbsHListView;

    iget-object v5, v5, Lit/sephiroth/android/library/widget/AbsHListView;->u:Landroid/graphics/Rect;

    iget v5, v5, Landroid/graphics/Rect;->right:I

    iget v6, p0, Lit/sephiroth/android/library/widget/AbsHListView$j;->g:I

    invoke-static {v5, v6}, Ljava/lang/Math;->max(II)I

    move-result v5

    iget v6, p0, Lit/sephiroth/android/library/widget/AbsHListView$j;->d:I

    if-ge v1, v6, :cond_a

    iget-object v6, p0, Lit/sephiroth/android/library/widget/AbsHListView$j;->a:Lit/sephiroth/android/library/widget/AbsHListView;

    add-int/2addr v2, v0

    sub-int/2addr v2, v5

    invoke-static {v3, v2}, Ljava/lang/Math;->max(II)I

    move-result v0

    iget v2, p0, Lit/sephiroth/android/library/widget/AbsHListView$j;->f:I

    invoke-virtual {v6, v0, v2, v4}, Lit/sephiroth/android/library/widget/AbsHListView;->a(IIZ)V

    iput v1, p0, Lit/sephiroth/android/library/widget/AbsHListView$j;->e:I

    goto :goto_3

    :cond_a
    if-le v0, v5, :cond_12

    iget-object v1, p0, Lit/sephiroth/android/library/widget/AbsHListView$j;->a:Lit/sephiroth/android/library/widget/AbsHListView;

    sub-int/2addr v0, v5

    :goto_4
    iget v2, p0, Lit/sephiroth/android/library/widget/AbsHListView$j;->f:I

    invoke-virtual {v1, v0, v2, v4}, Lit/sephiroth/android/library/widget/AbsHListView;->a(IIZ)V

    return-void

    :cond_b
    return-void

    :pswitch_3
    iget v0, p0, Lit/sephiroth/android/library/widget/AbsHListView$j;->e:I

    if-ne v1, v0, :cond_c

    goto/16 :goto_0

    :cond_c
    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView$j;->a:Lit/sephiroth/android/library/widget/AbsHListView;

    invoke-virtual {v0, v3}, Lit/sephiroth/android/library/widget/AbsHListView;->getChildAt(I)Landroid/view/View;

    move-result-object v0

    if-nez v0, :cond_d

    return-void

    :cond_d
    invoke-virtual {v0}, Landroid/view/View;->getLeft()I

    move-result v0

    if-lez v1, :cond_e

    iget v2, p0, Lit/sephiroth/android/library/widget/AbsHListView$j;->g:I

    iget-object v3, p0, Lit/sephiroth/android/library/widget/AbsHListView$j;->a:Lit/sephiroth/android/library/widget/AbsHListView;

    iget-object v3, v3, Lit/sephiroth/android/library/widget/AbsHListView;->u:Landroid/graphics/Rect;

    iget v3, v3, Landroid/graphics/Rect;->left:I

    invoke-static {v2, v3}, Ljava/lang/Math;->max(II)I

    move-result v2

    goto :goto_5

    :cond_e
    iget-object v2, p0, Lit/sephiroth/android/library/widget/AbsHListView$j;->a:Lit/sephiroth/android/library/widget/AbsHListView;

    iget-object v2, v2, Lit/sephiroth/android/library/widget/AbsHListView;->u:Landroid/graphics/Rect;

    iget v2, v2, Landroid/graphics/Rect;->left:I

    :goto_5
    iget-object v3, p0, Lit/sephiroth/android/library/widget/AbsHListView$j;->a:Lit/sephiroth/android/library/widget/AbsHListView;

    sub-int/2addr v0, v2

    iget v2, p0, Lit/sephiroth/android/library/widget/AbsHListView$j;->f:I

    invoke-virtual {v3, v0, v2, v4}, Lit/sephiroth/android/library/widget/AbsHListView;->a(IIZ)V

    iput v1, p0, Lit/sephiroth/android/library/widget/AbsHListView$j;->e:I

    iget v0, p0, Lit/sephiroth/android/library/widget/AbsHListView$j;->c:I

    if-le v1, v0, :cond_12

    goto :goto_7

    :pswitch_4
    iget-object v2, p0, Lit/sephiroth/android/library/widget/AbsHListView$j;->a:Lit/sephiroth/android/library/widget/AbsHListView;

    invoke-virtual {v2}, Lit/sephiroth/android/library/widget/AbsHListView;->getChildCount()I

    move-result v2

    sub-int/2addr v2, v4

    add-int/2addr v1, v2

    if-gez v2, :cond_f

    return-void

    :cond_f
    iget v3, p0, Lit/sephiroth/android/library/widget/AbsHListView$j;->e:I

    if-ne v1, v3, :cond_10

    goto/16 :goto_0

    :cond_10
    iget-object v3, p0, Lit/sephiroth/android/library/widget/AbsHListView$j;->a:Lit/sephiroth/android/library/widget/AbsHListView;

    invoke-virtual {v3, v2}, Lit/sephiroth/android/library/widget/AbsHListView;->getChildAt(I)Landroid/view/View;

    move-result-object v2

    invoke-virtual {v2}, Landroid/view/View;->getWidth()I

    move-result v3

    invoke-virtual {v2}, Landroid/view/View;->getLeft()I

    move-result v2

    sub-int/2addr v0, v2

    iget-object v2, p0, Lit/sephiroth/android/library/widget/AbsHListView$j;->a:Lit/sephiroth/android/library/widget/AbsHListView;

    iget v2, v2, Lit/sephiroth/android/library/widget/AbsHListView;->ao:I

    sub-int/2addr v2, v4

    if-ge v1, v2, :cond_11

    iget-object v2, p0, Lit/sephiroth/android/library/widget/AbsHListView$j;->a:Lit/sephiroth/android/library/widget/AbsHListView;

    iget-object v2, v2, Lit/sephiroth/android/library/widget/AbsHListView;->u:Landroid/graphics/Rect;

    iget v2, v2, Landroid/graphics/Rect;->right:I

    iget v5, p0, Lit/sephiroth/android/library/widget/AbsHListView$j;->g:I

    invoke-static {v2, v5}, Ljava/lang/Math;->max(II)I

    move-result v2

    goto :goto_6

    :cond_11
    iget-object v2, p0, Lit/sephiroth/android/library/widget/AbsHListView$j;->a:Lit/sephiroth/android/library/widget/AbsHListView;

    iget-object v2, v2, Lit/sephiroth/android/library/widget/AbsHListView;->u:Landroid/graphics/Rect;

    iget v2, v2, Landroid/graphics/Rect;->right:I

    :goto_6
    sub-int/2addr v3, v0

    add-int/2addr v3, v2

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView$j;->a:Lit/sephiroth/android/library/widget/AbsHListView;

    iget v2, p0, Lit/sephiroth/android/library/widget/AbsHListView$j;->f:I

    invoke-virtual {v0, v3, v2, v4}, Lit/sephiroth/android/library/widget/AbsHListView;->a(IIZ)V

    iput v1, p0, Lit/sephiroth/android/library/widget/AbsHListView$j;->e:I

    iget v0, p0, Lit/sephiroth/android/library/widget/AbsHListView$j;->c:I

    if-ge v1, v0, :cond_12

    :goto_7
    goto/16 :goto_3

    :cond_12
    return-void

    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_4
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

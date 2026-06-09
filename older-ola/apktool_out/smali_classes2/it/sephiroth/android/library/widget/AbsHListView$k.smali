.class public Lit/sephiroth/android/library/widget/AbsHListView$k;
.super Ljava/lang/Object;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lit/sephiroth/android/library/widget/AbsHListView;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1
    name = "k"
.end annotation


# instance fields
.field final synthetic a:Lit/sephiroth/android/library/widget/AbsHListView;

.field private b:Lit/sephiroth/android/library/widget/AbsHListView$l;

.field private c:I

.field private d:[Landroid/view/View;

.field private e:[Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "[",
            "Ljava/util/ArrayList<",
            "Landroid/view/View;",
            ">;"
        }
    .end annotation
.end field

.field private f:I

.field private g:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList<",
            "Landroid/view/View;",
            ">;"
        }
    .end annotation
.end field

.field private h:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList<",
            "Landroid/view/View;",
            ">;"
        }
    .end annotation
.end field

.field private i:Landroid/support/v4/util/SparseArrayCompat;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Landroid/support/v4/util/SparseArrayCompat<",
            "Landroid/view/View;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method public constructor <init>(Lit/sephiroth/android/library/widget/AbsHListView;)V
    .locals 0

    iput-object p1, p0, Lit/sephiroth/android/library/widget/AbsHListView$k;->a:Lit/sephiroth/android/library/widget/AbsHListView;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 p1, 0x0

    new-array p1, p1, [Landroid/view/View;

    iput-object p1, p0, Lit/sephiroth/android/library/widget/AbsHListView$k;->d:[Landroid/view/View;

    return-void
.end method

.method static synthetic a(Lit/sephiroth/android/library/widget/AbsHListView$k;Lit/sephiroth/android/library/widget/AbsHListView$l;)Lit/sephiroth/android/library/widget/AbsHListView$l;
    .locals 0

    iput-object p1, p0, Lit/sephiroth/android/library/widget/AbsHListView$k;->b:Lit/sephiroth/android/library/widget/AbsHListView$l;

    return-object p1
.end method

.method private f()V
    .locals 11
    .annotation build Landroid/annotation/SuppressLint;
        value = {
            "NewApi"
        }
    .end annotation

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView$k;->d:[Landroid/view/View;

    array-length v0, v0

    iget v1, p0, Lit/sephiroth/android/library/widget/AbsHListView$k;->f:I

    iget-object v2, p0, Lit/sephiroth/android/library/widget/AbsHListView$k;->e:[Ljava/util/ArrayList;

    const/4 v3, 0x0

    const/4 v4, 0x0

    :goto_0
    if-ge v4, v1, :cond_1

    aget-object v5, v2, v4

    invoke-virtual {v5}, Ljava/util/ArrayList;->size()I

    move-result v6

    sub-int v7, v6, v0

    add-int/lit8 v6, v6, -0x1

    move v8, v6

    const/4 v6, 0x0

    :goto_1
    if-ge v6, v7, :cond_0

    iget-object v9, p0, Lit/sephiroth/android/library/widget/AbsHListView$k;->a:Lit/sephiroth/android/library/widget/AbsHListView;

    add-int/lit8 v10, v8, -0x1

    invoke-virtual {v5, v8}, Ljava/util/ArrayList;->remove(I)Ljava/lang/Object;

    move-result-object v8

    check-cast v8, Landroid/view/View;

    invoke-static {v9, v8, v3}, Lit/sephiroth/android/library/widget/AbsHListView;->e(Lit/sephiroth/android/library/widget/AbsHListView;Landroid/view/View;Z)V

    add-int/lit8 v6, v6, 0x1

    move v8, v10

    goto :goto_1

    :cond_0
    add-int/lit8 v4, v4, 0x1

    goto :goto_0

    :cond_1
    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView$k;->i:Landroid/support/v4/util/SparseArrayCompat;

    if-eqz v0, :cond_3

    :goto_2
    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView$k;->i:Landroid/support/v4/util/SparseArrayCompat;

    invoke-virtual {v0}, Landroid/support/v4/util/SparseArrayCompat;->size()I

    move-result v0

    if-ge v3, v0, :cond_3

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView$k;->i:Landroid/support/v4/util/SparseArrayCompat;

    invoke-virtual {v0, v3}, Landroid/support/v4/util/SparseArrayCompat;->valueAt(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/view/View;

    invoke-virtual {v0}, Landroid/view/View;->hasTransientState()Z

    move-result v0

    if-nez v0, :cond_2

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView$k;->i:Landroid/support/v4/util/SparseArrayCompat;

    invoke-virtual {v0, v3}, Landroid/support/v4/util/SparseArrayCompat;->removeAt(I)V

    add-int/lit8 v3, v3, -0x1

    :cond_2
    add-int/lit8 v3, v3, 0x1

    goto :goto_2

    :cond_3
    return-void
.end method


# virtual methods
.method public a()V
    .locals 7

    iget v0, p0, Lit/sephiroth/android/library/widget/AbsHListView$k;->f:I

    const/4 v1, 0x0

    const/4 v2, 0x1

    if-ne v0, v2, :cond_0

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView$k;->g:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v2

    const/4 v3, 0x0

    :goto_0
    if-ge v3, v2, :cond_2

    invoke-virtual {v0, v3}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Landroid/view/View;

    invoke-virtual {v4}, Landroid/view/View;->forceLayout()V

    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    :cond_0
    iget v0, p0, Lit/sephiroth/android/library/widget/AbsHListView$k;->f:I

    const/4 v2, 0x0

    :goto_1
    if-ge v2, v0, :cond_2

    iget-object v3, p0, Lit/sephiroth/android/library/widget/AbsHListView$k;->e:[Ljava/util/ArrayList;

    aget-object v3, v3, v2

    invoke-virtual {v3}, Ljava/util/ArrayList;->size()I

    move-result v4

    const/4 v5, 0x0

    :goto_2
    if-ge v5, v4, :cond_1

    invoke-virtual {v3, v5}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Landroid/view/View;

    invoke-virtual {v6}, Landroid/view/View;->forceLayout()V

    add-int/lit8 v5, v5, 0x1

    goto :goto_2

    :cond_1
    add-int/lit8 v2, v2, 0x1

    goto :goto_1

    :cond_2
    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView$k;->i:Landroid/support/v4/util/SparseArrayCompat;

    if-eqz v0, :cond_3

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView$k;->i:Landroid/support/v4/util/SparseArrayCompat;

    invoke-virtual {v0}, Landroid/support/v4/util/SparseArrayCompat;->size()I

    move-result v0

    :goto_3
    if-ge v1, v0, :cond_3

    iget-object v2, p0, Lit/sephiroth/android/library/widget/AbsHListView$k;->i:Landroid/support/v4/util/SparseArrayCompat;

    invoke-virtual {v2, v1}, Landroid/support/v4/util/SparseArrayCompat;->valueAt(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Landroid/view/View;

    invoke-virtual {v2}, Landroid/view/View;->forceLayout()V

    add-int/lit8 v1, v1, 0x1

    goto :goto_3

    :cond_3
    return-void
.end method

.method public a(I)V
    .locals 4

    const/4 v0, 0x1

    if-ge p1, v0, :cond_0

    new-instance p1, Ljava/lang/IllegalArgumentException;

    const-string v0, "Can\'t have a viewTypeCount < 1"

    invoke-direct {p1, v0}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p1

    :cond_0
    new-array v0, p1, [Ljava/util/ArrayList;

    const/4 v1, 0x0

    const/4 v2, 0x0

    :goto_0
    if-ge v2, p1, :cond_1

    new-instance v3, Ljava/util/ArrayList;

    invoke-direct {v3}, Ljava/util/ArrayList;-><init>()V

    aput-object v3, v0, v2

    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    :cond_1
    iput p1, p0, Lit/sephiroth/android/library/widget/AbsHListView$k;->f:I

    aget-object p1, v0, v1

    iput-object p1, p0, Lit/sephiroth/android/library/widget/AbsHListView$k;->g:Ljava/util/ArrayList;

    iput-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView$k;->e:[Ljava/util/ArrayList;

    return-void
.end method

.method public a(II)V
    .locals 4

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView$k;->d:[Landroid/view/View;

    array-length v0, v0

    if-ge v0, p1, :cond_0

    new-array v0, p1, [Landroid/view/View;

    iput-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView$k;->d:[Landroid/view/View;

    :cond_0
    iput p2, p0, Lit/sephiroth/android/library/widget/AbsHListView$k;->c:I

    iget-object p2, p0, Lit/sephiroth/android/library/widget/AbsHListView$k;->d:[Landroid/view/View;

    const/4 v0, 0x0

    :goto_0
    if-ge v0, p1, :cond_2

    iget-object v1, p0, Lit/sephiroth/android/library/widget/AbsHListView$k;->a:Lit/sephiroth/android/library/widget/AbsHListView;

    invoke-virtual {v1, v0}, Lit/sephiroth/android/library/widget/AbsHListView;->getChildAt(I)Landroid/view/View;

    move-result-object v1

    invoke-virtual {v1}, Landroid/view/View;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v2

    check-cast v2, Lit/sephiroth/android/library/widget/AbsHListView$f;

    if-eqz v2, :cond_1

    iget v2, v2, Lit/sephiroth/android/library/widget/AbsHListView$f;->a:I

    const/4 v3, -0x2

    if-eq v2, v3, :cond_1

    aput-object v1, p2, v0

    :cond_1
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    :cond_2
    return-void
.end method

.method public a(Landroid/view/View;I)V
    .locals 3
    .annotation build Landroid/annotation/SuppressLint;
        value = {
            "NewApi"
        }
    .end annotation

    invoke-virtual {p1}, Landroid/view/View;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v0

    check-cast v0, Lit/sephiroth/android/library/widget/AbsHListView$f;

    if-nez v0, :cond_0

    return-void

    :cond_0
    iput p2, v0, Lit/sephiroth/android/library/widget/AbsHListView$f;->d:I

    iget v0, v0, Lit/sephiroth/android/library/widget/AbsHListView$f;->a:I

    sget v1, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v2, 0x10

    if-lt v1, v2, :cond_1

    invoke-virtual {p1}, Landroid/view/View;->hasTransientState()Z

    move-result v1

    goto :goto_0

    :cond_1
    const/4 v1, 0x0

    :goto_0
    invoke-virtual {p0, v0}, Lit/sephiroth/android/library/widget/AbsHListView$k;->b(I)Z

    move-result v2

    if-eqz v2, :cond_6

    if-eqz v1, :cond_2

    goto :goto_3

    :cond_2
    invoke-virtual {p1}, Landroid/view/View;->onStartTemporaryDetach()V

    iget p2, p0, Lit/sephiroth/android/library/widget/AbsHListView$k;->f:I

    const/4 v1, 0x1

    if-ne p2, v1, :cond_3

    iget-object p2, p0, Lit/sephiroth/android/library/widget/AbsHListView$k;->g:Ljava/util/ArrayList;

    :goto_1
    invoke-virtual {p2, p1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    goto :goto_2

    :cond_3
    iget-object p2, p0, Lit/sephiroth/android/library/widget/AbsHListView$k;->e:[Ljava/util/ArrayList;

    aget-object p2, p2, v0

    goto :goto_1

    :goto_2
    sget p2, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v0, 0xe

    if-lt p2, v0, :cond_4

    const/4 p2, 0x0

    invoke-virtual {p1, p2}, Landroid/view/View;->setAccessibilityDelegate(Landroid/view/View$AccessibilityDelegate;)V

    :cond_4
    iget-object p2, p0, Lit/sephiroth/android/library/widget/AbsHListView$k;->b:Lit/sephiroth/android/library/widget/AbsHListView$l;

    if-eqz p2, :cond_5

    iget-object p2, p0, Lit/sephiroth/android/library/widget/AbsHListView$k;->b:Lit/sephiroth/android/library/widget/AbsHListView$l;

    invoke-interface {p2, p1}, Lit/sephiroth/android/library/widget/AbsHListView$l;->a(Landroid/view/View;)V

    :cond_5
    return-void

    :cond_6
    :goto_3
    const/4 v2, -0x2

    if-ne v0, v2, :cond_7

    if-eqz v1, :cond_9

    :cond_7
    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView$k;->h:Ljava/util/ArrayList;

    if-nez v0, :cond_8

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView$k;->h:Ljava/util/ArrayList;

    :cond_8
    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView$k;->h:Ljava/util/ArrayList;

    invoke-virtual {v0, p1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    :cond_9
    if-eqz v1, :cond_b

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView$k;->i:Landroid/support/v4/util/SparseArrayCompat;

    if-nez v0, :cond_a

    new-instance v0, Landroid/support/v4/util/SparseArrayCompat;

    invoke-direct {v0}, Landroid/support/v4/util/SparseArrayCompat;-><init>()V

    iput-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView$k;->i:Landroid/support/v4/util/SparseArrayCompat;

    :cond_a
    invoke-virtual {p1}, Landroid/view/View;->onStartTemporaryDetach()V

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView$k;->i:Landroid/support/v4/util/SparseArrayCompat;

    invoke-virtual {v0, p2, p1}, Landroid/support/v4/util/SparseArrayCompat;->put(ILjava/lang/Object;)V

    :cond_b
    return-void
.end method

.method public b()V
    .locals 8

    iget v0, p0, Lit/sephiroth/android/library/widget/AbsHListView$k;->f:I

    const/4 v1, 0x0

    const/4 v2, 0x1

    if-ne v0, v2, :cond_0

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView$k;->g:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v2

    const/4 v3, 0x0

    :goto_0
    if-ge v3, v2, :cond_2

    iget-object v4, p0, Lit/sephiroth/android/library/widget/AbsHListView$k;->a:Lit/sephiroth/android/library/widget/AbsHListView;

    add-int/lit8 v5, v2, -0x1

    sub-int/2addr v5, v3

    invoke-virtual {v0, v5}, Ljava/util/ArrayList;->remove(I)Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Landroid/view/View;

    invoke-static {v4, v5, v1}, Lit/sephiroth/android/library/widget/AbsHListView;->a(Lit/sephiroth/android/library/widget/AbsHListView;Landroid/view/View;Z)V

    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    :cond_0
    iget v0, p0, Lit/sephiroth/android/library/widget/AbsHListView$k;->f:I

    const/4 v2, 0x0

    :goto_1
    if-ge v2, v0, :cond_2

    iget-object v3, p0, Lit/sephiroth/android/library/widget/AbsHListView$k;->e:[Ljava/util/ArrayList;

    aget-object v3, v3, v2

    invoke-virtual {v3}, Ljava/util/ArrayList;->size()I

    move-result v4

    const/4 v5, 0x0

    :goto_2
    if-ge v5, v4, :cond_1

    iget-object v6, p0, Lit/sephiroth/android/library/widget/AbsHListView$k;->a:Lit/sephiroth/android/library/widget/AbsHListView;

    add-int/lit8 v7, v4, -0x1

    sub-int/2addr v7, v5

    invoke-virtual {v3, v7}, Ljava/util/ArrayList;->remove(I)Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Landroid/view/View;

    invoke-static {v6, v7, v1}, Lit/sephiroth/android/library/widget/AbsHListView;->b(Lit/sephiroth/android/library/widget/AbsHListView;Landroid/view/View;Z)V

    add-int/lit8 v5, v5, 0x1

    goto :goto_2

    :cond_1
    add-int/lit8 v2, v2, 0x1

    goto :goto_1

    :cond_2
    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView$k;->i:Landroid/support/v4/util/SparseArrayCompat;

    if-eqz v0, :cond_3

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView$k;->i:Landroid/support/v4/util/SparseArrayCompat;

    invoke-virtual {v0}, Landroid/support/v4/util/SparseArrayCompat;->clear()V

    :cond_3
    return-void
.end method

.method public b(I)Z
    .locals 0

    if-ltz p1, :cond_0

    const/4 p1, 0x1

    return p1

    :cond_0
    const/4 p1, 0x0

    return p1
.end method

.method public c(I)Landroid/view/View;
    .locals 3

    iget v0, p0, Lit/sephiroth/android/library/widget/AbsHListView$k;->c:I

    sub-int/2addr p1, v0

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView$k;->d:[Landroid/view/View;

    const/4 v1, 0x0

    if-ltz p1, :cond_0

    array-length v2, v0

    if-ge p1, v2, :cond_0

    aget-object v2, v0, p1

    aput-object v1, v0, p1

    return-object v2

    :cond_0
    return-object v1
.end method

.method c()V
    .locals 1

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView$k;->i:Landroid/support/v4/util/SparseArrayCompat;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView$k;->i:Landroid/support/v4/util/SparseArrayCompat;

    invoke-virtual {v0}, Landroid/support/v4/util/SparseArrayCompat;->clear()V

    :cond_0
    return-void
.end method

.method d(I)Landroid/view/View;
    .locals 2

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView$k;->i:Landroid/support/v4/util/SparseArrayCompat;

    const/4 v1, 0x0

    if-nez v0, :cond_0

    return-object v1

    :cond_0
    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView$k;->i:Landroid/support/v4/util/SparseArrayCompat;

    invoke-virtual {v0, p1}, Landroid/support/v4/util/SparseArrayCompat;->indexOfKey(I)I

    move-result p1

    if-gez p1, :cond_1

    return-object v1

    :cond_1
    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView$k;->i:Landroid/support/v4/util/SparseArrayCompat;

    invoke-virtual {v0, p1}, Landroid/support/v4/util/SparseArrayCompat;->valueAt(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/view/View;

    iget-object v1, p0, Lit/sephiroth/android/library/widget/AbsHListView$k;->i:Landroid/support/v4/util/SparseArrayCompat;

    invoke-virtual {v1, p1}, Landroid/support/v4/util/SparseArrayCompat;->removeAt(I)V

    return-object v0
.end method

.method public d()V
    .locals 5

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView$k;->h:Ljava/util/ArrayList;

    if-nez v0, :cond_0

    return-void

    :cond_0
    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView$k;->h:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    const/4 v1, 0x0

    const/4 v2, 0x0

    :goto_0
    if-ge v2, v0, :cond_1

    iget-object v3, p0, Lit/sephiroth/android/library/widget/AbsHListView$k;->a:Lit/sephiroth/android/library/widget/AbsHListView;

    iget-object v4, p0, Lit/sephiroth/android/library/widget/AbsHListView$k;->h:Ljava/util/ArrayList;

    invoke-virtual {v4, v2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Landroid/view/View;

    invoke-static {v3, v4, v1}, Lit/sephiroth/android/library/widget/AbsHListView;->c(Lit/sephiroth/android/library/widget/AbsHListView;Landroid/view/View;Z)V

    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    :cond_1
    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView$k;->h:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->clear()V

    return-void
.end method

.method e(I)Landroid/view/View;
    .locals 2

    iget v0, p0, Lit/sephiroth/android/library/widget/AbsHListView$k;->f:I

    const/4 v1, 0x1

    if-ne v0, v1, :cond_0

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView$k;->g:Ljava/util/ArrayList;

    :goto_0
    invoke-static {v0, p1}, Lit/sephiroth/android/library/widget/AbsHListView;->a(Ljava/util/ArrayList;I)Landroid/view/View;

    move-result-object p1

    return-object p1

    :cond_0
    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView$k;->a:Lit/sephiroth/android/library/widget/AbsHListView;

    iget-object v0, v0, Lit/sephiroth/android/library/widget/AbsHListView;->j:Landroid/widget/ListAdapter;

    invoke-interface {v0, p1}, Landroid/widget/ListAdapter;->getItemViewType(I)I

    move-result v0

    if-ltz v0, :cond_1

    iget-object v1, p0, Lit/sephiroth/android/library/widget/AbsHListView$k;->e:[Ljava/util/ArrayList;

    array-length v1, v1

    if-ge v0, v1, :cond_1

    iget-object v1, p0, Lit/sephiroth/android/library/widget/AbsHListView$k;->e:[Ljava/util/ArrayList;

    aget-object v0, v1, v0

    goto :goto_0

    :cond_1
    const/4 p1, 0x0

    return-object p1
.end method

.method public e()V
    .locals 12
    .annotation build Landroid/annotation/SuppressLint;
        value = {
            "NewApi"
        }
    .end annotation

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView$k;->d:[Landroid/view/View;

    iget-object v1, p0, Lit/sephiroth/android/library/widget/AbsHListView$k;->b:Lit/sephiroth/android/library/widget/AbsHListView$l;

    const/4 v2, 0x0

    const/4 v3, 0x1

    if-eqz v1, :cond_0

    const/4 v1, 0x1

    goto :goto_0

    :cond_0
    const/4 v1, 0x0

    :goto_0
    iget v4, p0, Lit/sephiroth/android/library/widget/AbsHListView$k;->f:I

    if-le v4, v3, :cond_1

    const/4 v4, 0x1

    goto :goto_1

    :cond_1
    const/4 v4, 0x0

    :goto_1
    iget-object v5, p0, Lit/sephiroth/android/library/widget/AbsHListView$k;->g:Ljava/util/ArrayList;

    array-length v6, v0

    sub-int/2addr v6, v3

    :goto_2
    if-ltz v6, :cond_b

    aget-object v3, v0, v6

    if-eqz v3, :cond_a

    invoke-virtual {v3}, Landroid/view/View;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v7

    check-cast v7, Lit/sephiroth/android/library/widget/AbsHListView$f;

    iget v8, v7, Lit/sephiroth/android/library/widget/AbsHListView$f;->a:I

    const/4 v9, 0x0

    aput-object v9, v0, v6

    sget v10, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v11, 0x10

    if-lt v10, v11, :cond_2

    invoke-virtual {v3}, Landroid/view/View;->hasTransientState()Z

    move-result v10

    goto :goto_3

    :cond_2
    const/4 v10, 0x0

    :goto_3
    invoke-virtual {p0, v8}, Lit/sephiroth/android/library/widget/AbsHListView$k;->b(I)Z

    move-result v11

    if-eqz v11, :cond_6

    if-eqz v10, :cond_3

    goto :goto_4

    :cond_3
    if-eqz v4, :cond_4

    iget-object v5, p0, Lit/sephiroth/android/library/widget/AbsHListView$k;->e:[Ljava/util/ArrayList;

    aget-object v5, v5, v8

    :cond_4
    invoke-virtual {v3}, Landroid/view/View;->onStartTemporaryDetach()V

    iget v8, p0, Lit/sephiroth/android/library/widget/AbsHListView$k;->c:I

    add-int/2addr v8, v6

    iput v8, v7, Lit/sephiroth/android/library/widget/AbsHListView$f;->d:I

    invoke-virtual {v5, v3}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    sget v7, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v8, 0xe

    if-lt v7, v8, :cond_5

    invoke-virtual {v3, v9}, Landroid/view/View;->setAccessibilityDelegate(Landroid/view/View$AccessibilityDelegate;)V

    :cond_5
    if-eqz v1, :cond_a

    iget-object v7, p0, Lit/sephiroth/android/library/widget/AbsHListView$k;->b:Lit/sephiroth/android/library/widget/AbsHListView$l;

    invoke-interface {v7, v3}, Lit/sephiroth/android/library/widget/AbsHListView$l;->a(Landroid/view/View;)V

    goto :goto_5

    :cond_6
    :goto_4
    const/4 v7, -0x2

    if-ne v8, v7, :cond_7

    if-eqz v10, :cond_8

    :cond_7
    iget-object v7, p0, Lit/sephiroth/android/library/widget/AbsHListView$k;->a:Lit/sephiroth/android/library/widget/AbsHListView;

    invoke-static {v7, v3, v2}, Lit/sephiroth/android/library/widget/AbsHListView;->d(Lit/sephiroth/android/library/widget/AbsHListView;Landroid/view/View;Z)V

    :cond_8
    if-eqz v10, :cond_a

    iget-object v7, p0, Lit/sephiroth/android/library/widget/AbsHListView$k;->i:Landroid/support/v4/util/SparseArrayCompat;

    if-nez v7, :cond_9

    new-instance v7, Landroid/support/v4/util/SparseArrayCompat;

    invoke-direct {v7}, Landroid/support/v4/util/SparseArrayCompat;-><init>()V

    iput-object v7, p0, Lit/sephiroth/android/library/widget/AbsHListView$k;->i:Landroid/support/v4/util/SparseArrayCompat;

    :cond_9
    iget-object v7, p0, Lit/sephiroth/android/library/widget/AbsHListView$k;->i:Landroid/support/v4/util/SparseArrayCompat;

    iget v8, p0, Lit/sephiroth/android/library/widget/AbsHListView$k;->c:I

    add-int/2addr v8, v6

    invoke-virtual {v7, v8, v3}, Landroid/support/v4/util/SparseArrayCompat;->put(ILjava/lang/Object;)V

    :cond_a
    :goto_5
    add-int/lit8 v6, v6, -0x1

    goto :goto_2

    :cond_b
    invoke-direct {p0}, Lit/sephiroth/android/library/widget/AbsHListView$k;->f()V

    return-void
.end method

.method f(I)V
    .locals 7

    iget v0, p0, Lit/sephiroth/android/library/widget/AbsHListView$k;->f:I

    const/4 v1, 0x0

    const/4 v2, 0x1

    if-ne v0, v2, :cond_0

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView$k;->g:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v2

    const/4 v3, 0x0

    :goto_0
    if-ge v3, v2, :cond_2

    invoke-virtual {v0, v3}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Landroid/view/View;

    invoke-virtual {v4, p1}, Landroid/view/View;->setDrawingCacheBackgroundColor(I)V

    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    :cond_0
    iget v0, p0, Lit/sephiroth/android/library/widget/AbsHListView$k;->f:I

    const/4 v2, 0x0

    :goto_1
    if-ge v2, v0, :cond_2

    iget-object v3, p0, Lit/sephiroth/android/library/widget/AbsHListView$k;->e:[Ljava/util/ArrayList;

    aget-object v3, v3, v2

    invoke-virtual {v3}, Ljava/util/ArrayList;->size()I

    move-result v4

    const/4 v5, 0x0

    :goto_2
    if-ge v5, v4, :cond_1

    invoke-virtual {v3, v5}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Landroid/view/View;

    invoke-virtual {v6, p1}, Landroid/view/View;->setDrawingCacheBackgroundColor(I)V

    add-int/lit8 v5, v5, 0x1

    goto :goto_2

    :cond_1
    add-int/lit8 v2, v2, 0x1

    goto :goto_1

    :cond_2
    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView$k;->d:[Landroid/view/View;

    array-length v2, v0

    :goto_3
    if-ge v1, v2, :cond_4

    aget-object v3, v0, v1

    if-eqz v3, :cond_3

    invoke-virtual {v3, p1}, Landroid/view/View;->setDrawingCacheBackgroundColor(I)V

    :cond_3
    add-int/lit8 v1, v1, 0x1

    goto :goto_3

    :cond_4
    return-void
.end method

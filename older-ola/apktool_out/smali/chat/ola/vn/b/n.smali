.class public Lchat/ola/vn/b/n;
.super Lchat/ola/vn/b/j;


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lchat/ola/vn/b/j<",
        "Lchat/ola/vn/message/f;",
        ">;"
    }
.end annotation


# instance fields
.field protected a:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lchat/ola/vn/message/f;",
            ">;"
        }
    .end annotation
.end field

.field private b:Landroid/view/LayoutInflater;


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 0

    invoke-direct {p0, p1}, Lchat/ola/vn/b/j;-><init>(Landroid/content/Context;)V

    return-void
.end method

.method private a()Landroid/view/LayoutInflater;
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/b/n;->b:Landroid/view/LayoutInflater;

    if-nez v0, :cond_0

    invoke-static {}, Lchat/ola/vn/OlaApplication;->a()Landroid/content/Context;

    move-result-object v0

    const-string v1, "layout_inflater"

    invoke-virtual {v0, v1}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/view/LayoutInflater;

    iput-object v0, p0, Lchat/ola/vn/b/n;->b:Landroid/view/LayoutInflater;

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/b/n;->b:Landroid/view/LayoutInflater;

    return-object v0
.end method


# virtual methods
.method public a(ILandroid/view/View;Landroid/view/ViewGroup;)Landroid/view/View;
    .locals 7

    :try_start_0
    invoke-virtual {p0, p1}, Lchat/ola/vn/b/n;->a(I)Lchat/ola/vn/message/f;

    move-result-object v0

    const/4 v1, 0x0

    if-nez p2, :cond_0

    invoke-direct {p0}, Lchat/ola/vn/b/n;->a()Landroid/view/LayoutInflater;

    move-result-object v2

    const v3, 0x7f0b0075

    invoke-virtual {v2, v3, v1}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object v2
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_3

    :try_start_1
    new-instance p2, Lchat/ola/vn/g/k;

    invoke-direct {p2, v0, v2}, Lchat/ola/vn/g/k;-><init>(Lchat/ola/vn/message/f;Landroid/view/View;)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    move-object v6, v2

    move-object v2, p2

    move-object p2, v6

    goto :goto_0

    :catch_0
    move-exception p1

    move-object p2, v2

    goto :goto_4

    :cond_0
    :try_start_2
    invoke-virtual {p2}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v2

    if-nez v2, :cond_1

    new-instance v2, Lchat/ola/vn/g/k;

    invoke-direct {v2, v0, p2}, Lchat/ola/vn/g/k;-><init>(Lchat/ola/vn/message/f;Landroid/view/View;)V

    goto :goto_0

    :cond_1
    invoke-virtual {p2}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lchat/ola/vn/g/k;

    :goto_0
    invoke-virtual {v2, v0}, Lchat/ola/vn/g/k;->a(Lchat/ola/vn/message/f;)V

    const/4 v0, 0x1

    iput-boolean v0, v2, Lchat/ola/vn/g/k;->k:Z

    const/4 v3, 0x0

    iput-boolean v3, v2, Lchat/ola/vn/g/k;->l:Z

    invoke-virtual {p2, v2}, Landroid/view/View;->setTag(Ljava/lang/Object;)V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_3

    add-int/lit8 v4, p1, -0x1

    :try_start_3
    invoke-virtual {p0, v4}, Lchat/ola/vn/b/n;->a(I)Lchat/ola/vn/message/f;

    move-result-object v4
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_1

    goto :goto_1

    :catch_1
    move-object v4, v1

    :goto_1
    add-int/lit8 v5, p1, 0x1

    :try_start_4
    invoke-virtual {p0, v5}, Lchat/ola/vn/b/n;->a(I)Lchat/ola/vn/message/f;

    move-result-object v5
    :try_end_4
    .catch Ljava/lang/Throwable; {:try_start_4 .. :try_end_4} :catch_2

    move-object v1, v5

    :catch_2
    if-eqz v4, :cond_2

    :try_start_5
    invoke-virtual {v2, v3}, Lchat/ola/vn/g/k;->b(Z)V

    goto :goto_2

    :cond_2
    invoke-virtual {v2, v0}, Lchat/ola/vn/g/k;->b(Z)V

    :goto_2
    if-eqz v1, :cond_3

    invoke-virtual {v2, v3}, Lchat/ola/vn/g/k;->a(Z)V

    goto :goto_3

    :cond_3
    invoke-virtual {v2, v0}, Lchat/ola/vn/g/k;->a(Z)V

    :goto_3
    invoke-virtual {v2, p1}, Lchat/ola/vn/g/k;->a(I)V
    :try_end_5
    .catch Ljava/lang/Throwable; {:try_start_5 .. :try_end_5} :catch_3

    goto :goto_5

    :catch_3
    move-exception p1

    :goto_4
    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    :goto_5
    if-nez p2, :cond_4

    return-object p3

    :cond_4
    return-object p2
.end method

.method public a(I)Lchat/ola/vn/message/f;
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/b/n;->a:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/message/f;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object p1

    :catch_0
    const/4 p1, 0x0

    return-object p1
.end method

.method public a(Ljava/util/List;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lchat/ola/vn/message/f;",
            ">;)V"
        }
    .end annotation

    if-nez p1, :cond_0

    return-void

    :cond_0
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0, p1}, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V

    iput-object v0, p0, Lchat/ola/vn/b/n;->a:Ljava/util/List;

    return-void
.end method

.method public getCount()I
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/b/n;->a:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return v0

    :catch_0
    const/4 v0, 0x0

    return v0
.end method

.method public synthetic getItem(I)Ljava/lang/Object;
    .locals 0

    invoke-virtual {p0, p1}, Lchat/ola/vn/b/n;->a(I)Lchat/ola/vn/message/f;

    move-result-object p1

    return-object p1
.end method

.method public getViewTypeCount()I
    .locals 1

    const/4 v0, 0x1

    return v0
.end method
